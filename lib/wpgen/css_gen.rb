module Wpgen
  class CssGen
    def self.get_ids string
        array = string.scan(/id="([^"<]*)"/)
        array.map { |id| id[0] }
    end

    def self.get_classes string
        array = string.scan(/class="([^"<]*)"/)
        array.map { |c| c[0] }
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