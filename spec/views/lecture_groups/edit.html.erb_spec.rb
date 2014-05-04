require 'spec_helper'

describe "lecture_groups/edit" do
  before(:each) do
    @lecture_group = assign(:lecture_group, stub_model(LectureGroup,
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit lecture_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lecture_group_path(@lecture_group), "post" do
      assert_select "input#lecture_group_title[name=?]", "lecture_group[title]"
      assert_select "textarea#lecture_group_description[name=?]", "lecture_group[description]"
    end
  end
end
