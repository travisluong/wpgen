$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'wpgen'

describe "wpgen" do

  describe "#new_theme" do
    it "should create initial theme directory and file system" do
    	FileUtils.rm_r "wpgen_test_theme" if File.directory? "wpgen_test_theme"
      Wpgen::FileWriter.new_theme "wpgen_test_theme"
      Dir.glob("wpgen_test_theme/*").length.should eq 16
    end
  end

  describe "#custom_post_type" do

    it "accepts a parameter and returns php code for custom post type" do
      FileUtils.cd "wpgen_test_theme"
      Wpgen::FileWriter.write_custom_post_type('employee')
      File.open("post-type-employee.php", "r") do |f|
        f.read.should eq <<-EOF
<?php

// Employee custom content type
function post_type_employee() {
	register_post_type('employee',
		array('label' => __('Employee'),
		'public' => true,
		'show_ui' => true,
		'supports' => array( 'title', 'editor', 'excerpt', 'custom-fields', 'thumbnail' ),
	));
}
add_action('init', 'post_type_employee');
EOF
      end
    end

    it "should add the require statement to functions.php" do
      File.open("functions.php", "r") do |f|
      	(f.read =~ /require_once 'post-type-employee.php'/).should be_true
      end
    end
  end

  describe "#page_template" do
    it "should create a page template" do
      Wpgen::FileWriter.write_page_template('about')
      File.open("page-template-about.php") do |f|
        (f.read =~ /About/).should be_true
      end
    end
  end

  describe "#sidebar" do
    it "should add sidebar code to functions.php" do
      Wpgen::FileWriter.write_dynamic_sidebar('Footer widgets')
      File.open("functions.php") do |f|
        (f.read =~ /Footer widgets/).should be_true
      end
    end
  end

  describe "css_gen" do
    it "#get_ids should get all ids in a file" do
      Wpgen::CssGen.get_ids("header.php").should eq ["page-wrap", "header"]
    end

    it "#get_classes should get all classes in a file" do
      Wpgen::CssGen.get_classes("page.php").should eq ["post", "entry"]
    end

    it "#generate_id_css should accept array and return css string" do
      Wpgen::CssGen.generate_id_css(["page-wrap", "header"]).should eq <<-EOF
#page-wrap {

}

#header {

}

EOF
    end

    it "#generate_class_css should accept array and return css string" do
      Wpgen::CssGen.generate_class_css(["post", "entry"]).should eq <<-EOF
.post {

}

.entry {

}

EOF
    end

    describe "FileWriter.write_css" do
      before { Wpgen::FileWriter.write_css }
      it "should append ids and classes to style.css" do
        File.open("style.css", "r+") do |f|
          styles = f.read
          (styles =~ /entry/).should be_true
        end
      end
    end
  end
end