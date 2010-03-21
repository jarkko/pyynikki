# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def breadcrumbs
    return "" unless @breadcrumbs
    @breadcrumbs.map do |item|
      link_to item[:title], item[:url]
    end.join(" &raquo;\n")
  end
end
