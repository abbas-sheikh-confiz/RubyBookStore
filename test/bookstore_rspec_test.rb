require_relative '../lib/bookstore'

# BookStore RSpec test
describe BookStore do
  describe '#add_book' do
    context 'given a book name and rating' do
      before do
        store = BookStore.instance
        store.add_book('test_book', 7)

        @book_added = false
        IO.foreach('book_store.txt') do |line|
          @book_added = true if line.chomp.eql? 'test_book|7'
        end
      end
      it 'adds the book to the store' do
        expect(@book_added).to eql(true)
      end
    end
  end

  describe '#search_book' do
    context 'given a substring' do
      before do
        store = BookStore.instance
        books = store.search_book('book 1')

        @book_found = !books.empty? ? true : false
      end
      it 'displays books that match the substring' do
        expect(@book_found).to eql(true)
      end
    end
  end

  describe '#delete_book' do
    context 'given a book title' do
      before do
        store = BookStore.instance
        store.delete_book('test_book')

        @book_deleted = true
        IO.foreach('book_store.txt') do |line|
          @book_deleted = false if line.chomp.eql? 'test_book|7'
        end
      end
      it 'deletes the book with that title' do
        expect(@book_deleted).to eql(true)
      end
    end
  end
end
