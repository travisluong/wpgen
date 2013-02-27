module Wpgen
  class CommandLineInterface
    puts "class #{self} defined"
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
  end
end

