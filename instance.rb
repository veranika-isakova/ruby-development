require 'json'


class InstanceSecurityGroup

    attr_accessor :Properties, :Type

    def as_json(options={})
        {
            Properties: @Properties,
            Type: @Type
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
