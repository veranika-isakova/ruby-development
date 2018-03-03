require 'bundler/setup'
require 'cloudformation-ruby-dsl/cfntemplate'

module TemplateGenerator1
  def self.generate(options)

    tmpl = template do
    @stack_name = 'assignment'

    value :AWSTemplateFormatVersion => '2010-09-09'

    output 'PublicIP',
            :Description => 'Public IP address of the newly created EC2 instance',
            :Value => {
              :'Fn::GetAtt' => ['EC2Instance', 'PublicIp']
            }

    resource 'EC2Instance',
            :Properties => {
              :ImageId => 'ami-b97a12ce',
              :InstanceType => 't2.micro',
              :SecurityGroups => [ref('InstanceSecurityGroup')]
            },
            :Type => 'AWS::EC2::Instance'

    resource 'InstanceSecurityGroup',
            :Properties => {
              :GroupDescription => 'Enable SSH access via port 22',
              :SecurityGroupIngress => [{:CidrIp => '0.0.0.0/0', :FromPort => '22', :IpProtocol => 'tcp', :ToPort => '22'}]
            },
            :Type => 'AWS::EC2::SecurityGroup'

   end
   tmpl
  end
end
