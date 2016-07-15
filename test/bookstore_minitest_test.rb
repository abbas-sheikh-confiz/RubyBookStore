require 'Simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative '../lib/bookstore'

# BookStore MiniTest Tests
class BookStoreTest < MiniTest::Test
  def setup
    @store = BookStore.instance
  end

  def test_book_add
    @store.add_book('test_book', 7)

    book_added = false
    IO.foreach('book_store.txt') do |line|
      book_added = true if line.chomp.eql? 'test_book|7'
    end

    assert_equal(true, book_added)
  end

  def test_book_search
    books = @store.search_book('book 1')
    
    book_found = !books.empty? ? true : false

    assert_equal(true, book_found)
  end

  def test_book_delete
    @store.delete_book('test_book')

    book_deleted = true
    IO.foreach('book_store.txt') do |line|
      book_deleted = false if line.chomp.eql? 'test_book|7'
    end

    assert_equal(true, book_deleted)
  end
end
