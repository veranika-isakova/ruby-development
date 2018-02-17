require './outputs.rb'
require './template.rb'
require './public.rb'
require './value.rb'
require './resources.rb'
require './ec2instance.rb'
require './properties_ec2.rb'
require './properties_instance.rb'
require './security.rb'
require './instance.rb'
require './securitygroup'
require 'optparse'

#instances, instance-type, allow-ssh-from = ARGV
#args = Hash[ ARGV.flat_map{|s| s.scan(/--?([^=\s]+)(?:=(\S+))?/) } ]
#number_of_instances =
options = {}
options[:instances] = 1,
options[:instanceType] = "t2.micro",
options[:allowsshfrom] = "0.0.0.0/0"

OptionParser.new do |parser|
  parser.on("--instance-type TYPE", "Type of the instance") do |v|
    options[:instanceType] = v
  end
  parser.on("--instances NUMBER", "Number of the instances") do |v|
    options[:instances] = v
  end
  parser.on("--allow-ssh-from TYPE", "Allow ssh from") do |v|
    options[:allowsshfrom] = v
  end
end.parse!

template = Template.new
outputs = Outputs.new
publicIP = PublicIP.new
value = Value.new
resources = Resources.new
ec2instance = EC2Instance.new
properties_ec2Instance = Properties_ec2Instance.new
properties_instanceSecurityGroup = Properties_instanceSecurityGroup.new
securityGroup = SecurityGroup.new
instanceSecurityGroup =  InstanceSecurityGroup.new
securityGroupIngress = SecurityGroupIngress.new

template.AWSTemplateFormatVersion = "2010-09-09"
template.Outputs = outputs
outputs.PublicIP = publicIP
publicIP.Description = "Public IP address of the newly created EC2 instance"
publicIP.Value = value
value.Fn = ["EC2Instance", "PublicIp"]
template.Resources = resources

resources.EC2Instance = ec2instance
ec2instance.Properties = properties_ec2Instance
properties_ec2Instance.ImageId = "ami-b97a12ce"
properties_ec2Instance.InstanceType = options[:instanceType]
properties_ec2Instance.SecurityGroups = [securityGroup]
securityGroup.Ref = "InstanceSecurityGroup"
ec2instance.Type = "AWS::EC2::Instance"

resources.InstanceSecurityGroup = instanceSecurityGroup
instanceSecurityGroup.Properties = properties_instanceSecurityGroup
properties_instanceSecurityGroup.GroupDescription = "Enable SSH access via port 22"
properties_instanceSecurityGroup.SecurityGroupIngress = [securityGroupIngress]
securityGroupIngress.CidrIp = options[:allowsshfrom]
securityGroupIngress.FromPort = "22"
securityGroupIngress.IpProtocol = "tcp"
securityGroupIngress.ToPort = "22"
instanceSecurityGroup.Type = "AWS::EC2::SecurityGroup"


puts JSON.pretty_generate(template)


#puts ARGV
