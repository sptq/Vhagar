require 'spec_helper'

describe "contents/show" do
  before(:each) do
    @content = assign(:content, stub_model(Content,
      :title => "Title",
      :body => "MyText",
      :image_url => "Image Url",
      :place => "Place"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Image Url/)
    rendered.should match(/Place/)
  end
end
