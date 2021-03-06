class Statistic
  
  extend ApplicationHelper
  extend ActionView::Helpers::TagHelper
  
  attr_accessor :date, :value, :name
  
  def initialize(options)
    @date  = options[:date]
    @value = options[:value]
    @name  = options[:name]
  end
  
  def self.create_weekly_statistics_for(player)
    return [] if player.matches.empty?
    weekly_packaged_matches = self.create_weekly_packaged_matches(player.matches)
    
    statistics = weekly_packaged_matches.collect do |a_weeks_matches|
      next if a_weeks_matches.blank?
      self.new(
        :date => a_weeks_matches.first.created_at, 
        :value => a_weeks_matches.sum{|match| match.winner?(player) ? 1 : 0}
      )
    end
    return statistics.compact
  end
  
  def self.create_detailed_statistics_for(player)
    return [
      self.new(:name => :all_winning_games, :value => player.all_winning_games.size),
      self.new(:name => :all_winning_matches, :value => player.all_winning_matches.size),
      self.new(:name => :all_lost_games, :value => player.all_lost_games.size),
      self.new(:name => :all_lost_matches, :value => player.all_lost_matches.size),
      self.new(:name => :goals_shot, :value => player.goals_shot),
      self.new(:name => :sucked_goals, :value => player.sucked_goals),
      self.new(:name => :goals_ratio, :value => show_goals_ratio(player))
    ]
  end
  
  # takes matches that are ordered by date, oldest first
  def self.create_weekly_packaged_matches(matches)
    # ersten tag der ersten woche finden:
    switching_monday = matches.first.created_at.monday
    match_packages = []
    while switching_monday < (Time.now.monday + 1.week)
      match_packages << self.get_matches_for_period(matches, switching_monday..(switching_monday+1.week))
      switching_monday += 1.week
    end
    return match_packages
  end
  
  def self.get_matches_for_period(matches, period)
    matches.select{|match| period.include?(match.created_at)}
  end
    
end