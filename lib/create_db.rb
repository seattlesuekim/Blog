require 'sequel'

db = Sequel.connect('sqlite://questions.db')

db.create_table(:questions) do
  primary_key :id
  string :ask
end