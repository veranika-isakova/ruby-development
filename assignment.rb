require './outputs.rb'
require './template.rb'
require './public.rb'
require './value.rb'

template = Template.new
outputs = Outputs.new
publicIP = PublicIP.new
value = Value.new


template.AWSTemplateFormatVersion = "2010-09-09"
template.Outputs = outputs
outputs.PublicIP = publicIP
publicIP.Description = "Public IP address of the newly created EC2 instance"
publicIP.Value = value
value.Fn = ["EC2Instance", "PublicIp"]

puts JSON.pretty_generate(template)
