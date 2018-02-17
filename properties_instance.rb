require 'json'


class Properties_instanceSecurityGroup

    attr_accessor :GroupDescription, :SecurityGroupIngress

    def as_json(options={})
        {
            GroupDescription: @GroupDescription,
            SecurityGroupIngress: @SecurityGroupIngress
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
