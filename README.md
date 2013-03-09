#wpgen

wpgen is a command line tool for generating blank WordPress themes.

##Installation

    gem install wpgen

##Commands

Create new theme

    $ wpgen new my_theme
    
Create custom post type

    $ wpgen post my_post
    
Create page template

    $ wpgen page my_page

Create dynamic sidebar

    $ wpgen sidebar my_sidebar

Extract css selectors from file and append to style.css

    $ wpgen css file_name

Extract css selectors from all php files and append to style.css

    $ wpgen stylesheet

Help

    $ wpgen help

##License
wpgen is released under the [MIT License](http://opensource.org/licenses/MIT).
