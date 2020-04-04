# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:existing_user) { FactoryBot.create(:user) }

  describe 'login regexp validation' do
    let(:regexp_validation_message) { 'must be composed of exactly 3 capital letters' }
    context 'when a new User has 3 capital letters as his login' do
      subject(:invalid_user_login_regexp_errors) do
        invalid_user = described_class.new(login: 'AAA')
        invalid_user.valid?
        invalid_user&.errors&.messages
      end

      it 'does not have this specific login error upon validation' do
        expect(invalid_user_login_regexp_errors.dig(:login)).not_to include(regexp_validation_message)
      end
    end

    context 'when a new User does not have 3 capital letters as his login' do
      subject(:invalid_user_login_regexp_errors) do
        invalid_user = described_class.new(login: 'invalid_login')
        invalid_user.valid?
        invalid_user&.errors&.messages
      end

      it 'has the expected login error upon validation' do
        expect(invalid_user_login_regexp_errors.keys).to include(:login)
        expect(invalid_user_login_regexp_errors[:login]).to include(regexp_validation_message)
      end
    end
  end

  describe '.assigned_logins' do
    it 'returns all the logins of the existing Users' do
      expect(described_class.assigned_logins).to eq(described_class.all.pluck(:login))
    end
  end

  describe '.expected_login_chars' do
    let(:login_possible_chars) { %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z] }
    it 'returns all the characters that can be used in a User login' do
      expect(described_class.expected_login_chars).to eq(login_possible_chars)
    end
  end

  describe '.possible_logins' do
    let(:number_of_possible_combinations) { described_class.expected_login_chars.length**3 }
    it 'returns all the possible logins by combinations of all expected_login_chars (including permutations)' do
      expect(described_class.possible_logins.length).to eq(number_of_possible_combinations)
    end
  end
end
