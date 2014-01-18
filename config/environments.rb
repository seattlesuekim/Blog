class Blog < Sinatra::Base
  configure :production, :development do
  db = URI.parse(ENV['DATABASE_URL'] || "postgres://localhost/v-db")

  ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
  end
end


#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path


