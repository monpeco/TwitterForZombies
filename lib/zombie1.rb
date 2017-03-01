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


#Conditions
Tweet.where(status: "McDonalds is so TERRIFIC")

params = "I love brains"
Tweet.where("status = ?", params)

status = "Im hungry"
body = "This is a long body"
Tweet.where("status = ? and body = ?", status, body) 

params1="2017-02-28 12:31:48"
params2="2017-02-28 12:51:48"
Tweet.where("created_at >= :start_date AND created_at <= :end_date",
  {start_date: params1, end_date: params2})


Tweet.where(zombie_id: true)        #A boolean is interpreted as a number
                                    #SELECT "tweets".* FROM "tweets" WHERE "tweets"."zombie_id" = 1

Tweet.where('zombie_id' => true)    #It also can be a string

#Range Conditions
Tweet.where(created_at: (Time.now.midnight - 2.day)..Time.now.midnight) 
 #SELECT "tweets".* FROM "tweets" WHERE ("tweets"."created_at" BETWEEN '2017-02-26 00:00:00.000000' AND '2017-02-28 00:00:00.000000')
 
#Subset conditions
Tweet.where(id: [1,3,5])
#SELECT "tweets".* FROM "tweets" WHERE "tweets"."id" IN (1, 3, 5)

Tweet.where.not(id: [1,3,5])
#SELECT "tweets".* FROM "tweets" WHERE ("tweets"."id" NOT IN (1, 3, 5))

#ordering
Tweet.order(:status)
#SELECT "tweets".* FROM "tweets"  ORDER BY "tweets"."status" ASC

Tweet.order(status: :desc)
# SELECT "tweets".* FROM "tweets"  ORDER BY "tweets"."status" DESC

Tweet.order(zombie_id: :desc, status: :asc)
# SELECT "tweets".* FROM "tweets"  ORDER BY "tweets"."zombie_id" DESC, "tweets"."status" ASC

Tweet.order(zombie_id: :desc).order(status: :asc)
# SELECT "tweets".* FROM "tweets"  ORDER BY "tweets"."zombie_id" DESC, "tweets"."status" ASC

#Selecting Specific Fields
Tweet.select(:id, :status)
# SELECT "tweets"."id", "tweets"."status" FROM "tweets"

#Joining Tables

Category.joins(:articles)


#Validations
class Zombie < ActiveRecord::Base
    validates :name, presence: true
end

#note: run reload! to load the validations

#updates
Zombie.update_all "rotting = 1"

#To check everyone
Zombie.all.each do |zombie|
  print zombie.name
  puts zombie.rotting
end
