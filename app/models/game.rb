class Game < ActiveRecord::Base
  validates_inclusion_of :best_of, :in => [1,3],
                         :message => "{{value}} is not a valid option"

  has_many :matches, :dependent => :destroy
  
  def self.create_game(best_of)
    game = Game.create(:best_of => best_of)
    return game
  end

  def winner_names
    winner_names = get_winner.first
  end

  def winner_ids
    winner_ids = get_winner[1]
  end

  private

  def get_winner
    @matches = self.matches

    case self.best_of
      when 1
        @match = @matches.first
        winner_color = @match.match_winner
        @match.team_player_names_and_ids_by_color(winner_color)
      when 3
        if @matches[0].match_winner != @matches[1].match_winner
          @matches[0].team_player_names_and_ids_by_color(@matches[0].match_winner)
        else
          @matches[2].team_player_names_and_ids_by_color(@matches[2].match_winner)
        end
      else
        puts "The use of more than 3 matches is not implemented"
    end
  end

end
