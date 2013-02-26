module Wpgen

  class Generator
    puts "class #{self} defined"
    @@templates_dir = File.expand_path("../templates", File.dirname(__FILE__))

    def self.custom_post_type type
      File.open("#{@@templates_dir}/post-type.php", "r") do |f|
        php_code = f.read
        php_code.gsub!(/WPGEN_Token/, type.capitalize)
        php_code.gsub!(/WPGEN_token/, type.downcase)
        php_code
      end
    end

    def self.page_template template_name
      File.open("#{@@templates_dir}/page-template.php", "r") do |f|
        php_code = f.read
        php_code.gsub!(/WPGEN_Token/, template_name.capitalize)
        php_code
      end
    end
  end
end