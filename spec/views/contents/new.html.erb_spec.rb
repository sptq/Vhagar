require 'spec_helper'

describe "contents/new" do
  before(:each) do
    assign(:content, stub_model(Content,
      :title => "MyString",
      :body => "MyText",
      :image_url => "MyString",
      :place => "MyString"
    ).as_new_record)
  end

  it "renders new content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contents_path, "post" do
      assert_select "input#content_title[name=?]", "content[title]"
      assert_select "textarea#content_body[name=?]", "content[body]"
      assert_select "input#content_image_url[name=?]", "content[image_url]"
      assert_select "input#content_place[name=?]", "content[place]"
    end
  end
end
