require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'has a valid factory' do
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).to be_invalid
    end

    it 'is invalid without a password' do
      user.password = nil
      expect(user).to be_invalid
    end

    it 'is invalid with a duplicate email' do
      another_user = build(:user, email: user.email)
      expect(another_user).to be_invalid
    end
  end
end
