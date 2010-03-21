# coding: utf-8

module EventsHelper
  def temperature(event)
    css_class = event.temperature < 0 ? "minus" : "plus"
    content_tag(:dd, "#{event.temperature_with_sign}°C", :class => css_class)
  end
end
