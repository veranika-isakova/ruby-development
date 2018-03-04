require 'json'
require './template_generator_dsl'
require './optparse'

options = HashOptions::OPTIONS
puts JSON.pretty_generate(TemplateGenerator_dsl.generate(options))
