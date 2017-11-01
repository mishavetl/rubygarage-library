# Controller class

require 'json'

require __dir__ + '/book.rb'
require __dir__ + '/order.rb'
require __dir__ + '/reader.rb'
require __dir__ + '/author.rb'
require __dir__ + '/library.rb'
require __dir__ + '/hash_to_object.rb'
require __dir__ + '/array_if_nil.rb'

class Controller
  def initialize
    @class_ids = {"Library": Library,
                 "Book": Book,
                 "Order": Order,
                 "Reader": Reader,
                 "Author": Author}
    @library = Library.new([], [], [], [])
  end

  def get_book_by_name(book_name)
    @library.books.find { |book| book.title == book_name }
  end

  def get_by_id(source, id)
    source.find { |reader| reader.id == id }
  end

  def get_reader_by_id(id)
    get_by_id(@library.readers, id)
  end

  def get_sorted_books
    @library.books.collect \
    { |book| [@library.orders.count { |order| order.book == book.id}, book]}
      .sort { |a, b| a.first <=> b.first } .collect { |tuple| tuple[1] }
  end

  def who_takes_the_book(book_name)
    readers = @library.orders.select { |order| order.book == get_book_by_name(book_name).id } \
              .collect { |order| order.reader}
    frequency = readers.inject(Hash.new(0)) { |f, v| f[v] += 1; f }
    [get_reader_by_id(frequency.max_by { |_, v| v }.first)]
  end

  def what_is_the_most_popular_book()
    [get_sorted_books.last]
  end

  def how_many_ordered_one_of_three_most_popular_books()
    best_sellers = get_sorted_books.pop(3).collect { |book| book.id }
    [@library.orders
      .select { |order| best_sellers.include? order.book }
      .collect { |order| order.reader } .uniq.count]
  end

  def save_to_file(file_name)
    begin
      data = JSON.pretty_generate(JSON.parse @library.to_json)
      File.open(file_name, "w") do |file|
        file.write data
      end
    rescue IOError => e
      return ["err: " + e.message]
    end
    return ["ok"]
  end

  def import_from_file(file_name)
    begin
      lines = []
      File.open(file_name, "r") do |file|
        lines = file.readlines()
      end
      @library = hash_to_object(@class_ids, JSON.load(lines.join))
    rescue IOError => e
      return ["err: " + e.message]
    rescue HashConvertionError => e
      return ["err: " + e.message]
    end
    return [@library]
  end
end
