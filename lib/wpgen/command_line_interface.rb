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

    end

    def sidebar

    end
  end
end

