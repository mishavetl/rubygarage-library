# Author class

require __dir__ + '/model.rb'

class Author < Model
  @@count = 0
  attr_accessor :name, :biography, :id

  def initialize(name, biography, id = nil)
    @@count += 1
    id = id || @@count
    @name, @biography, @id = name, biography, id
  end

  def self.init_api
    [:@name, :@biography, :@id]
  end
end
