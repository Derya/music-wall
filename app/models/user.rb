require 'uri'

class User < ActiveRecord::Base
  validates :username, presence: true, length: { maximum: 127 }
  validates :password, presence: true, length: { maximum: 127 }
  validates :email, presence: true, length: { maximum: 127 }, uniqueness: true
  validate :email_is_valid

  before_validation :fix_url

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  private

    def profile_pic_url_valid
      if (profile_pic_url && !profile_pic_url.empty?) && profile_pic_url.scan(URI.regexp).empty?
        errors.add(:profile_pic_url, "must be a valid url")
      end
    end

    def email_is_valid
      #TODO
    end

    def fix_url
      self.profile_pic_url = self.profile_pic_url.fix_url if profile_pic_url
    end
  
end



# post '/session/new' do
#   user = User.find_by(email: params[:email])
#   if user and user.password == params[:password]
#     session[:id] = user.id
#     redirect '/'
#   else
#     redirect '/login'
#   end
# end

