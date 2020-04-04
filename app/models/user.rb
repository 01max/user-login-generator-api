# frozen_string_literal: true

class User < ApplicationRecord
  validates :login, format: { with: /\A[A-Z]{3}\z/, message: 'must be composed of exactly 3 capital letters' },
                    uniqueness: true
end
