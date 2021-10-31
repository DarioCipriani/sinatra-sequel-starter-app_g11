require 'bundler'
require 'sinatra'
require 'sequel'
# agrega la visibilidad de las columnas de update_at y created_at al modelo
Sequel::Model.plugin :timestamps, create: :created_on, update: :updated_on, update_on_create: true
Bundler.require

# Create a connection and leave it as a global object in our project
DB = Sequel.connect(
  adapter: 'postgres',
  database: 'vocational-test',
  host: 'db',
  user: 'unicorn',
  password: 'magic'
)

# Require and run the main app
root = ::File.dirname(__FILE__)
require ::File.join(root, 'app')
run App.new
