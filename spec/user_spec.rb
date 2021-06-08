require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    it 'validates presence of name' do
      user = User.new(email: 'test@tester').save
      expect(user).to eq(false)
    end

    it 'validates presence of email' do
      user = User.new(name: 'someone').save
      expect(user).to eq(false)
    end
  end
end
