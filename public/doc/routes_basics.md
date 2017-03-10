#Routes

To view all the routes of your application

    rake routes

To see only the routes that map to a particular controller:

    rake routes -c static_pages

###Concerns

To avoid repetition in nested routes, concerns provide a great way of sharing common resources that are reusable. To create a concern use the method concern within the routes.rb file. The method expects a symbol and block:

    concern :commentable do
      resources :comments
    end

While not creating any routes itself, this code allows using the :concerns attribute on a resource. The simplest example would be:

    resource :page, concerns: :commentable

The equivalent nested resource would look like this:

    resource :page do
      resource :comments
    end

This would build, for example, the following routes:

    /pages/#{page_id}/comments
    /pages/#{page_id}/comments/#{comment_id}

For concerns to be meaningful, there must be multiple resources that utilize the concern. Additional resources could use any of the following syntax to call the concern:

    resource :post, concerns: %i(commentable)
    resource :blog do
      concerns :commentable
end

###Root route
You can add a home page route to your app with the root method.

    # config/routes.rb
    Rails.application.routes.draw do
      root "zombies#index"
      
      # equivalent to:
      # get "/", "application#index"  
    end

Because the homepage is usually the most important route, and routes are 
prioritized in the order they appear, the root route should usually be 
the first in your routes file.

