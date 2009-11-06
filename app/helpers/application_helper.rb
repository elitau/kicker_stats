# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(title_content)
    content_for(:title) do
      title_content
    end
  end
  
end
