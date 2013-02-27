$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'wpgen'

describe Wpgen::CssGen do

  it "#get_ids should get all ids in a string" do
    Wpgen::CssGen.get_ids('id="page-wrap" id="header"').should eq ["page-wrap", "header"]
  end

  it "#get_classes should get all classes in a string" do
    Wpgen::CssGen.get_classes('class="post" class="entry"').should eq ["post", "entry"]
  end

  it "#generate_id_css should accept array and return css string" do
    Wpgen::CssGen.generate_id_css(["page-wrap", "header"]).should eq "#page-wrap {\n\n}\n\n#header {\n\n}\n\n"
  end

  it "#generate_class_css should accept array and return css string" do
    Wpgen::CssGen.generate_class_css(["post", "entry"]).should eq ".post {\n\n}\n\n.entry {\n\n}\n\n"
  end

end