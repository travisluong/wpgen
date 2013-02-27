module Wpgen
  class CssGen
    def self.get_ids file
      File.open(file, "r") do |f|
        string = f.read
        array = string.scan(/id="([^"<]*)"/)
        array.map { |id| id[0] }
      end
    end

    def self.get_classes file
      File.open(file, "r") do |f|
        string = f.read
        array = string.scan(/class="([^"<]*)"/)
        array.map { |c| c[0] }
      end
    end

    def self.generate_id_css array
      css = ""
      array.each do |id|
        css << "##{id} {\n\n}\n\n"
      end
      css
    end

    def self.generate_class_css array
      css = ""
      array.each do |css_class|
        css << ".#{css_class} {\n\n}\n\n"
      end
      css
    end
  end
end