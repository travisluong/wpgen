$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'wpgen'

# TODO: Below, change the gem name, authors, and email

Gem::Specification.new do |s|
  s.name        = 'wpgen'
  s.version     = Wpgen::VERSION
  s.date        = '2013-02-22'
  s.summary     = "WordPress blank theme generator"
  s.description = "A command line program for generating blank themes"
  s.authors     = ["Travis Luong"]
  s.email       = 'travis@travisluong.com'
  s.homepage    = 'http://rubygems.org/gems/wpgem'
  s.files       = [
    "lib/wpgen.rb",
    "lib/wpgen/command_line_interface.rb",
    "lib/wpgen/generator.rb",
    "lib/wpgen/file_writer.rb",
    "lib/wpgen/version.rb",
    "lib/wpgen/css_gen.rb",
    "templates/404.php",
    "templates/archive.php",
    "templates/comments.php",
    "templates/footer.php",
    "templates/functions.php",
    "templates/header.php",
    "templates/index.php",
    "templates/page-template.php",
    "templates/page.php",
    "templates/post-type.php",
    "templates/register-sidebar.php",
    "templates/screenshot.png",
    "templates/search.php",
    "templates/searchform.php",
    "templates/sidebar.php",
    "templates/single.php",
    "templates/style.css",
    "templates/css/ie.css",
    "templates/css/reset.css",
    "templates/inc/meta.php",
    "templates/inc/nav.php",
    "templates/inc/paging.php",
    "templates/js/functions.js"
  ]
  s.executables << 'wpgen'
end