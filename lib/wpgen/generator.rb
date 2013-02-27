module Wpgen

  class Generator
    @@templates_dir = File.expand_path("../../templates", File.dirname(__FILE__))

    def self.custom_post_type type
      File.open("#{@@templates_dir}/post-type.php", "r") do |f|
        php_code = f.read
        php_code.gsub!(/WPGEN_Token/, type.capitalize)
        php_code.gsub!(/WPGEN_token/, type.downcase)
      end
    end

    def self.page_template template_name
      File.open("#{@@templates_dir}/page-template.php", "r") do |f|
        php_code = f.read
        php_code.gsub!(/WPGEN_Token/, template_name.capitalize)
      end
    end

    def self.dynamic_sidebar sidebar_name
      File.open("#{@@templates_dir}/register-sidebar.php") do |f|
        php_code = f.read
        php_code.gsub!(/WPGEN_Token/, sidebar_name.capitalize)
        php_code.gsub!(/wpgen-token/, sidebar_name.downcase.gsub(/\s/, "-"))
      end
    end
  end
end