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

