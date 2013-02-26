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
    "lib/templates/404.php",
    "lib/templates/archive.php",
    "lib/templates/comments.php",
    "lib/templates/footer.php",
    "lib/templates/functions.php",
    "lib/templates/header.php",
    "lib/templates/index.php",
    "lib/templates/page-template.php",
    "lib/templates/page.php",
    "lib/templates/post-type.php",
    "lib/templates/screenshot.png",
    "lib/templates/search.php",
    "lib/templates/searchform.php",
    "lib/templates/sidebar.php",
    "lib/templates/single.php",
    "lib/templates/style.css",
    "lib/templates/css/ie.css",
    "lib/templates/css/reset.css",
    "lib/templates/inc/meta.php",
    "lib/templates/inc/nav.php",
    "lib/templates/inc/paging.php",
    "lib/templates/js/functions.js"
  ]
  s.executables << 'wpgen'
end