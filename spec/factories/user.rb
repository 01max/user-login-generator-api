# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    login { Faker::Lorem.characters(number: 3, min_alpha: 3).upcase }
  end
end
