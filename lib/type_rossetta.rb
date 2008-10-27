require 'rubygems'
require "activesupport"

module TypeRossetta
  
  def convert_model(attributes={})
    translated_model = Hash.new
    attributes.each do |name , type|
      translated_model[translate_name(name)] = translate_type(type)
    end
    translated_model
  end
  
  #TODO: find list of available types
  def translate_type(ruby_type)
    "NSString"
  end
  
  def translate_name(ruby_name)
    ruby_name = "#{@model_name}-id" if ruby_name == "id"
    ruby_name.gsub(/-/,"_").downcase.camelize(:lower)
  end
  
  
end