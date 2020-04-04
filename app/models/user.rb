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

    def possible_logins(length: 3)
      expected_login_chars.repeated_permutation(length).to_a.map(&:join)
    end
  end
end
