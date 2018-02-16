require './outputs.rb'
require './template.rb'
require './public.rb'
require './value.rb'
require './resources.rb'
require './ec2instance.rb'
require './properties.rb'
require './security.rb'

template = Template.new
outputs = Outputs.new
publicIP = PublicIP.new
value = Value.new
resources = Resources.new
ec2instance = EC2Instance.new
properties = Properties.new
securityGroup = SecurityGroup.new

template.AWSTemplateFormatVersion = "2010-09-09"
template.Outputs = outputs
outputs.PublicIP = publicIP
publicIP.Description = "Public IP address of the newly created EC2 instance"
publicIP.Value = value
value.Fn = ["EC2Instance", "PublicIp"]
template.Resources = resources
resources.EC2Instance = ec2instance
ec2instance.Properties = properties
properties.ImageId = "ami-b97a12ce"
properties.InstanceType = "t2.micro"
properties.SecurityGroups = [securityGroup]
securityGroup.Ref = "InstanceSecurityGroup"
ec2instance.Type = "AWS::EC2::Instance"


puts JSON.pretty_generate(template)
