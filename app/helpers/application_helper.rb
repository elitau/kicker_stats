# Methods added to this helper will be available to all templates in the application.
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
end
