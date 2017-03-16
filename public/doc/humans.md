###Humans
Generate resource

    rails generate scaffold Human name:string power:string age:integer description:text fighting:boolean

Run migration

    rake db:migrate
    
Routes

    rake routes
    
    ```
               Prefix Verb   URI Pattern                                   Controller#Action
            humen GET    /humen(.:format)                              humen#index
                  POST   /humen(.:format)                              humen#create
        new_human GET    /humen/new(.:format)                          humen#new
       edit_human GET    /humen/:id/edit(.:format)                     humen#edit
            human GET    /humen/:id(.:format)                          humen#show
                  PATCH  /humen/:id(.:format)                          humen#update
                  PUT    /humen/:id(.:format)                          humen#update
                  DELETE /humen/:id(.:format)                          humen#destroy
    ```

   
###Restring routes 

      resources :humen, only: :show

      resources :humen, except: [:show, :edit, :update]

###Using with_options

     with_options only: :index do |list_only|
       list_only.resources :zombie
       list_only.resources :humen
       list_only.resources :other
         ...
     end    

###Using constrains to enforce subdomain

keeping our API under its own **subdomain** allows **load balancing** 
traffic at the DNS level.

    #file: config/routes.rb
    resources :episodes  
    resources :zombies, constrains: { subdomain: "api" }
    resources: :episodes, constrains: { subdomain: "api" }
  
Or in this way
    
    #file: config/routes.rb
    resources: :episodes
    
    constrains subdomain: "api" do
      resources :zombies
      resources :human
    end 
    
    
###Using namespaces to keep controller organized
When site and api share the same code based

    #file: config/routes.rb

    constrains subdomain: "api" do
      namespace :api do
        resources :zombies
        resources :human
      end
    end 

This inplies that the `zombies_controller.rb`
needs to go inside the `api` module

the file must be:

    app/controllers/api/zombies_controller.rb
    
and its contents

    module Api
      class ZombiesController < ApplicationController
      end
    end
  
###Removig duplication from the URL

    #file: config/routes.rb

    constrains subdomain: "api" do
      namespace :api, path: "/" do
        ...
      end
    end 
  
###Shorter syntax

    #file: config/routes.rb

    namespace :api, path: "/", constrains: { subdomain: "api" } do
    ...
    end


###Check the fields of a model

Just type:

    Human
    => Human(id: integer, name: string, power: string, age: integer, description: text, fighting: boolean, created_at: datetime, updated_at: datetime) 

  
###Using Find_by_attribute

This recover a record by just using a dynamic finder that makes use of Ruby’s `method_missing` functionality:

    h = Human.find_by_power("Operations")
     => #<Human id: 1, name: "Pedro", power: "Operations", age: 45, description: "Plastic surgeon", fighting: true, created_at: "2017-03-12 01:00:22", updated_at: "2017-03-12 01:00:22"> 
    #
    #New syntax
    h = Human.find_by(power: "Operations")
     => #<Human id: 1, name: "Pedro", power: "Operations", age: 45, description: "Plastic surgeon", fighting: true, created_at: "2017-03-12 01:00:22", updated_at: "2017-03-12 01:00:22"> 

###Use Update_attributes

    h = Human.find_by(power: "Operations")
     => #<Human id: 1, name: "Pedro", power: "Operations", age: 45, description: "Plastic surgeon", fighting: true, created_at: "2017-03-12 01:00:22", updated_at: "2017-03-12 01:00:22"> 
    #
    h.update_attributes(age: 30)
      SQL (3.4ms)  UPDATE "humen" SET "age" = ?, "updated_at" = ? WHERE "humen"."id" = ?  [["age", 30], ["updated_at", "2017-03-14 16:50:47.767813"], ["id", 1]]
    #
    h = Human.find_by(power: "Operations")
     => #<Human id: 1, name: "Pedro", power: "Operations", age: 30, description: "Plastic surgeon", fighting: true, created_at: "2017-03-12 01:00:22", updated_at: "2017-03-14 16:50:47"> 

###Other finders

    Person.fifth
    # => #<Human id: 5, name: "Chipper", power: "Batting", age: 40, description: "Best baseball player", fighting: true, created_at: "2017-03-16 11:56:18", updated_at: "2017-03-16 11:56:18"> 
    
    












