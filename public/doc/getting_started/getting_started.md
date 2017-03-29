##Link:
> http://guides.rubyonrails.org/getting_started.html

###4.2 Say "Hello", Rails

```ruby
$ rails g controller Welcome index

Running via Spring preloader in process 2332
Expected string default value for '--jbuilder'; got true (boolean)
Expected string default value for '--helper'; got true (boolean)
Expected string default value for '--assets'; got true (boolean)
      create  app/controllers/welcome_controller.rb
       route  get 'welcome/index'
      invoke  erb
      create    app/views/welcome
      create    app/views/welcome/index.html.erb
      invoke  test_unit
      create    test/controllers/welcome_controller_test.rb
      invoke  helper
      create    app/helpers/welcome_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/welcome.coffee
      invoke    scss
      create      app/assets/stylesheets/welcome.scss
      
```

in `app/views/welcome/index.html.erb`

```ruby
<h1>(A custom) Hello from welcome controller</h1>
<h2>index view</h2>
```

###4.3 Setting the Application Home Page

in `config/routes.rb`

```ruby
Rails.application.routes.draw do
  root 'welcome#index'
end
```

###5 Getting Up and Running

in `config/routes.rb`

```ruby
Rails.application.routes.draw do
  ...
  resources :articles     #create a new resource 'articles'
  
end

```

###5.1 Laying down the ground work

>  Routing Error   
>  uninitialized constant ArticlesController   


```ruby
$ rails generate controller Articles
```

```ruby
class ArticlesController < ApplicationController
end
```
--

>  Unknown action   
>  The action 'new' could not be found for ArticlesController   

```ruby
class ArticlesController < ApplicationController
  def new
  end
end
```

>  Template is missing
Missing template articles/new, application/new with {:locale=>[:en], :formats=>[:html], :variants=>[], :handlers=>[:erb, :builder, :raw, :ruby, :coffee, :jbuilder]}. 
Searched in: * "/home/ubuntu/workspace/TwitterForZombies/app/views"

create `/app/views/articles/new.html.erb`, and iside that file:

```ruby
<h2>This is the hand-made template</h2>
```

