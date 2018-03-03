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

    for i in 1..options[:instances].to_i do
      key = ''
      if i > 1
        then key = i.to_s
      end
      resource 'EC2Instance'+key,
              :Properties => {
                :ImageId => 'ami-b97a12ce',
                :InstanceType => options[:instanceType],
                :SecurityGroups => [ref('InstanceSecurityGroup')]
              },
              :Type => 'AWS::EC2::Instance'

    end

    resource 'InstanceSecurityGroup',
            :Properties => {
              :GroupDescription => 'Enable SSH access via port 22',
              :SecurityGroupIngress => [{:CidrIp => options[:allowsshfrom], :FromPort => '22', :IpProtocol => 'tcp', :ToPort => '22'}]
            },
            :Type => 'AWS::EC2::SecurityGroup'

   end
   tmpl
  end
end
