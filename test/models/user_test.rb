require_relative '../helper'

prepare do
  @user  = User.create(:first_name => 'Bruce', :last_name => 'Lee',
                      :username => 'brucelee', :password => '12345678')
   @args = {'current_password' => '12345678','new_password' => '87654321',
          'password_confirmation' => '87654321'}

end

test '#change_password' do
  assert @user.change_password(@args)
  assert Shield::Password.check('87654321', @user.crypted_password)
 
end

test 'change_password with confirmation wrong' do
  assert !@user.change_password(@args.merge('password_confirmation' => '656756' ))
  assert !@user.errors[:password_confirmation].empty?
end

test 'change_password with wrong current password' do
  assert !@user.change_password(@args.merge('current_password' => 'fruta' ))
  assert !@user.errors[:current_password].empty?
end

