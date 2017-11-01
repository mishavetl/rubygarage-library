# Model class

require __dir__ + '/jsonable.rb'
require __dir__ + '/printable.rb'

class Model
  include Jsonable
  include Printable

  def get_printable_vars
    self.instance_variables.select { |name, _| name != '@count' }
  end

  alias :get_jsonable_vars :get_printable_vars
end
