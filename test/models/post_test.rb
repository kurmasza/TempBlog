require 'test_helper'

require 'helpers/my_asserts'

class PostTest < ActiveSupport::TestCase
  
  def setup
    author = Author.create(fname: 'Bob', lname: 'Smith', email: 'bob@smith.com')
    @post = Post.create(title: 'A title', article: 'This is the actual text of our article.  It can be rather long.', likes: 0, status: 1, author: author)
  end
  
  test "post has author" do
    assert_equal @post.author.fname, 'Bob'
  end
     
  test "post must be valid" do
    @post.title = ""
    assert @post.valid?, "@post.vaild? came back false."
  end
  
  test "title must be present" do 
			@post.title = ""
			assert_not @post.valid?
		end
	
		test "title must not be too short" do 
			@post.title = "aa"
			assert_not @post.valid?
		end
	
		test "title must not be too long" do
			@post.title = "a" * 81
			assert_not @post.valid?
		end
	
		test "article must be present" do
			@post.article = ""
			assert_not @post.valid?
		end
	
		test "article must not be too short" do
			@post.article = "aa"
			assert_not @post.valid?
		end
	
		test "article must not be too long" do
			@post.article = "a" * 601
			assert_not @post.valid?
		end
	
		test "likes must be postive" do
			@post.likes = -1
			assert_not @post.valid?
		end
	
		test "status must be valid" do
			invalid_statuses = [-10, -1, 2, 10]
			invalid_statuses.each do |is|
				begin
					@post.status = is
					assert false, "#{is} should be invalid"
				rescue
					assert true
				end
			end
		end
		
		test "status must be published or unpublished" do
		    valid_statuses = [:published, :unpublished]
		    valid_statuses.each do |is|
		      begin
		          @post.status = is
		          assert true
		      rescue
		          assert false, "#{is} should be invalid"
		      end
		    end
  		end   
end
