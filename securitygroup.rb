require 'json'


class SecurityGroupIngress

    attr_accessor :CidrIp, :FromPort, :IpProtocol, :ToPort

    def as_json(options={})
        {
            CidrIp: @CidrIp,
            FromPort: @FromPort,
            IpProtocol: @IpProtocol,
            ToPort: @ToPort
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
