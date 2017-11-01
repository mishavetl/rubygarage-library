# Reader class

require __dir__ + '/model.rb'

class Reader < Model
  @@count = 0
  attr_accessor :name, :email, :city, :street, :house, :id

  def initialize(name, email, city, street, house, id=nil)
    @@count += 1
    id = id || @@count
    @name, @email, @city, @street, @house, @id = \
                                           name, email, city, street, house, id
  end

  def self.init_api
    [:@name, :@email, :@city, :@street, :@house, :@id]
  end
end
