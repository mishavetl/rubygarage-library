# hash_to_object function

require __dir__ + '/hash_convertion_error.rb'

def hash_to_object(class_ids, val)
  class_name = nil
  args = Hash.new
  if val.is_a? Hash
    val.each do |key, value|
      if (key == "@class_id")
        class_name = class_ids[value.to_sym]
      else
        args[key.to_sym] = hash_to_object(class_ids, value)
      end
    end
    if (class_name == nil)
      raise HashConvertionError, "class_id not found"
    end
    args_sorted = []
    args.collect { |key, value| args_sorted[class_name.init_api.index(key)] = value }
    class_name.send("new", *args_sorted)
  elsif val.is_a? Array
    val.collect { |value| hash_to_object(class_ids, value) }
  else
    val
  end
end
