require 'sinatra/base'
require 'sinatra/captcha'
require 'ostruct'
require 'time'
require 'yaml'
require 'redcarpet'
require 'sequel'
require 'httparty'
require_relative 'captcha'

class Blog < Sinatra::Base

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


  set :database, "sqlite3:///questions.db"


  set :root, File.expand_path('../../', __FILE__)
  set :articles, []
  set :app_file, __FILE__

  # loop through all the article files
  Dir.glob "#{root}/articles/*.md" do |file|
    # parse meta data and content from file
    meta, content   = File.read(file).split("\n\n", 2)
    article         = OpenStruct.new YAML.load(meta)
    article.date    = Time.parse article.date.to_s
    article.content = content
    article.slug    = File.basename(file, '.md')

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
    erb :index
  end

  # Sidebar Links: About, Ask, and Contact pages
  get'/about' do
    erb :about
  end

  get '/ask' do
    erb :ask
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


