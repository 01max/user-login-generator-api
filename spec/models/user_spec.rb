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
end
