#!/usr/bin/ruby

require __dir__ + '/src/interface.rb'
require __dir__ + '/src/controller.rb'

puts Interface.new(Controller.new).run($0, ARGV)
