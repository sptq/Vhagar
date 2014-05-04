require 'spec_helper'

describe "lecture_groups/show" do
  before(:each) do
    @lecture_group = assign(:lecture_group, stub_model(LectureGroup,
      :title => "Title",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
