module TemplateGenerator
  def self.generate(options)
    template = {}
    template[:AWSTemplateFormatVersion] = '2010-09-09'
    template[:Outputs] = generate_outputs
    template[:Resources] = generate_resources(options)
    template
  end

  def self.generate_outputs
    outputs = {}
    public_ip = {}
    value = {}
    outputs[:PublicIP] = public_ip
    public_ip[:Description] =
      'Public IP address of the newly created EC2 instance'
    public_ip[:Value] = value
    value[:"Fn::GetAtt"] = %w[EC2Instance PublicIp]
    outputs
  end

  def self.generate_resources(options)
    resourses = {}
    (1..options[:instances].to_i).each do |i|
      if i == 1
        resourses[:EC2Instance] = generate_ec2instance(options)
      else
        resourses[:"EC2Instance#{i}"] = generate_ec2instance(options)
      end
    end
    resourses[:InstanceSecurityGroup] = generate_instance_sec_group(options)
    resourses
  end

  def self.generate_ec2instance(options)
    ec2instance = {}
    ec2instance[:Properties] = generate_properties_ec2_inst(options)
    ec2instance[:Type] = 'AWS::EC2::Instance'
    ec2instance
  end

  def self.generate_instance_sec_group(options)
    instance_security_group = {}
    properties_instance_security_group = {}
    instance_security_group[:Properties] = properties_instance_security_group
    properties_instance_security_group[:GroupDescription] =
      'Enable SSH access via port 22'
    properties_instance_security_group[:SecurityGroupIngress] =
      [security_group_ingress(options)]
    instance_security_group[:Type] = 'AWS::EC2::SecurityGroup'
    instance_security_group
  end

  def self.generate_properties_ec2_inst(options)
    properties_ec2_instance = {}
    security_group = {}
    properties_ec2_instance[:ImageId] = 'ami-b97a12ce'
    properties_ec2_instance[:InstanceType] = options[:instanceType]
    properties_ec2_instance[:SecurityGroups] = [security_group]
    security_group[:Ref] = 'InstanceSecurityGroup'
    properties_ec2_instance
  end

  def self.security_group_ingress(options)
    security_group_ingress = {}
    security_group_ingress[:CidrIp] = options[:allowsshfrom]
    security_group_ingress[:FromPort] = '22'
    security_group_ingress[:IpProtocol] = 'tcp'
    security_group_ingress[:ToPort] = '22'
    security_group_ingress
  end
end
