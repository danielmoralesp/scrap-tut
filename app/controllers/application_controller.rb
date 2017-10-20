class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Define the Article object
  class Article
    def initialize(title, link)
      @title = title
      @link = link
    end
    attr_reader :title
    attr_reader :link
  end

  def scrape_tiempo
    #require 'open-uri'
    #tiempo = Nokogiri::HTML(open("http://www.eltiempo.com/"))
    #render text: tiempo

    # Pull in the page
    require 'open-uri'
    tiempo = Nokogiri::HTML(open("http://www.eltiempo.com/"))

    # Narrow down on what we want and build the articles array
    articles = tiempo.css('.article-details')
    @articlesArray = []
    articles.each do |article|
      title = article.css('h3.title-container>a').text
      link = article.css('h3.title-container>a')[0]['href']
      @articlesArray << Article.new(title, link)
    end

    # We'll just try to render the array and see what happens
    render template: 'scrape_tiempo'
  end
end
