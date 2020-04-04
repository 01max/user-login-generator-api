# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    login { Faker::Lorem.characters(3).upcase }
  end
end