#to override Clearance default method for user_from_params
class UsersController < Clearance::UsersController
  def user_from_params
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    dob = user_params.delete(:dob)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.first_name = first_name
      user.last_name = last_name
      user.dob = dob
      user.email = email
      user.password = password
    end
  end
end