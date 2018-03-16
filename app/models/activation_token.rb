class ActivationToken < ApplicationRecord

  before_create { generate_token(:token) }

  private

    def generate_token(column)
      loop do
        self[column] = SecureRandom.hex(2)
        if !self.class.where(column => self[column]).exists?
          break
        end
      end
    end

end
