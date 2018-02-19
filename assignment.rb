require 'json'
require './template_generator'
require './optparse'

options = HashOptions::OPTIONS
puts JSON.pretty_generate(TemplateGenerator.generate(options))
