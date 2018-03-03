require 'json'
require './template_generator_1'
require './optparse'

options = HashOptions::OPTIONS
puts JSON.pretty_generate(TemplateGenerator1.generate(options))
