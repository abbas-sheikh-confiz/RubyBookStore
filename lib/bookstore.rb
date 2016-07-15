require 'singleton'
require_relative 'book'

# BookStore.rb
class BookStore
  include Singleton

  def initialize
    @books = []

    IO.foreach('book_store.txt') do |line|
      name = line.split('|').first
      rating = line.split('|').last

      book = Book.new(name.intern, rating.to_i)

      @books << book
    end
  end

  def add_book(name, rating)
    book = Book.new(name.intern, rating.to_i)

    @books << book
    update_store
  end

  def delete_book(name)
    @books.select! { |book| book.title != name.intern }

    update_store
  end

  def search_book(name)
    result = []
    @books.each do |book|
      next unless book.title.downcase.to_s.include? name.downcase
      result << Book.new(book.title, book.rating)
    end

    result
  end

  def display_books
    puts 'Books available in store'
    @books.each do |book|
      puts "Book Name: #{book.title}"
      puts "Book Rating: #{book.rating}"
      puts ''
    end
  end

  def book_exists(title)
    @books.each do |book|
      return true if book.title == title
    end
    false
  end

  private

  def update_store
    book_store = File.open('book_store.txt', 'w')
    @books.each do |book|
      book_store.syswrite("#{book.title}|#{book.rating}\n")
    end
    book_store.close
  end
end
