class User < ActiveRecord::Base
  include Clearance::User

  # --- for omniauth-fb
  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      name = auth_hash["info"]["name"]
      #split the name obtained from fb to first name and last name
      name = name.strip.split(/\s+/)
      #pass the values to be stored in database
      u.first_name = name[0]
      u.last_name = name[1]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      #randomly generate password to be passed to Clearance during login with Facebook
      u.password = SecureRandom.hex(4)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end
  # --- for omniauth-fb
  
end
