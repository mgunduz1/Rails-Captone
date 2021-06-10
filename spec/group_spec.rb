require 'rails_helper'

RSpec.describe Group, type: :model do
  before do
    @group = Group.new(name: 'new group', avatar: 'try')
  end

  it 'tries to update the group without a name' do
    expect(@group.update(name: '')).to be false
  end

  it 'check if valid' do
    expect(@group).to be_valid
  end
end
