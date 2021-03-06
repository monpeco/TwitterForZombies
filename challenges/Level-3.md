##Understanding REST
 1. Resources (noum)
   * addressable through URI
 2. Standard methods (verb)
   * GET, POST, PUT, DELETE

RESTful Web Services
by Leonard Richardson & Sam Ruby

####Bad code

 1. Lends itself to huge controllers
 2. Multple model per controllers (It should be 1 resource per controller)
```ruby
class UserController < ApplicationController

    def login_towebsite
    
    end
    
 
    def subscribe_to_mailing_list
    
    end
    
 
    def process_credit_card_transaction
    
    end
    
    
```



####Still bad code

 1. Repeating the VERB
 
```ruby
class UserController < ApplicationController
    
    # GET /users/show/3
    def show
    
    end
    
    # POST /users/create
    def create
    
    end
    
    # POST /users/update/
    def update
    
    end    
 
    # POST /users/destroy/3
    def destroy
    
    end
    
    
```

| Verb (Rails 1)   | Noun | Verb (Rails 2+)    | Noun |
|---------|------|----------|------|
| GET  | /users/show/3    | GET     | /users/3 |
| POST | /users/create    | POST    | /users   |
| POST | /users/update/3  | PUT     | /users/3 |
| POST | /users/destroy/3 | DELETE  | /users/3 |

####Good code

 
```ruby
#to link to each action

zombie = Zombie.find(2)
```

```ruby
class UserController < ApplicationController
    
    # GET /users/3          <%= link_to 'show', zombie %>
    def show
    
    end
    
    # POST /users          <%= link_to 'create', zombie, method: :post %>
    def create              # Typically it will be a form
    
    end
    
    # PUT /users/3          <%= link_to 'update', zombie, method: :put %>
    def update              # Typically it will be a form
    
    end    
 
    # DELETE /users/3        <%= link_to 'update', zombie, method: :delete %>
    def destroy
    
    end
    
    
```

####Explaining PUT and DELETE

This code
```rails
<%= link_to 'update', zombie, method: :put %>
<%= link_to 'delete', zombie, method: :delete %>
```

Will generate this code on our page (2 HTML5 data attributes)
```rails
<a href="/zombies/4" data-method="put" rel="nofollow">update</a>
<a href="/zombies/4" data-method="delete" rel="nofollow">delete</a>

```

That rails, by default, has unobtrusive JavaScript, that looks for this attributes
```
<form method="post" action="/zombies/4">
  <input name="_method" values="delete">
</form>
```

And from that, creates `form`, and `_method` is set as method (verb) by rails


##Rake routes

_*File*_: `config/routes.rb`

```ruby
resources :zombies
```
This creates all "RESTful" rails routes

####To list all routes
```ruby
$ rake routes

     Prefix Verb   URI Pattern                 Controller#Action
    zombies GET    /zombies(.:format)          zombies#index
            POST   /zombies(.:format)          zombies#create
 new_zombie GET    /zombies/new(.:format)      zombies#new
edit_zombie GET    /zombies/:id/edit(.:format) zombies#edit
     zombie GET    /zombies/:id(.:format)      zombies#show
            PATCH  /zombies/:id(.:format)      zombies#update
            PUT    /zombies/:id(.:format)      zombies#update
            DELETE /zombies/:id(.:format)      zombies#destroy
```

How to use `link_to` with the path
```ruby
<%= link_to 'All Zombies', zombies_path %>
<%= link_to 'New Zombie' , new_zombie_path %>
<%= link_to 'Edit Zombie', edit_zombie_path(@zombie) %>
<%= link_to 'Show Zombie', zombie_path(@zombie) %>
<%= link_to 'Show Zombie', @zombie %>

```

####Absolute path

| Relative path | result | 
|---------------|--------|
| zombies_path  | /zombies |
| new_zombie_path  | /zombies/new |

| Absolute path | result | 
|---------------|--------|
| zombies_path_url  | http://localhost:3000/zombies |
| new_zombie_path_url  | http://localhost:3000//zombies/new |


##Creating a FORM

Both create and update zombie form

```ruby
<%= form_for(@zombie) do |f| %>
  ...
<% end %>
```

If `@zombie` isn´t saved to the database yet 
```ruby
<form action="/zombie" method="post">
```

If `@zombie` is saved to the database
```ruby
<form action="/zombie/8" method="post">
  <input name="_method" type="hidden" value="put" />
```

##Submit button

Both create and update zombie form

```ruby
  <%= f.submit %>
```

If `@zombie` isn´t saved to the database yet 
```ruby
  <input name="commit" type="submit" value="Create Zombie" />
```

If `@zombie` is saved to the database
```ruby
  <input name="commit" type="submit" value="Update Zombie" />
```


##Text_field Helper

When submitted, request parameters
```ruby
  :params => {:zombie => {:name => "Eric"}}
  #Can be viewed from log in the log/ directory
```

The text_field helper
```ruby
  <%= f.text_field :name %>
```

If `@zombie` isn´t saved to the database yet 
```ruby
  <input name="zombie[name]" size="30" type="text" />
```

If `@zombie` is already saved to the database
```ruby
  <input name="zombie[name]" size="30" type="text" value="Eric" />
```

If `@zombie.name` has a validation error
```ruby
  <div class="field_with_errors" >
    <input name="zombie[name]" size="30" type="text" value="" />
  </div>
```


##Label Helper


```ruby
  <%= f.label :name %><br />
```

Will render
```ruby
  <label for="zombie_name">Name</label>
```

If `@zombie.name` has a validation error
```ruby
  <div class="field_with_errors" >
    <label for="zombie_name">Name</label>
  </div>
```



##Input helpers

Render a multiline text area
```ruby
  <%= f.text_area :bio %>
```

Check box used for booleans
```ruby
  <%= f.check_box :rotting %>
```

List of radio buttons (without thir labels)
```ruby
  <%= f.radio_button :decomp, 'fresh', checked: true %>
  <%= f.radio_button :decomp, 'rotting' %>
  <%= f.radio_button :decomp, 'stale' %>
```

Select box with three options
```ruby
  <%= f.select :decomp, ['fresh', 'rotting', 'stale' ] %>
```

Select box with three options, each with numerical value
```ruby
  <%= f.select :decomp, [['fresh',1], ['rotting',2], ['stale',3] ] %>
```

##Alternate text input helper
```ruby
  <%= f.password_field :password %>
```
```ruby
  <%= f.number_field :price %>
```
```ruby
  <%= f.range_field :quantity %>
```
```ruby
  <%= f.email_field :email %>
```
```ruby
  <%= f.url_field :website %>
```
```ruby
  <%= f.telephone_field :mobile %>
```

##Nested routes
_*File*_: `config/routes.rb`

```ruby
TwitterForZombies::Application.routes.draw do

  resources :zombies
  resources :tweets

end
```

With this routes, we will have to write:

 * `/tweets/2` to find a tweet
 * `/tweets?zombie_id=4` To find all zombie´s tweets

_*Not very RESTful*_
_*Tweets shouldn't exists without a zombie*_

So, to make it RESTful we need to nest `tweets` inside `zombie`

```ruby
TwitterForZombies::Application.routes.draw do

  resources :zombies do
    resources :tweets
  end
  
end
```

This give us access to differente url's

 * `zombies/4/tweets/2` to find a tweet
 * `/zombies/4/tweets` To find all zombie´s tweets

To make this work, we must:
 1. Update the controller
 2. Update all the links & from_for

##Updating the controller for nesting

Show => `Tweet` número 2 del `Zombie` número 4

`zombies/4/tweets/2`
params = {:zombie_id => 4, :id => 2}


```ruby
class TweetsController < ApplicationController
    before_filter :get_zombie
    
    def get_zombie
      @zombie = Zombie.find(params[:zombie_id])
    end
    
    def show
      @tweet = @zombie.tweets.find(params[:id])
    
    end
```

Show => todos los `Tweet` del `Zombie` número 4

`zombies/4/tweets`
params = {:zombie_id => 4}


```ruby
class TweetsController < ApplicationController
    before_filter :get_zombie
    
    def get_zombie
      @zombie = Zombie.find(params[:zombie_id])
    end
    
    def index
      @tweets = @zombie.tweets
    
    end
```

####Before tweets resource
```ruby
     Prefix Verb   URI Pattern                 Controller#Action
    zombies GET    /zombies(.:format)          zombies#index
            POST   /zombies(.:format)          zombies#create
 new_zombie GET    /zombies/new(.:format)      zombies#new
edit_zombie GET    /zombies/:id/edit(.:format) zombies#edit
     zombie GET    /zombies/:id(.:format)      zombies#show
            PATCH  /zombies/:id(.:format)      zombies#update
            PUT    /zombies/:id(.:format)      zombies#update
            DELETE /zombies/:id(.:format)      zombies#destroy
```

####After tweets resource
```ruby
     Prefix Verb   URI Pattern                 Controller#Action
     tweets GET    /tweets(.:format)           tweets#index
            POST   /tweets(.:format)           tweets#create
  new_tweet GET    /tweets/new(.:format)       tweets#new
 edit_tweet GET    /tweets/:id/edit(.:format)  tweets#edit
      tweet GET    /tweets/:id(.:format)       tweets#show
            PATCH  /tweets/:id(.:format)       tweets#update
            PUT    /tweets/:id(.:format)       tweets#update
            DELETE /tweets/:id(.:format)       tweets#destroy
    zombies GET    /zombies(.:format)          zombies#index
            POST   /zombies(.:format)          zombies#create
 new_zombie GET    /zombies/new(.:format)      zombies#new
edit_zombie GET    /zombies/:id/edit(.:format) zombies#edit
     zombie GET    /zombies/:id(.:format)      zombies#show
            PATCH  /zombies/:id(.:format)      zombies#update
            PUT    /zombies/:id(.:format)      zombies#update
            DELETE /zombies/:id(.:format)      zombies#destroy            
```            

####After tweet nested to zombie
```ruby
           Prefix Verb   URI Pattern                                   Controller#Action
    zombie_tweets GET    /zombies/:zombie_id/tweets(.:format)          tweets#index
                  POST   /zombies/:zombie_id/tweets(.:format)          tweets#create
 new_zombie_tweet GET    /zombies/:zombie_id/tweets/new(.:format)      tweets#new
edit_zombie_tweet GET    /zombies/:zombie_id/tweets/:id/edit(.:format) tweets#edit
     zombie_tweet GET    /zombies/:zombie_id/tweets/:id(.:format)      tweets#show
                  PATCH  /zombies/:zombie_id/tweets/:id(.:format)      tweets#update
                  PUT    /zombies/:zombie_id/tweets/:id(.:format)      tweets#update
                  DELETE /zombies/:zombie_id/tweets/:id(.:format)      tweets#destroy
          zombies GET    /zombies(.:format)                            zombies#index
                  POST   /zombies(.:format)                            zombies#create
       new_zombie GET    /zombies/new(.:format)                        zombies#new
      edit_zombie GET    /zombies/:id/edit(.:format)                   zombies#edit
           zombie GET    /zombies/:id(.:format)                        zombies#show
                  PATCH  /zombies/:id(.:format)                        zombies#update
                  PUT    /zombies/:id(.:format)                        zombies#update
                  DELETE /zombies/:id(.:format)                        zombies#destroy
```                   


####Links of the new routes

```ruby
<%= link_to "{#@zombie.name}'s Tweets" , zombie_tweet_path(@zombie) %>

<%= link_to "New Tweet" , new_zombie_tweet_path(@zombie) %>

<%= link_to "Edit" , edit_zombie_tweet_path(@zombie, tweet) %>

<%= link_to "Show" , zombie_tweet_path(@zombie, tweet) %>

<%= link_to "Show" , [@zombie, tweet] %>

<%= link_to "Destroy" , [@zombie, tweet], method: :delete %>
```

##Links in action

_*File*_: `app/views/tweets/index.html.erb`

```ruby
<% @tweets.each do |tweet| %>
  <tr>
    <td><%= tweet.body %></td>
    <td><%= link_to 'Show', [@zombie, tweet] %></td>
    <td><%= link_to 'Edit', edit_zombie_tweet_path(@zombie, tweet) %></td>
    <td><%= link_to 'Destroy', [@zombie, tweet], method: :delete %></td>
  </tr>
<% end %>

<%= link_to 'New Tweet', new_zombie_tweet_path(@zombie, tweet) %>

```


_*File*_: `app/views/tweets/_form.html.erb`

```ruby
<%= form_for([@zombie, tweet]) do |f|  %>

```

###Updating routes in the controller

_*File*_: `app/controllers/tweets_controller.rb`

####Original
```ruby
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end
```


####Modificacion
```ruby
  def create
    @tweet = @zombie.tweets.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to [@zombie, @tweet], notice: 'Tweet was successfully created.' }
        format.json { render [@zombie, @tweet], status: :created, location:  [@zombie, @tweet] }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end
```

###Partials

_*File*_: `app/views/tweets/_form.html.erb`

```ruby
<%= form_for([@zombie, tweet]) do |f|  %>
```


_*File*_: `app/views/tweets/new.html.erb`

```ruby
<h1>New tweet<h1>

<%= render 'form'  %>

<%= link_to 'Back', zombie_tweets_path(@zombie)  %>
```


_*File*_: `app/views/tweets/edit.html.erb`

```ruby
<h1>Edit tweet<h1>

<%= render 'form'  %>

```


###Aditional view helpers

```ruby
<% @tweets.each do |tweet|  %>
  <div id="<%= tweet.id  %>" class="tweet">
    <%= tweet.body  %>
  </div>
<% end  %>
```

####Use of the div_for helper
```ruby
<% @tweets.each do |tweet|  %>
  <%= div_for tweet do %>
    <%= tweet.body  %>
  <% end %>
<% end  %>
```
It's calling the `dom_id(@tweet)` and that is how It gets the `id` of the `tweet`

####Adicional view helpers (string)
```ruby
<%= truncate("I need brains", :length => 10)  %>

<%= truncate("I need brains", :length => 10, :separator => ' ')  %>

I see <%= pluralize(Zombie.count, "zombie") %>

His name was <%= @zombie.name.titleize %>

```


```ruby
Ash's zombie roles are <%= @role_names.to_sentence %>
# => Ash's zombie roles are Capitan, Soldier, and Brain Taster

He was buried alive <%= time_ago_in_words @zombie.created_at %> ago
# => He was buried alive 2 days ago

Price is <%= number_to_currency 13.5%> 
# => Price is $ 13.5

Ash is <%= number_to_human 12446513254 %> years old
# => Ash is 12.4 Billion years old

```

