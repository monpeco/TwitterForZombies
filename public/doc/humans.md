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