require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @new_post = Post.new(title: "All about articles", article: "a an the -- These are the articles in English",
                        status: 1, likes: 17)
  end

  test "#index renders index view" do
    get posts_url
    assert_response :success
    assert_template :index
  end

  test "#index fetches all posts" do
    get posts_url
    assert_equal 2, assigns[:posts].count
  end

  test "#show should show post" do
    get post_url(@post)
    assert_response :success
    assert_template :show
  end

  test "#show should load post" do
    get post_url(@post)
    assert_equal @post.id, assigns[:post].id
  end

  test "#new should get new" do
    get new_post_url
    assert_response :success
    assert_template :new
  end

  test "#new should set empty post" do
    get new_post_url
    assert_not_nil assigns[:post]
    assert_nil assigns[:post].id
  end

  test "#edit should edit post" do
    get edit_post_url(@post)
    assert_response :success
    assert_template :edit
  end

  test "#edit should load post" do
    get edit_post_url(@post)
    assert_equal @post.id, assigns[:post].id
  end


  test "#create should create post" do

    # Make sure a new record appears in the DB
    assert_difference('Post.count') do
      post posts_url, params: { post: { article: @new_post.article, likes: @new_post.likes, status: @new_post.status,
                                        title:  @new_post.title, author_id: authors(:faulkner).id} }
    end

    # Make sure that record contains with we think it should.
    actual_post = Post.last
    assert_equal 'All about articles', actual_post.title
    assert_equal 'William', actual_post.author.fname

  end

  test "create should redirect to created post if successful" do
    post posts_url, params: { post: { article: @new_post.article, likes: @new_post.likes, status: @new_post.status,
                                      title:  @new_post.title, author_id: authors(:faulkner).id} }
    assert_redirected_to post_url(Post.last)
  end

  test "create should redirect to new if unsuccessful" do
    post posts_url, params: { post: { article: 'ts', likes: @new_post.likes, status: @new_post.status,
                                      title:  @new_post.title, author_id: authors(:faulkner).id} }
    assert_template :new
  end

  test "create should set error if unsuccessful" do
    post posts_url, params: { post: { article: 'ts', likes: @new_post.likes, status: @new_post.status,
                                      title:  @new_post.title, author_id: authors(:faulkner).id} }
    assert_template :new

    assert assigns[:post].errors.any?
  end


  test "should update post" do
    patch post_url(@post), params: { post: { article: @post.article, likes: @post.likes, status: @post.status, title:
      @post.title, author_id: @post.author.id } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
