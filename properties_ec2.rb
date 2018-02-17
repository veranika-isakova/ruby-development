require 'json'


class Properties_ec2Instance

    attr_accessor :ImageId, :InstanceType, :SecurityGroups

    def as_json(options={})
        {
            ImageId: @ImageId,
            InstanceType: @InstanceType,
            SecurityGroups: @SecurityGroups
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
