# Order class

require __dir__ + '/model.rb'

class Order < Model
  @@count = 0
  attr_accessor :book, :reader, :date, :id

  def initialize(book, reader, date, id=nil)
    @@count += 1
    id = id || @@count
    @book, @reader, @date, @id = book, reader, date, id
  end

  def self.init_api
    [:@book, :@reader, :@date, :@id]
  end
end
