require 'optparse'

module HashOptions
  OPTIONS = {}
  OPTIONS[:instances] = "1"
  OPTIONS[:instanceType] = "t2.micro"
  OPTIONS[:allowsshfrom] = "0.0.0.0/0"

  OptionParser.new do |parser|
    parser.on("--instance-type TYPE", "Type of the instance") do |v|
      OPTIONS[:instanceType] = v
    end
    parser.on("--instances TYPE", "Number of the instances") do |v|
      OPTIONS[:instances] = v
    end
    parser.on("--allow-ssh-from TYPE", "Allow ssh from") do |v|
      OPTIONS[:allowsshfrom] = v
    end
  end.parse!
end
