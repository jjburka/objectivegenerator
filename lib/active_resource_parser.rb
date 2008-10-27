require 'rubygems'
require 'hpricot'

# Fetches the ActiveResource at the supplied url. Will parse the first record found. 
#
# Initialization options are the following :
#   
#   :xml    => the active resource to parse
#   :model  => the model name found in the xml we are looking for
 
class ActiveResourceParser
  
  attr_reader :model
  
  def initialize(args = {})
    @model = Hash.new
    @options = args
  end
  
  def parse()
    doc = Hpricot::XML(@options[:xml])
    #loops thru the children elements of the node
    doc.at("#{@options[:model]}").containers.each do |attribute|
      @model[attribute.name] = attribute[:type].nil? ? "string" : attribute[:type]
    end
    @model 
  end 
  
  private 
  
end