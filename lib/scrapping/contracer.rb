class CongressTracker < ApplicationRecord
  include HTTParty

  def self.response
    #congress = "most recent congress"
    #chamber = "one each for congress and senate"
    #type = "introduced, passed, etc."

    congress_url = "https://api.propublica.org/congress/v1/115/senate/bills/passed.json"

    HTTParty.get(congress_url,
        :headers => {
        "X-API-KEY" => "api-key-here"
        })
  end
end


class Bill < ApplicationRecord
  include HTTParty
end