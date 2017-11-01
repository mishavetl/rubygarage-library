# Book class

require __dir__ + '/model.rb'

class Book < Model
  @@count = 0
  attr_accessor :title, :author, :id

  def initialize(title, author, id=nil)
    @@count += 1
    id = id || @@count
    @title, @author, @id = title, author, id
  end

  def self.init_api
    [:@title, :@author, :@id]
  end
end
