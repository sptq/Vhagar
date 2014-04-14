require 'spec_helper'

describe "contents/edit" do
  before(:each) do
    @content = assign(:content, stub_model(Content,
      :title => "MyString",
      :body => "MyText",
      :image_url => "MyString",
      :place => "MyString"
    ))
  end

  it "renders the edit content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_path(@content), "post" do
      assert_select "input#content_title[name=?]", "content[title]"
      assert_select "textarea#content_body[name=?]", "content[body]"
      assert_select "input#content_image_url[name=?]", "content[image_url]"
      assert_select "input#content_place[name=?]", "content[place]"
    end
  end
end
