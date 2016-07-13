
class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :track
  validates :user_id, presence: true
  validates :track_id, presence: true
  validate :content_is_good
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validate :review_uniqueness

  private

    def content_is_good
      if content.nil? || content.empty?
        errors.add(:content, "can't be blank")
      else
        errors.add(:content, "must be longer than 10 characters") if content.length <= 10
        errors.add(:content, "must be shorter than 400 characters") if content.length >= 400
      end
    end

    def review_uniqueness
      if self.user.reviewed_track?(self.track)
        errors.add(:base, "this review already exists")
      end
    end

end