
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

get('/librarian') do
  @books = Book.all()
  @patrons = Patron.all()
  erb(:librarian)
end

get('/patron') do
  @patrons = Patron.all()
  erb(:patron)
end

post('/patron') do
  name = params.fetch("name")
  patron = Patron.new({:name => name, :checkout_books => nil, :id => nil})
  patron.save()
  @patrons = Patron.all()
  erb(:patron)
end

get('/author') do
  @authors = Author.all()
  erb(:author)
end

post('/author') do
  name = params.fetch("name")
  books = params.fetch("books")
  author = Author.new({:name => name, :books => books, :id => nil})
  author.save()
  @authors = Author.all()
  erb(:author)
end

get('/authors/:id') do
  @author = Author.find(params.fetch("id").to_i())
  @authors = Author.all()
  erb(:author_info)
end

post('/delete_author/:id') do
  author_id = Author.find(params.fetch("id").to_i())
  author_id.delete()
  @authors = Author.all()
  erb(:author)
end


post('/patron_library') do
  name = params.fetch("name")
  patron = Patron.new({:name => name, :checkout_books => nil, :id => nil})
  patron.save()
  @patrons = Patron.all()
  @books = Book.all()
  erb(:librarian)
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
  @book = Book.all()
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

get('/book_list/:id') do
  @books = Book.all()
  erb(:book_list)
end


patch("/patrons/:id") do
  patron_id = params.fetch("id").to_i()
  @patron = Patron.find(patron_id)
  book_ids = params.fetch("book_ids")
  @patron.update({:book_ids => book_ids})
  @books = Book.all()
  erb(:patron_info)
end

patch("/books/:id") do
  book_id = params.fetch("id").to_i()
  @book = Book.find(book_id)
  patron_ids = params.fetch("patron_ids")
  @book.update({:patron_ids => patron_ids})
  @patrons = Patron.all()
  erb(:book_info)
end
