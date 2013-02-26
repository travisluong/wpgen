$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'wpgen'

describe "wpgen" do

  describe "#new_theme" do
    it "should create initial theme directory and file system" do
      Wpgen::Generator.new_theme "test"
    end
  end

  describe "#custom_post_type" do
    it "accepts a parameter and returns php code for custom post type" do
      Wpgen::Generator.custom_post_type('employee').should eq <<-EOF
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

end