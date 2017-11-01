# Printable module

module Printable
  def to_s
    "(" + self.class.name + ", " +
      (get_printable_vars.collect do |key|
         value = self.instance_variable_get key
         if value.is_a? Array
           "[" + value.join(", ") + "]"
         else
           value.to_s
         end
       end).join(", ") + ")"
  end
end
