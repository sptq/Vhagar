require 'spec_helper'

describe "contents/index" do
  before(:each) do
    assign(:contents, [
      stub_model(Content,
        :title => "Title",
        :body => "MyText",
        :image_url => "Image Url",
        :place => "Place"
      ),
      stub_model(Content,
        :title => "Title",
        :body => "MyText",
        :image_url => "Image Url",
        :place => "Place"
      )
    ])
  end

  it "renders a list of contents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => "Place".to_s, :count => 2
  end
end
