class Account < ApplicationRecord

  has_many :videos, foreign_key: :cloudkit_id, primary_key: :cloudkit_id

  after_create_commit :refresh

  store_accessor :settings, :initial_sync_complete

  def refresh
    RefreshJob.perform_later self
  end

  def initial_sync_complete
    !!super
  end

end
