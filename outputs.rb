require 'json'

class Outputs

    attr_accessor :PublicIP

    def as_json(options={})
        {
            PublicIP: @PublicIP
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
