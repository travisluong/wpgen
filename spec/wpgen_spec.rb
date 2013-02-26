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
end