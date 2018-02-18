require 'json'
require './template_generator.rb'
require './optparse.rb'

options = HashOptions::OPTIONS
puts JSON.pretty_generate(TemplateGenerator::generate(options))
