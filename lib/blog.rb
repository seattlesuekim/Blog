require 'sinatra/base'
require 'sinatra/captcha'
require 'ostruct'
require 'time'
require 'yaml'
require 'redcarpet'
require 'sequel'
require 'httparty'
require_relative 'captcha'
require 'sinatra/activerecord'
require './config/environments' # database config
require './lib/visitor'
require 'sinatra/cookies'

class Blog < Sinatra::Base
  helpers Sinatra::Cookies

# Questions database -- move to environments.rb
  configure :development do
    before do
      @db = Sequel.connect('sqLite://questions.db')
      @questions = @db[:questions]
    end
  end

  configure :production do
    before do
      @db = Sequel.connect(ENV['DATABASE_URL'])
      @questions = @db[:questions]
    end
  end

  ##############################################

  set :database, "sqlite3:///questions.db"
  set :root, File.expand_path('../../', __FILE__)
  set :articles, []
  set :app_file, __FILE__


  # loop through all the article files
  Dir.glob "#{root}/articles/*.html" do |file|
    # parse meta data and content from file
    meta, content   = File.read(file).split("\n\n", 2)
    article         = OpenStruct.new YAML.load(meta)
    article.date    = Time.parse article.date.to_s
    article.content = content
    article.slug    = File.basename(file, '.html')

    # set up the route
    get "/#{article.slug}" do
      erb :post, :locals => { :article => article }
    end

    # Add article to list of articles
    articles << article
  end

  # Sort articles by date, display new articles first
  articles.sort_by! { |article| article.date}
  articles.reverse!

  get '/' do
    # check for cookies
    if cookies[:remember_token]
      @visitor = Visitor.find_by!(remember_token: cookies[:remember_token])
      @visitor.visits += 1
    else
      @visitor = Visitor.new
      @visitor.visits = 1
      # give the new visitor a cookie
      @visitor.remember_token = (0..8).map { (65 + rand(26)).chr }.join
      cookies[:remember_token] = @visitor.remember_token
    end
    @visitor.save

    erb :index
  end


  # Sidebar Links: About, Ask, and Contact pages
  get'/about' do
    erb :about
  end

  get '/ask' do
    erb :ask
  end

  get '/analytics' do
    @new_visitors = 0
    @return_visitors = 0
    Visitor.all.each { |visitor|
      if visitor.visits == 1
        @new_visitors += 1
      else
        @return_visitors += 1
      end
    }
    @total_visitors = @new_visitors + @return_visitors
    erb :analytics
  end

  post '/ask' do
    @code = params[:code]
    captcha = Captcha.new()
    if captcha.check_captcha(@code)
      @questions.insert(ask: params[:ask])
    end
    redirect back
  end

  get '/russian' do
    erb :russian, :layout => :russian_layout
  end

  get '/contact' do
    erb :contact
  end
end


