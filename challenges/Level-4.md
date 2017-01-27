##Create a zombie mailer

__Objetive__: Create email for desposition change and lost brain

```ruby
$ rails generate mailer ZombieMailer decomp_change lost_brain
```

_*File*_: `app/mailers/zombie_mailer.rb`
```ruby
class ZombieMailer < ActionMailer::Base

  default from: "from@example.com"

  def decomp_change
    @greeting = "Hi"    #Instance variablel we want in our views
    
    mail to: "to@example.org"
  end
  
  ...
  
end

```

```ruby
class ZombieMailer < ActionMailer::Base

  default from: "from@example.com"

  def decomp_change(zombie)
    @zombie = zombie
    @last_tweet = @zombie.tweets.last_tweet
    
    attachments['z.pdf'] = File.read("#{Rails.root}/public/zombie.pdf") 
    mail to: @zombie.email, subject: 'Your decomp stage has changed'
  end
  
  ...
  
end
```

####Aditional options
```ruby
from: "my@email.com"
cc: "my@email.com"
bcc: "my@email.com"
reply_to: "my@email.com"
```

####Mailer views

_*File*_: `app/views/zombie_mailer/decomp_change.text.erb`


```ruby

Greetings <%= @zombie.name%>

Your decomposition state is now <%= @zombie.decomp %> and your
last tweet was: <%= @last_tweet.body %>
```

If you want HTML emails, just rename text to html
from:
_*File*_: `app/views/zombie_mailer/decomp_change.text.erb`
to:
_*File*_: `app/views/zombie_mailer/decomp_change.html.erb`

```html

<h1> Greetings <%= @zombie.name%> </h1>

<p>Your decomposition state is now <%= @zombie.decomp %> and your
last tweet was: <%= @last_tweet.body %> </p>

<%= link_to "View yourself", zombie_url(@zombie) %>
```











