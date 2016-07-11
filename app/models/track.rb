class Track < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 127 }
  validates :author, presence: true, length: { maximum: 127 }
  validates :song_url, format: { with: /[a-z]/, message: "must be a url" }, allow_nil: true
  validates :picture_url, format: { with: /[a-z]/, message: "must be a url" }, allow_nil: true
  
end

#@^(https?|ftp)://[^\s/$.?#].[^\s]*$@iS