
require 'csv'


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# before running "rake db:seed", do the following:
# - put the "rails-engine-development.pgdump" file in db/data/
# - put the "items.csv" file in db/data/

cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)

# TODO
# - Import the CSV data into the Items table
data = CSV.parse(File.new('/Users/aidan/turing/3mod/projects/rails_engine_pack/rails-engine/db/data/items.csv'), headers: true)

data.each do |row|
  # require 'pry'; binding.pry
  Item.create!(row.to_h)
end
# - Add code to reset the primary key sequences on all 6 tables (merchants, items, customers, invoices, invoice_items, transactions)

ActiveRecord::Base.connection.reset_pk_sequence!('items')
