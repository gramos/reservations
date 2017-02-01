module DBSeed
  Class Users
    def self.run!
      User.create(:first_name => 'La Casa',
                        :last_name => 'Tech',
                        :username => 'lacasa',
                        :password => '12345678')

      User.create(:first_name => 'Gustavo',
                        :last_name => 'Yarros',
                        :username => 'gustavo',
                        :password => '12345678')

    end
  end
end
