class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Define the Article object
  # class Article
  #   def initialize(title, link)
  #     @title = title
  #     @link = link
  #   end
  #   attr_reader :title
  #   attr_reader :link
  # end

  # def scrape_tiempo
  #   #require 'open-uri'
  #   #tiempo = Nokogiri::HTML(open("http://www.eltiempo.com/"))
  #   #render text: tiempo
  #
  #   # Pull in the page
  #   require 'open-uri'
  #   tiempo = Nokogiri::HTML(open("http://www.eltiempo.com/"))
  #
  #   # Narrow down on what we want and build the articles array
  #   articles = tiempo.css('.article-details')
  #   @articlesArray = []
  #   articles.each do |article|
  #     title = article.css('h3.title-container>a').text
  #     link = article.css('h3.title-container>a')[0]['href']
  #     @articlesArray << Article.new(title, link)
  #   end
  #
  #   # We'll just try to render the array and see what happens
  #   render template: 'scrape_tiempo'
  # end

  # Define the Toon object
  class Toon
    def initialize(title, link, img)
      @title = title
      @link = link
      @img = img
    end
    attr_reader :title
    attr_reader :link
    attr_reader :img
  end

  def scrape_toons
    #require 'open-uri'
    #tiempo = Nokogiri::HTML(open("http://www.eltiempo.com/"))
    #render text: tiempo

    # Pull in the page
    require 'open-uri'
    tiempo = Nokogiri::HTML(open("http://www.eltiempo.com/opinion/caricaturas"))

    # Narrow down on what we want and build the toons array
    toons = tiempo.css('.col-main-article')
    @toonsArray = []
    toons.each do |toon|
      title = toon.css('h3>a').text
      link = toon.css('a')[0]['href']
      img = toon.css('a>img').attr('src')
      @toonsArray << Toon.new(title, link, img)
    end

    # We'll just try to render the array and see what happens
    render template: 'scrape_toons'
  end

end
