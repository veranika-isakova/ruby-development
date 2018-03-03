require 'json'
require './template_generator_1'
#require './template_generator'
require './optparse'

options = HashOptions::OPTIONS
puts JSON.pretty_generate(TemplateGenerator1.generate(options))
#puts JSON.pretty_generate(TemplateGenerator.generate(options))
