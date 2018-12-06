
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
  @books = Book.all()
  erb(:book_list)
end

get('/patron') do
  @patrons = Patron.all()
  erb(:patron)
end

get('/librarian') do
  @books = Book.all()
  @patrons = Patron.all()
  erb(:librarian)
end

get('/author') do
  erb(:author)
end

post('/patron') do
  name = params.fetch("name")
  patron = Patron.new({:name => name, :checkout_books => nil, :id => nil})
  patron.save()
  @patrons = Patron.all()
  erb(:patron)
end

post('/delete_patron/:id') do
  patron_id = Patron.find(params.fetch("id").to_i())
  patron_id.delete()
  @patrons = Patron.all()
  erb(:patron)
end

get('/patrons/:id') do
  @patron = Patron.find(params.fetch("id").to_i())
  @patrons = Patron.all()
  erb(:patron_info)
end

get('/add_book') do
  @books = Book.all()
  @patrons = Patron.all()
  erb(:librarian)
end

post('/add_book') do
  title = params.fetch("title")
  author = params.fetch("author")
  status = params.fetch("status")
  book = Book.new({:title => title, :author => author, :status => status, :id => nil})
  book.save()
  @books = Book.all()
  @patrons = Patron.all()
  erb(:librarian)
end
