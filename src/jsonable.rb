# Jsonable module

module Jsonable
  def to_json(state = nil)
    @class_id = self.class.name
    vars = Hash.new
    get_jsonable_vars.map do |attribute|
      vars[attribute] = self.instance_variable_get(attribute)
    end
    vars.to_json
  end
end
