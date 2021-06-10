require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:all) do
    @user = User.create(email: 'try@test', name: 'new', encrypted_password: '123456')
  end

  it 'tests lack of association' do
    @transaction = Transaction.create(name: 'test',
                                      amount: 30)
    expect(@transaction.valid?).to eq false
  end

  it 'validations for name' do
    @transaction2 = Transaction.create(name: '',
                                       amount: 30,
                                       user_id: @user.id)
    expect(@transaction2.valid?).to eq false
  end

  it 'amount character limit validation' do
    @transaction3 = Transaction.create(name: 'test2',
                                       amount: 143_243_214,
                                       user_id: @user.id)
    expect(@transaction3.valid?).to eq false
  end

  context 'association tests' do
    it 'should belongs to user' do
      association = Transaction.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
    it 'should belongs to group' do
      association = Transaction.reflect_on_association(:group)
      expect(association.macro).to eq :belongs_to
    end
  end
end
