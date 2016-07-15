# Book.rb
class Book
  attr_reader :title
  attr_reader :rating

  def initialize(title, rating)
    @title = title
    @rating = rating
  end
end
