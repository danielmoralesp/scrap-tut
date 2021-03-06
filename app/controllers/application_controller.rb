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
    def initialize(title, link, img_url)
      @title = title
      @link = link
      @img = img_url
    end
    attr_reader :title
    attr_reader :link
    attr_reader :img_url
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
      img_url = toon.css('a>img').attr('src')
      @toonsArray << Toon.new(title, link, img_url)

      # download image code
      path = File.join Rails.root, 'app', 'assets', 'images', "#{title}.jpeg"
      @img_url_2 = "http://www.eltiempo.com/#{img_url}"
      File.open(path, 'wb') do |new_file|
        open(@img_url_2, 'r') do |img|
          new_file.write(img.read)
        end
      end
    end

    # We'll just try to render the array and see what happens
    render template: 'scrape_toons'
  end

end
