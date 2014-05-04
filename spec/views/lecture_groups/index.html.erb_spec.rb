require 'spec_helper'

describe "lecture_groups/index" do
  before(:each) do
    assign(:lecture_groups, [
      stub_model(LectureGroup,
        :title => "Title",
        :description => "MyText"
      ),
      stub_model(LectureGroup,
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of lecture_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
