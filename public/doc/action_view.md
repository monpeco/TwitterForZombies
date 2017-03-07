#Action View Overview

> http://guides.rubyonrails.org/action_view_overview.html

####2 Using Action View with Rails

    rails generate scaffold article
          [...]
          invoke  scaffold_controller
          create    app/controllers/articles_controller.rb
          invoke    erb
          create      app/views/articles
          create      app/views/articles/index.html.erb
          create      app/views/articles/edit.html.erb
          create      app/views/articles/show.html.erb
          create      app/views/articles/new.html.erb
          create      app/views/articles/_form.html.erb
          [...]
      
Typically, the views share their name with the associated controller action, as you can see above. For example, the index controller action of the articles_controller.rb will use the index.html.erb view file in the app/views/articles directory.
      
####3 Templates, Partials and Layouts

    <h1>Name of all zombies</h1>
    <% @Zombie.each do |zombie| %>
      Name: <%= zombie.name %>
    <% end %>

