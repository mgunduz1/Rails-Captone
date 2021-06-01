require 'rails_helper'

RSpec.describe "groups/index", type: :view do
  before(:each) do
    assign(:groups, [
      Group.create!(
        name: "Name",
        avatar: "Avatar"
      ),
      Group.create!(
        name: "Name",
        avatar: "Avatar"
      )
    ])
  end

  it "renders a list of groups" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Avatar".to_s, count: 2
  end
end
