require 'json'


class PublicIP

    attr_accessor :Description, :Value

    def as_json(options={})
        {
            Description: @Description,
            Value: @Value
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
