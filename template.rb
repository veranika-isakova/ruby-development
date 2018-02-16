require 'json'

class Template

    attr_accessor :AWSTemplateFormatVersion, :Outputs, :Resources

    def as_json(options={})
        {
            AWSTemplateFormatVersion: @AWSTemplateFormatVersion,
            Outputs: @Outputs,
            Resources: @Resources
        }
    end

    def to_json(*options)
        as_json(*options).to_json(*options)
    end

end
