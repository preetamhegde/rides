class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :rides

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :provider, :uid, :phone, :address
  # attr_accessible :title, :body
  #
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    if signed_in_resource
      signed_in_resource.update_attributes({:provider => auth.provider, :uid => auth.uid})
      return signed_in_resource
    end

    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      password = Devise.friendly_token[0,20]
      user = User.new({:name => auth.extra.raw_info.name,
                         :provider => auth.provider,
                         :uid => auth.uid,
                         :email => auth.info.email,
                         :password => password,
                         :password_confirmation => password}
                        )
      user.skip_confirmation!                  
      user.save!
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
