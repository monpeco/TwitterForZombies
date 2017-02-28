b = { id: 3, status: "I just ate...", zombie: "Jim" }
puts b[:id]
puts b[:zombie]
puts b[:zombie] + " said: " + b[:status]

#Create
t = Tweet.new
t.status = "I love brains"
t.zombie_id = 1
t.save

t = Tweet.new
t.status = "McDonalds is so nice"
t.zombie_id = 1
t.save

#Read
t = Tweet.find(2)

#Update
t = Tweet.find(2)
t.status = "McDonalds is so terrific"
t.save

#Delete
t = Tweet.find(2)
t.destroy

#Alternative syntax
t = Tweet.new(
    status: "This brain is so delicious",
    zombie_id: 1)
t.save

t = Tweet.create(
    status: "I've just ate a bad brain",
    zombie_id: 1)
    
#Recover from db
Tweet.first
Tweet.last
Tweet.all

Tweet.count
Tweet.order(:status)
Tweet.limit(2)
Tweet.where(body: "The body")

#Method channing
Tweet.where(zombie_id: 1).order(:status).limit(2)

#Update a zombie
t = Tweet.find(2)
t.zombie = "EyeballChomper"
t.save

t = Tweet.find(2)
t.attributes = {
    status: "This brain is so delicious",
    zombie_id: 1 }
t.save

t = Tweet.find(2)
t.update(
    status: "This brain is so delicious",
    zombie_id: 1)

#Delete
t = Tweet.find(2)
t.destroy

t = Tweet.find(2).destroy

Tweet.destroy_all


#Aditionals

#To retrieve all models
ActiveRecord::Base.connection.tables.map do |model|
  model.capitalize.singularize.camelize
end
# => ["SchemaMigration", "Zombie", "Tweet", "Brain"] 

ActiveRecord::Base.connection.tables
# => ["schema_migrations", "zombies", "tweets", "brains"] 

#To retrive columns names of a Model
Tweet.column_names
# => ["id", "status", "body", "zombie_id", "created_at", "updated_at"] 
Brain.column_names
# => ["id", "zombie_id", "status", "flavor", "created_at", "updated_at"] 

#From http://guides.rubyonrails.org/active_record_querying.html

#Retrieving a Single Object
t = Tweet.take          #take a record (no particular order)

t = Tweet.take(2)       #take 2 records (no particular order)

t = Tweet.take!         #take! behaves equal, but raise a ActiveRecord::RecordNotFound if no matching record is found

Tweet.find_by status: 'I love brains'       #This two are equivalents
Tweet.where(status: 'I love brains').take

Tweet.find_by! status: 'I love brains'       #Same but raise a ActiveRecord::RecordNotFound if no matching record is found
Tweet.where(status: 'I love brains').take!

# This is very inefficient when has thousands of rows.
Tweet.all.each do |tweet|
  p tweet.status
end