class Statistic
  
  attr_accessor :date, :value
  
  def initialize(options)
    @date  = options[:date]
    @value = options[:value]
  end
  
  def self.create_weekly_statistics_for(player)
    weekly_packaged_matches = self.create_weekly_packaged_matches(player.matches)
    
    statistics = weekly_packaged_matches.collect do |a_weeks_matches|
      self.new(
        :date => a_weeks_matches.first.created_at, 
        :value => a_weeks_matches.sum{|match| match.winner?(player) ? 1 : 0}
      )
    end
    return statistics
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