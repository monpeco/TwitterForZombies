##Name Scope

_*File*_: ``

```ruby

```

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
class UserController < ApplicationController
    
    # GET /users/3          <%= link_to 'show', zombie %>
    def show
    
    end
    
    # POST /users          <%= link_to 'create', zombie, method: :post %>
    def create          # Typically it will be a form
    
    end
    
    # PUT /users/3          <%= link_to 'update', zombie, method: :put %>
    def update          # Typically it will be a form
    
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

_*File*_: `app/config/routes.rb`

```ruby
resources :zombies
```
This creates all "RESTful" rails routes

####To list all routes
```ruby
$ rake routes
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







