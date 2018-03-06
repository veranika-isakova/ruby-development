require_relative '../template_generator_dsl'
require_relative '../example_one'
require_relative '../example_two'

RSpec.describe TemplateGeneratorDsl do
  options = {}
  options[:instances] = '1'
  options[:instanceType] = 't2.micro'
  options[:allowsshfrom] = '0.0.0.0/0'
  it 'should have the first output with default parameters' do
    expect(TemplateGeneratorDsl.generate(options)).to eq(ExampleOne::OUTPUT)
  end

  it 'should have the second output with changed parameters' do
    options[:instances] = '2'
    options[:instanceType] = 't2.small'
    options[:allowsshfrom] = '37.17.210.74/32'
    expect(TemplateGeneratorDsl.generate(options)).to eq(ExampleTwo::OUTPUT)
  end
end
