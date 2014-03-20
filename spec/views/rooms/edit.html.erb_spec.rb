require 'spec_helper'

describe "rooms/edit" do
  before(:each) do
    @room = assign(:room, stub_model(Room,
      :title => "MyString",
      :description => "MyText",
      :capacity => 1
    ))
  end

  it "renders the edit room form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", room_path(@room), "post" do
      assert_select "input#room_title[name=?]", "room[title]"
      assert_select "textarea#room_description[name=?]", "room[description]"
      assert_select "input#room_capacity[name=?]", "room[capacity]"
    end
  end
end
