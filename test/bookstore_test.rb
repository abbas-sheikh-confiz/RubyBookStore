require 'Simplecov'
SimpleCov.start

require 'test/unit'
require_relative '../lib/bookstore'

# BookStore Unit Tests
class BookStoreTest < Test::Unit::TestCase
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

  def test_book_delete
    @store.delete_book('test_book')

    book_deleted = true
    IO.foreach('book_store.txt') do |line|
      book_deleted = false if line.chomp.eql? 'test_book|7'
    end

    assert_equal(true, book_deleted)
  end
end
