require "rails_helper"

RSpec.describe ContactFilesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/contact_files").to route_to("contact_files#index")
    end

    it "routes to #new" do
      expect(get: "/contact_files/new").to route_to("contact_files#new")
    end

    it "routes to #create" do
      expect(post: "/contact_files").to route_to("contact_files#create")
    end

    it "routes to #destroy" do
      expect(delete: "/contact_files/1").to route_to("contact_files#destroy", id: "1")
    end
  end
end
