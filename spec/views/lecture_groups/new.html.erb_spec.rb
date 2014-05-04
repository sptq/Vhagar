require 'spec_helper'

describe "lecture_groups/new" do
  before(:each) do
    assign(:lecture_group, stub_model(LectureGroup,
      :title => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new lecture_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lecture_groups_path, "post" do
      assert_select "input#lecture_group_title[name=?]", "lecture_group[title]"
      assert_select "textarea#lecture_group_description[name=?]", "lecture_group[description]"
    end
  end
end
