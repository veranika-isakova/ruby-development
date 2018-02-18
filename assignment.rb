require 'json'
require './optparse.rb'

options = HashOptions::OPTIONS

template = {}
outputs = {}
publicIP = {}
value = {}
ec2instance = {}
properties_ec2Instance = {}
properties_instanceSecurityGroup = {}
securityGroup = {}
instanceSecurityGroup = {}
securityGroupIngress = {}

template[:AWSTemplateFormatVersion] = "2010-09-09"
template[:Outputs] = outputs
outputs[:PublicIP] = publicIP
publicIP[:Description] = "Public IP address of the newly created EC2 instance"
publicIP[:Value] = value
value[:"Fn::GetAtt"] = ["EC2Instance", "PublicIp"]

template[:Resources] = {}
ec2instance[:Properties] = properties_ec2Instance
properties_ec2Instance[:ImageId] = "ami-b97a12ce"
properties_ec2Instance[:InstanceType] = options[:instanceType]
properties_ec2Instance[:SecurityGroups] = [securityGroup]
securityGroup[:Ref] = "InstanceSecurityGroup"
ec2instance[:Type] = "AWS::EC2::Instance"
template[:Resources][:EC2Instance] = ec2instance

for i in 2..options[:instances].to_i do
  template[:Resources][:"EC2Instance#{i}"] = ec2instance
end


template[:Resources][:InstanceSecurityGroup] = instanceSecurityGroup
instanceSecurityGroup[:Properties] = properties_instanceSecurityGroup
properties_instanceSecurityGroup[:GroupDescription] = "Enable SSH access via port 22"
properties_instanceSecurityGroup[:SecurityGroupIngress] = [securityGroupIngress]
securityGroupIngress[:CidrIp] = options[:allowsshfrom]
securityGroupIngress[:FromPort] = "22"
securityGroupIngress[:IpProtocol] = "tcp"
securityGroupIngress[:ToPort] = "22"
instanceSecurityGroup[:Type] = "AWS::EC2::SecurityGroup"


puts JSON.pretty_generate(template)
