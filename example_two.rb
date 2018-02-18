ruby assignment.rb --instances 2 --instance-type t2.small --allow-ssh-from 37.17.210.74
{
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
}
