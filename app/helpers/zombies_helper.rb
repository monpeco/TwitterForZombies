module ZombiesHelper

    #The bad way
    def add_to_cookie (id)
        unless cookies[:scotids]
            cookies[:scotsids] = JSON.generate(["#{id}"])
        else
            cookies[:scotsids] = JSON.parse(cookies[:scotsids]) << "#{id}"
        end
    end

    #The not so bad way
    def add_to_cookie_2 (id)
        cookies[:scotids] ? cookies[:scotsids] = JSON.parse(cookies[:scotsids]) << "#{id}" : cookies[:scotsids] = JSON.generate(["#{id}"])
    end
end
