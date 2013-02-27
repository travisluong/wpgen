module Wpgen

  class FileWriter

    @@initial_folder_list = ["css", "inc", "js"]
    @@initial_file_list = [
      "css/reset.css",
      "css/ie.css",
      "inc/meta.php",
      "inc/nav.php",
      "inc/paging.php",
      "js/functions.js",
      "404.php",
      "archive.php",
      "comments.php",
      "footer.php",
      "functions.php",
      "header.php",
      "index.php",
      "page.php",
      "screenshot.png",
      "search.php",
      "searchform.php",
      "sidebar.php",
      "style.css"
    ]
    @@write_css_ignore = ["functions.php"]
    @@templates_dir = File.expand_path("../templates", File.dirname(__FILE__))

    def self.new_theme folder_name
      mkdir "#{folder_name}"

      @@initial_folder_list.each do |folder|
        mkdir "#{folder_name}/#{folder}"
      end

      @@initial_file_list.each do |file|
        mkfile file, @@templates_dir, folder_name
      end
    end

    def self.write_custom_post_type type
      php_code = Generator.custom_post_type type

      File.open("post-type-#{type}.php", "w") do |f|
        f.puts php_code
      end

      File.open("functions.php", "r+") do |f|
        php_code = f.read
        php_code.gsub!(/\/\/ WPGEN custom post types/, "// WPGEN custom post types\nrequire_once 'post-type-#{type}.php'")
        f.close
        FileUtils.remove_file "functions.php"
        File.open("functions.php", "w") do |f|
          f.puts php_code
        end
      end

      puts "Create file post-type-#{type}.php"
      puts "Change functions.php"
    end

    def self.write_page_template template_name
      php_code = Generator.page_template template_name

      File.open("page-template-#{template_name}.php", "w") do |f|
        f.puts php_code
      end

      puts "Create file page-template-#{template_name}.php"
    end

    def self.write_dynamic_sidebar sidebar_name
      sidebar_code = Generator.dynamic_sidebar sidebar_name

      File.open("functions.php", "r+") do |f|
        functions_code = f.read
        functions_code.gsub!(/\/\/ WPGEN register sidebars/, "// WPGEN register sidebars\n#{sidebar_code}")
        f.close
        FileUtils.remove_file "functions.php"
        File.open("functions.php", "w") do |f|
          f.puts functions_code
        end
      end

      puts "Change file functions.php"
    end

    def self.write_stylesheet
      stylesheet = File.open("style.css", "a")
      php_files = Dir.glob("*.php")
      php_files = php_files - @@write_css_ignore
      ids = []
      c = []
      puts "Extracting ids and selectors from:"
      php_files.each do |php_file|
        ids.concat(CssGen.get_ids(php_file))
        c.concat(CssGen.get_classes(php_file))
        puts "\t#{php_file}"
      end
      ids.uniq!
      c.uniq!
      stylesheet.puts CssGen.generate_id_css(ids)
      stylesheet.puts CssGen.generate_class_css(c)
      puts "Write selectors to style.css"
    end

    def self.write_css file
      stylesheet = File.open("style.css", "a")
      ids = CssGen.get_ids(file).uniq
      c = CssGen.get_classes(file).uniq
      stylesheet.puts CssGen.generate_id_css(ids)
      stylesheet.puts CssGen.generate_class_css(c)
      puts "Write selectors from #{file} to style.css"
    end

    private

    def self.mkdir path
      Dir.mkdir path
      puts "Create folder #{path}"
    end

    def self.mkfile file_path, templates_dir, folder_name
      FileUtils.cp "#{templates_dir}/#{file_path}", "#{folder_name}/#{file_path}"
      puts "Create file #{folder_name}/#{file_path}"
    end
  end
end

