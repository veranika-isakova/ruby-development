require 'json'


class SecurityGroup

    attr_accessor :Ref

    def as_json(options={})
        {
            Ref: @Ref
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
