# Use this file to load your own seed data from extensions.  
# See the db/seeds.rb file in the Spree core for some ideas on what you can do here.
#
Rake::Task["db:load_dir"].invoke( "default" )
puts "Default data has been loaded"

puts "Create Taxonomy"

t = Taxonomy.create :name => "Products"

