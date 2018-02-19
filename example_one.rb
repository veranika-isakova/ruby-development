module ExampleOne
  OUTPUT =
  {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Outputs": {
      "PublicIP": {
        "Description": "Public IP address of the newly created EC2 instance",
        "Value": {
          "Fn::GetAtt": [
            "EC2Instance",
            "PublicIp"
          ]
        }
      }
    },
    "Resources": {
      "EC2Instance": {
        "Properties": {
          "ImageId": "ami-b97a12ce",
          "InstanceType": "t2.micro",
          "SecurityGroups": [
            {
             "Ref": "InstanceSecurityGroup"
            }
          ]
        },
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
          }
        ]
      },
      "Type": "AWS::EC2::SecurityGroup"
      }
    }
  }
end
