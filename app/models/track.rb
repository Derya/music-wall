require 'uri'

class Track < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 127 }
  validates :author, presence: true, length: { maximum: 127 }
  validate :song_url_valid
  validate :img_url_valid

  before_validation :fix_urls

  private

    def song_url_valid
      if (song_url && !song_url.empty?) && song_url.scan(URI.regexp).empty?
        errors.add(:song_url, "must be a valid url")
      end
    end

    def img_url_valid
      if (picture_url && !picture_url.empty?) && picture_url.scan(URI.regexp).empty?
        errors.add(:picture_url, "must be a valid url")
      end
    end

    def fix_urls
      if song_url && !song_url.empty? && !song_url.starts_with?('http')
        self.song_url.prepend("http://")
      end
      if picture_url && !picture_url.empty? && !picture_url.starts_with?('http')
        self.picture_url.prepend("http://")
      end
    end
  
end


