require 'Simplecov'
SimpleCov.start

require_relative 'bookstore'

# BookStore Execution
class BookStoreRun
  def self.start
    book_store = BookStore.instance

    puts 'Welcome to the book store'
    puts 'What would you like to do'
    puts '1. Add a book'
    puts '2. Search for a book'
    puts '3. Delete a book'
    puts '4. View all the books'
    puts 'Enter your choice (1-4)'

    choice = gets.chomp
    case choice
    when '1'
      puts 'Enter title of book'
      title = gets.chomp
      if book_store.book_exists(title.intern)
        puts 'Sorry, the book already exists in our store'
      else
        puts 'Enter book rating'
        rating = gets.chomp
        book_store.add_book(title, rating)
        puts 'Book added to store'
      end
    when '2'
      puts 'What would you like to search for'
      search = gets.chomp
      books = book_store.search_book(search)

      if !books.empty?
        books.each do |book|
          puts "Book Name: #{book.title}"
          puts "Book Rating: #{book.rating}"
        end
      else
        puts 'No book found'
      end
    when '3'
      puts 'Enter title of book'
      title = gets.chomp
      if book_store.book_exists(title.intern)
        book_store.delete_book(title)
        puts 'Book removed from store'
      else
        puts 'Sorry, that book does not exist in our store'
      end
    when '4'
      book_store.display_books
    else
      puts 'Invalid input entered'
    end
  end
end
