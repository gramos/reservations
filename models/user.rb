class User < Sequel::Model
  include Shield::Model

  def self.fetch(username)
    User.where(username: username).first
  end

end
