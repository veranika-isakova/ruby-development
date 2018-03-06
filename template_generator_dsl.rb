require 'cloudformation-ruby-dsl/cfntemplate'

module TemplateGeneratorDsl
  def self.generate(options)
    tmpl = template do
      @stack_name = 'assignment'
      value :AWSTemplateFormatVersion => '2010-09-09'

      output  :PublicIP,
              :Description =>
                'Public IP address of the newly created EC2 instance',
              :Value => {
                :'Fn::GetAtt' => %w[EC2Instance PublicIp]
              }
      (1..options[:instances].to_i).each do |i|
        key = i > 1 ? i.to_s : '' # ternary operator
        resource  :"EC2Instance#{key}",
                  :Properties =>
                    {
                      :ImageId => 'ami-b97a12ce',
                      :InstanceType => options[:instanceType],
                      :SecurityGroups => [ref('InstanceSecurityGroup')]
                    },
                  :Type => 'AWS::EC2::Instance'
      end
      resource  :InstanceSecurityGroup,
                :Properties =>
                  {
                    :GroupDescription => 'Enable SSH access via port 22',
                    :SecurityGroupIngress => [
                      {
                        :CidrIp => options[:allowsshfrom],
                        :FromPort => '22',
                        :IpProtocol => 'tcp',
                        :ToPort => '22'
                      }
                    ]
                  },
                :Type => 'AWS::EC2::SecurityGroup'
    end
    tmpl.instance_variable_get(:@dict)
  end
end
