module DBSeed
  class Cities
    def self.run!
      DB[:cities].insert(:name => 'Rosario')
      DB[:cities].insert(:name => 'San Nicolas')
    end
  end
end
