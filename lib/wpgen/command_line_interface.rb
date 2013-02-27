module Wpgen
  class CommandLineInterface
    def initialize

    end

    def new
      FileWriter.new_theme ARGV[1]
    end

    def post
      FileWriter.write_custom_post_type ARGV[1]
    end

    def page
      FileWriter.write_page_template ARGV[1]
    end

    def sidebar
      FileWriter.write_dynamic_sidebar ARGV[1]
    end

    def css
      FileWriter.write_css ARGV[1]
    end

    def stylesheet
      FileWriter.write_stylesheet
    end

    def method_missing(m, *args, &block)
      help
    end

    def help
      puts "WPGEN"
      puts "Version: #{Wpgen::VERSION}"
      puts "Author: Travis Luong"
      puts ""
      puts "Available commands:"
      puts "wpgen new my_theme"
      puts "wpgen post my_post"
      puts "wpgen page my_page"
      puts "wpgen sidebar my_sidebar"
      puts "wpgen css file_name"
      puts "wpgen stylesheet"
    end
  end
end

