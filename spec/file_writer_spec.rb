$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'wpgen'

describe Wpgen::FileWriter do

  before(:all) { FileUtils.rm_r "wpgen_test_theme" if File.directory? "wpgen_test_theme" }

  context "#new_theme" do

    it "should create folder" do
      File.directory? "wpgen_test_theme"
    end

    it "should write 16 files" do
      Wpgen::FileWriter.new_theme "wpgen_test_theme"
      FileUtils.cd "wpgen_test_theme"
      Dir.glob("*").length.should eq 16
    end
  end

  context "#write_custom_post_type" do

    it "accepts a parameter and returns php code for custom post type" do
      Wpgen::FileWriter.write_custom_post_type('employee')
      File.open("post-type-employee.php", "r") do |f|
        cpt = f.read
        (cpt =~ /employee/ && cpt =~ /Employee/).should be_true
      end
    end

    it "should add the require statement to functions.php" do
      File.open("functions.php", "r") do |f|
        (f.read =~ /require_once 'post-type-employee.php'/).should be_true
      end
    end
  end

  context "#write_page_template" do
    it "should create a file" do
      Wpgen::FileWriter.write_page_template('about')
      File.open("page-template-about.php") do |f|
        (f.read =~ /About/).should be_true
      end
    end
  end

  context "#write_dynamic_sidebar" do
    it "should add code to functions.php" do
      Wpgen::FileWriter.write_dynamic_sidebar('Footer widgets')
      File.open("functions.php") do |f|
        (f.read =~ /Footer widgets/).should be_true
      end
    end
  end

  context "#write_stylesheet" do
    it "should append ids and classes to style.css" do
      Wpgen::FileWriter.write_stylesheet
      File.open("style.css", "r+") do |f|
        styles = f.read
        (styles =~ /entry/).should be_true
      end
    end
  end
end