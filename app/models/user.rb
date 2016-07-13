
class User < ActiveRecord::Base
  has_many :tracks, through: :upvotes
  has_many :upvotes
  has_many :reviews

  validates :username, presence: true, length: { maximum: 127 }, uniqueness: true
  validates :password, presence: true, length: { maximum: 127 }
  validates :email, presence: true, length: { maximum: 127 }, uniqueness: true
  validate :email_is_valid

  before_validation :fix_empty_strings
  before_validation :fix_url

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def upvoted_track?(track)
    self.tracks.include?(track)
  end

  def reviewed_track?(track)
    self.reviews.include?(track)
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

    def fix_empty_strings
      self.profile_pic_url = nil if self.profile_pic_url && self.profile_pic_url.empty?
    end
  
end