
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/author')
require('./lib/book')
require('./lib/checkout')
require('./lib/patron')
require('pry')

get('/') do
  erb(:index)
end

get('/book_list') do
  erb(:book_list)
end

get('/patron') do
  @patrons = Patron.all()
  erb(:patron)
end

get('/librarian') do
  erb(:librarian)
end

get('/author') do
  erb(:author)
end

post("/patron") do
  name = params.fetch("name")
  patron = Patron.new({:name => name, :checkout_books => nil, :id => nil})
  patron.save()
  @patrons = Patron.all()
  erb(:patron)
end
