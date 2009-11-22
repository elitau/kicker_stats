module MatchesHelper
  
  module ViewAttributes
    def caption
      yellow = "<span style=\"background-color: yellow\">#{yellow_team.usernames}</span>"
      yellow_goals = "<span style=\"background-color: yellow\">#{self.yellow_goals}</span>"
      "#{yellow} vs. #{white_player.usernames}: #{yellow_goals} zu #{self.white_goals}"
    end
  end
  
  
  def games_with_matches_list(games)
    te_grouped_list()
  end
  
  
  def matches_list(matches)
    view_matches = add_view_attributes(matches)
    # te_list(view_matches)
    te_grouped_list(view_matches.reverse){ |match| I18n.l(match.created_at.to_date, :format => :iphone) }
  end
  
  def add_view_attributes(matches)
    matches.each do |match|
      match.extend ViewAttributes
      match.send(:instance_eval, %Q{
        def url
          "#{match_path(match)}"
        end
      })
    end
  end
  
  
  
  
end
