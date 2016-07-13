
class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :track
  validates :user_id, presence: true
  validates :track_id, presence: true
  validate :content_is_good
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  private

    def content_is_good
      if content.nil? || content.empty?
        errors.add(:content, "can't be blank")
      else
        errors.add(:content, "must be longer than 10 characters") if content.length <= 10
        errors.add(:content, "must be shorter than 400 characters") if content.length >= 400
      end
    end

end