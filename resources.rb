require 'json'


class Resources

    attr_accessor :EC2Instance, :InstanceSecurityGroup

    def as_json(options={})
        {
            EC2Instance: @EC2Instance,
            InstanceSecurityGroup: @InstanceSecurityGroup
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
