# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def breadcrumbs
    return "" unless @breadcrumbs
    @breadcrumbs.map do |item|
      link_to item[:title], item[:url]
    end.join(" &raquo;\n")
  end
  
  def language_links
    active_locale = I18n.locale.to_s
    locale_names = { 'fi' => 'Suomeksi', 'en' => 'In English' }
    locale_names.keys.sort.map do |locale|
      ( locale == active_locale ) ? 
        locale_names[locale] : 
        link_to( locale_names[locale], locale_path(locale) )
    end.join( ' | ' )
  end
end
