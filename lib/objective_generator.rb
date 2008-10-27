require "lib/type_rossetta"
require "lib/active_resource_parser"
require "lib/active_resource_connection"
require "erb"
require 'activesupport'

class ObjectiveGenerator
  include TypeRossetta
  
  HEADER_TEMPLATE = "./templates/header.h.erb"
  CLASS_TEMPLATE  = "./templates/class.m.erb"
  
  def initialize(args = {})
    @model_name = args[:model]
    @url = args[:url]
    @protocol = args[:url].scan(/(xml)?$/).flatten.first || ""
    @user = args[:user] || ""
    @password = args[:password] || ""
  end
  
  def generate()
    discover_resource
    @url = @url.scan(/^.*\//).flatten.first
    #get model discribtion and then run the templates
    [HEADER_TEMPLATE , CLASS_TEMPLATE].each do |template|
      File.open(file_name(template), 'w') {|f| f.write(generate_file(template)) }
    end
    
  end
 
  private
  
  def discover_resource
    c = ActiveResourceConnection.new(:url=>@url)
    p = ActiveResourceParser.new(:xml=>c.fetch , :model=>@model_name)
    @model_attributes = convert_model(p.parse())   
  end
  
  def file_name(templateFile)
    "#{@model_name.camelize}#{templateFile.scan(/(\..)\.erb$/).flatten.first}"
  end
  
  def generate_file(templateFile)
    
    template = String.new
    File.open(templateFile, 'r') do |f| 
      template = f.readlines
    end
    rhtml = ERB.new(template.join())
    rhtml.result(binding)
  end
  
end