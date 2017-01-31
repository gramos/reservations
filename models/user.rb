class User < Sequel::Model
  include Shield::Model

  def self.fetch(username)
    User.where(username: username).first
  end

  def change_password(args)
    check_current = Shield::Password.check(args['current_password'],
                                           crypted_password)
    unless check_current
      errors.add(:current_password, 'Clave Incorrrecta')
      return false
    end

    check_confirmation = (args['new_password'] == args['password_confirmation'])

    unless check_confirmation
      errors.add(:password_confirmation, 'no coincide')
      return false
    end

    self.password = args['new_password']
    save
  end
end
