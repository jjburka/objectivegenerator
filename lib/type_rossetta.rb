require 'rubygems'
require "activesupport"

module TypeRossetta
  
  TYPES = {
    "float"     => "float",
    "boolean"   => "BOOL",
    "integer"   => "int"
  }
  
  POINTER_TYPES = {
    "datetime"  => "NSDate",
    "date"      => "NSDate",
    "string"    => "NSString"
  }
  
  def convert_model(attributes={})
    translated_model = Hash.new
    attributes.each do |name , type|
      translated_model[translate_name(name)] = translate_type(type)
    end
    translated_model
  end
  
  def translate_type(ruby_type)
    all_types = TYPES.merge(POINTER_TYPES)
    all_types.include?(ruby_type) ? all_types[ruby_type] : all_types["string"]
  end
  
  def translate_name(ruby_name)
    ruby_name = "#{@model_name}-id" if ruby_name == "id"
    ruby_name.gsub(/-/,"_").downcase.camelize(:lower)
  end
  
end