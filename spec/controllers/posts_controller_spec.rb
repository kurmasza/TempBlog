require 'rails_helper'

RSpec.describe PostsController do
  describe "#index" do
    it "renders index view" do
      get :index
      expect(response).to render_template("index")
    end

    it "fetches all posts" do
      get :index
      expect(assigns[:posts].count).to eq(2)
    end

  end # #index
end
