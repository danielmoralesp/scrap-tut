class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def scrape_tiempo
    require 'open-uri'
    tiempo = Nokogiri::HTML(open("http://www.eltiempo.com/"))
    render text: tiempo
  end
end
