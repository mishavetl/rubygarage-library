# Library class

require __dir__ + '/model.rb'

class Library < Model
  @@count = 0
  attr_accessor :books, :orders, :readers, :authors, :id

  def initialize(books, orders, readers, authors, id = nil)
    @@count += 1
    id = id || @@count
    @books, @orders, @readers, @authors, @id = books, orders, readers, authors, id
  end

  def self.init_api
    [:@books, :@orders, :@readers, :@authors, :@id]
  end
end
