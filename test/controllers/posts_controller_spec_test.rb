require 'minitest/spec'
require 'minitest/autorun'

class PostsControllerTest < ActionDispatch::IntegrationTest

  describe "Post Controller" do
    describe "#index" do
      it "renders index view" do
        get posts_url
      end
    end # #index
  end
end