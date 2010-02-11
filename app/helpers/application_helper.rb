module ApplicationHelper
  def title(title_content)
    content_for(:title) do
      title_content
    end
  end

  def select_with_integer_options (name, start, stop, default = nil)
    output = "<select name=#{name} id=#{name}>"
    for i in start..stop
      output << "\n<option value=\"#{i}\""  
      output << " selected=\"selected\"" if i == default
      output << ">#{i}"
    end
    output + "</select>"
  end
  
  def show_names_of_players(players)
    return "Nobody" if players.blank?
    players.collect(&:username).join(", ")
  end

  def show_names_of_game_players(match)
    [show_names_of_players(match.white_players),
     show_names_of_players(match.yellow_players)].join(" vs. ")
  end
  
  def link_to_player(player)
    link_to("#{h(player.username)} (#{show_goals_ratio(player.goals_ratio)})", player)
  end
  
  def link_to_players(players)
    players.collect do |player|
      link_to_player(player)
    end.join(", ")
  end
  
  def show_goals_ratio(goals_ratio)
    css_class = if goals_ratio < 0
      "red"
    elsif goals_ratio > 0
      "green"
    else
      "black"
    end
    content_tag(:span, goals_ratio, :class => css_class)
  end
  
  def goals_select_options
    options_for_select((0..6).collect{|i| [i.to_s, i.to_s]}, :selected => "6")
  end
end
