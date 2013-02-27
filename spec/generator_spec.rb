$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'wpgen'

describe Wpgen::Generator do

  it "#custom_post_type should return string" do
    Wpgen::Generator.custom_post_type('employee').should match /Employee/
  end

  it "#page_template should return string" do
    Wpgen::Generator.page_template('about').should match /Template Name: About/
  end

  it "#dynamic_sidebar should return string" do
    Wpgen::Generator.dynamic_sidebar('left sidebar').should match /Left sidebar/
  end
end