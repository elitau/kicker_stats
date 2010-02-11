class Game < ActiveRecord::Base
  validates_inclusion_of :best_of, :in => [1,3],
                         :message => "{{value}} is not a valid option"

  default_scope order('created_at DESC')

  has_many :matches, :dependent => :destroy do
    def create_match(params)
      match = proxy_owner.matches.build(
        :white_goals      => params[:white_goals],
        :yellow_goals     => params[:yellow_goals]
      )
      match.save
      match.teams.create_colored_team(params[:white_player_ids], "white")
      match.teams.create_colored_team(params[:yellow_player_ids], "yellow")
      match.check_for_creep_and_twitter_it
      return match
    end
  end
  
  
  def self.create_game_with_matches_and_teams(params)
    @game = Game.create(:best_of => params[:best_of])
    @game.matches.create_match(params)
    return @game
  end
  
  def winner?(player_or_players)
    return false unless winner_players
    if player_or_players.is_a?(Array)
      winner_players.sort == player_or_players.sort
    else
      winner_players.include?(player_or_players)
    end
  end
  
  def finished?
    if self.winner_players.blank?
      return false
    else
      self.twitter_game_results
      return true
    end
  end
  
  def results_for_twitter
    join_word = (winner_players.size > 1 ? "haben" : "hat")
    "#{winner_players.collect(&:username).join(" und ")} #{join_word} #{looser_players.collect(&:username).join(" und ")} besiegt. #kicker"
  end
  
  def players
    self.matches.collect(&:players).flatten.uniq
  end
  
  def looser_players
    players - winner_players
  end
  
  # returns nil if the winner could not be calculated (this happen on best_of
  # = 3 and only two matches played until now)
  def winner_players
    if best_of == 1
      self.matches.first.winner_players
    else
      match_winner_players = self.matches.collect(&:winner_players)
      if match_winner_players[0] == match_winner_players[1]
        match_winner_players[0]
      elsif self.matches.size < 3
        []
      else
        match_winner_players[2]
      end
    end
  end
  
  def twitter_game_results
    TwitterClient.update(self.results_for_twitter)
  end
  
  def single?
    self.matches.first.single?
  end
  
  def double?
    self.matches.first.double?
  end
  
  # def next_match
  #   return self.matches.build(:white_players => "value", )
  # end
end
