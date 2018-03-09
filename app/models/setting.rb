class Setting < ApplicationRecord
  belongs_to :account

  enum status: [google_credentials: 0]
end
