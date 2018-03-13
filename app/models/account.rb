class Account < ApplicationRecord

  has_many :videos, foreign_key: :cloudkit_id, primary_key: :cloudkit_id

  after_create_commit :refresh

  def refresh
    RefreshJob.perform_later self
  end

end
