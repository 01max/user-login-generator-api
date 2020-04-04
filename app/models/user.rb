# frozen_string_literal: true

class User < ApplicationRecord
  validates :login, format: { with: /\A[A-Z]{3}\z/, message: 'must be composed of exactly 3 capital letters' },
                    uniqueness: true

  class << self
    def assigned_logins
      all.pluck(:login)
    end

    def expected_login_chars
      ('A'..'Z').to_a
    end
  end
end
