require "spec_helper"

describe LectureGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/lecture_groups").should route_to("lecture_groups#index")
    end

    it "routes to #new" do
      get("/lecture_groups/new").should route_to("lecture_groups#new")
    end

    it "routes to #show" do
      get("/lecture_groups/1").should route_to("lecture_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lecture_groups/1/edit").should route_to("lecture_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lecture_groups").should route_to("lecture_groups#create")
    end

    it "routes to #update" do
      put("/lecture_groups/1").should route_to("lecture_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lecture_groups/1").should route_to("lecture_groups#destroy", :id => "1")
    end

  end
end
