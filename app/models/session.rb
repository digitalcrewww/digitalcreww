class Session < ApplicationRecord
  belongs_to :user
  before_create :set_expiration

  scope :active, -> { where('expires_at > ?', Time.current) }

  private

  def set_expiration
    self.expires_at = 2.weeks.from_now
  end
end
