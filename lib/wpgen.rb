$LOAD_PATH.unshift File.expand_path("../wpgen", __FILE__)

require 'version'

module Wpgen
  puts "module Wpgen defined"

  class Generator
    puts "class #{self} defined"

    @@initial_folder_list = ["css", "inc", "js"]
    @@initial_file_list = [
      "css/reset.css",
      "css/ie.css",
      "404.php",
      "archive.php",
      "footer.php",
      "functions.php",
      "header.php",
      "index.php",
      "page.php",
      "screenshot.png",
      "style.css"
    ]
    @@templates_dir = File.expand_path(File.dirname(__FILE__)) << "/templates"

    def self.new_theme folder_name
      mkdir "#{folder_name}"

      @@initial_folder_list.each do |folder|
        mkdir "#{folder_name}/#{folder}"
      end

      @@initial_file_list.each do |file|
        mkfile file, @@templates_dir, folder_name
      end

    end

    def self.custom_post_type type
      File.open("#{@@templates_dir}/post-type.php", "r") do |f|
        data = f.read
        data.gsub!(/WPGEN_Token/, type.capitalize)
        data.gsub!(/WPGEN_token/, type.downcase)
        File.open("post-type-#{type}.php", "w") do |f|
          f.puts data
        end
      end
      File.open("functions.php", "r+") do |f|
        data = f.read
        data.gsub!(/\/\/ WPGEN custom post types/, "// WPGEN custom post types\nrequire_once 'post-type-#{type}.php'")
        f.truncate(0)
        f.puts data
      end
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