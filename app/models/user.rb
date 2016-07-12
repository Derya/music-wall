require 'uri'

class User < ActiveRecord::Base
  validates :username, presence: true, length: { maximum: 127 }
  validates :password, presence: true, length: { maximum: 127 }
  validates :email, presence: true, length: { maximum: 127 }
  validate :email_is_valid

  before_validation :fix_url

  private

    def email_valid
      if (picture_url && !picture_url.empty?) && picture_url.scan(URI.regexp).empty?
        errors.add(:picture_url, "must be a valid url")
      end
    end

    def fix_url
      self.profile_pic_url = self.profile_pic_url.fix_url if profile_pic_url
    end
  
end



  # create_table "users", force: :cascade do |t|
  #   t.string   "username"
  #   t.string   "password"
  #   t.string   "profile_pic_url"
  #   t.text     "biography"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end