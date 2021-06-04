require 'rails_helper'

RSpec.describe 'groups/show', type: :view do
  before(:each) do
    @group = assign(:group, Group.create!(
                              name: 'Name',
                              avatar: 'Avatar'
                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Avatar/)
  end
end
