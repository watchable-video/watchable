class Account < ApplicationRecord

  has_many :videos, foreign_key: :cloudkit_id, primary_key: :cloudkit_id

end
