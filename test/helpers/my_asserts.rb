module Minitest::Assertions   
  def assert_valid(item) 
    assert item.valid?, "This post is not valid (Title: \"#{item.title}\"; Article: \"#{item.article[0..15]}...\")";
  end  
end