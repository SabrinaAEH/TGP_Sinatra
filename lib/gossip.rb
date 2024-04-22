require 'csv'

class Gossip
    attr_reader :id, :author, :content

    def initialize(id, author, content)
        @id = id
        @author = author
        @content = content
    end
   
    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
          csv << [id, author, content]
        end
    end

    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1], csv_line[2])
        end
        return all_gossips
    end

    def self.generate_id
        self.all.length + 1
    end

    def self.find(id)
        all_gossips = self.all
        all_gossips.find { |gossip| gossip.id.to_i == id.to_i }
    end
      

  end

