module DBSeed
  class Users
    def self.run!
      User.create(:first_name => 'La Casa',
                        :last_name => 'Tech',
                        :username => 'lacasa',
                        :password => '12345678')

      User.create(:first_name => 'Gustavo Ariel',
                        :last_name => 'Yarros',
                        :username => 'gyarros',
                        :password => 'gyarros.26719728')

      User.create(:first_name => 'Marina Denise',
                        :last_name => 'Arenas',
                        :username => 'marenas',
                        :password => 'marenas.36008581')

      User.create(:first_name => 'Jesica',
                        :last_name => 'Garcia',
                        :username => 'jgarcia',
                        :password => 'jgarcia.27674287')

    end
  end
end
