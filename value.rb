require 'json'

class Value

    attr_accessor :Fn

    def as_json(options={})
        {
            Fn: @Fn
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
