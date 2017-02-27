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
