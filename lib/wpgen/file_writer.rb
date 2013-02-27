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
    @@templates_dir = File.expand_path("../../templates", File.dirname(__FILE__))

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
      File.open("style.css", "a") do |stylesheet|
        ids, c = get_all_css_selectors
        stylesheet.puts CssGen.generate_id_css(ids)
        stylesheet.puts CssGen.generate_class_css(c)
        puts "Write selectors to style.css"
      end
    end

    def self.write_css file
      stylesheet = File.open("style.css", "a")
      ids = get_ids_from_file file
      c = get_classes_from_file file
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

    def self.get_all_css_selectors
      php_files = Dir.glob("*.php")
      php_files = php_files - @@write_css_ignore
      ids = []
      c = []
      puts "Extracting ids and selectors from:"
      php_files.each do |php_file|
        ids.concat(get_ids_from_file(php_file))
        c.concat(get_classes_from_file(php_file))
        puts "\t#{php_file}"
      end
      return ids.uniq, c.uniq
    end

    def self.get_ids_from_file file
      File.open(file, "r") do |f|
        CssGen.get_ids(f.read)
      end
    end

    def self.get_classes_from_file file
      File.open(file, "r") do |f|
        CssGen.get_classes(f.read)
      end
    end


  end
end

