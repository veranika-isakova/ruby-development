require_relative '../template_generator.rb'

RSpec.describe TemplateGenerator do
  options = {}
  options[:instances] = "1"
  options[:instanceType] = "t2.micro"
  options[:allowsshfrom] = "0.0.0.0/0"
  it "should have the first output" do
    expect(TemplateGenerator::generate(options)).to eq({
      "AWSTemplateFormatVersion": "2010-09-09",
      "Outputs": {
        "PublicIP": {
          "Description": "Public IP address of the newly created EC2 instance",
          "Value": {
            "Fn::GetAtt": [
              "EC2Instance",
              "PublicIp"
    ] }
    } },
      "Resources": {
        "EC2Instance": {
          "Properties": {
            "ImageId": "ami-b97a12ce",
            "InstanceType": "t2.micro",
            "SecurityGroups": [
              {
               "Ref": "InstanceSecurityGroup"
              }
          ] },
          "Type": "AWS::EC2::Instance"
    },
    "InstanceSecurityGroup": {
      "Properties": {
        "GroupDescription": "Enable SSH access via port 22",
        "SecurityGroupIngress": [
          {
            "CidrIp": "0.0.0.0/0",
            "FromPort": "22",
            "IpProtocol": "tcp",
            "ToPort": "22"
    } ]
      },
      "Type": "AWS::EC2::SecurityGroup"
    } }
    })
  end

it "should have the second output" do
  options[:instances] = "2"
  options[:instanceType] = "t2.small"
  options[:allowsshfrom] = "37.17.210.74/32"
    expect(TemplateGenerator::generate(options)).to eq({
        "AWSTemplateFormatVersion": "2010-09-09",
        "Outputs": {
          "PublicIP": {
            "Description": "Public IP address of the newly created EC2 instance",
            "Value": {
              "Fn::GetAtt": [
                "EC2Instance",
                "PublicIp"
      ] }
      } },
        "Resources": {
          "EC2Instance": {
            "Properties": {
              "ImageId": "ami-b97a12ce",
              "InstanceType": "t2.small",
              "SecurityGroups": [
                {
                  "Ref": "InstanceSecurityGroup"
      } ]
      },
            "Type": "AWS::EC2::Instance"
          },
          "EC2Instance2": {
           "Properties": {
          "ImageId": "ami-b97a12ce",
          "InstanceType": "t2.small",
          "SecurityGroups": [
            {
              "Ref": "InstanceSecurityGroup"
      } ]
      },
        "Type": "AWS::EC2::Instance"
      },
      "InstanceSecurityGroup": {
        "Properties": {
          "GroupDescription": "Enable SSH access via port 22",
          "SecurityGroupIngress": [
            {
              "CidrIp": "37.17.210.74/32",
              "FromPort": "22",
              "IpProtocol": "tcp",
              "ToPort": "22"
      } ]
        },
        "Type": "AWS::EC2::SecurityGroup"
      } }
      })
  end
end
