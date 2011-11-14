require "spec_helper"

describe "Comment" do
  before(:each) do
    @article = Factory(:article)
    @user = User.find_by_id(@article.user_id)
    @attr = {
      :text => "Cheaper than the competition",
      :title => "Review",
      :user_id => @article.user_id,
    }
  end

  it "should create a comment with valid attributes" do
    success = Comment.new(@attr)
    success.should be_valid
  end

  it "should not create a comment if text is empty" do
    emptytext = Comment.new(@attr.merge(:text => ""))
    emptytext.should_not be_valid
  end

  it "should not create a comment if title is empty" do
    emptytitle = Comment.new(@attr.merge(:title => ""))
    emptytitle.should_not be_valid
  end

  it "should require a user id" do
    noid = Comment.new(@attr.merge(:user_id => ""))
    noid.should_not be_valid
  end

  describe "User association" do
    before(:each) do
      @attr.merge(:user_id => "")
      @comment = @user.comments.create(@attr)      
    end

    it "should have a user attribute" do
      @comment.should respond_to(:user)
    end

    it "should have the right associated user" do
      @comment.user_id.should == @user.id
    end
  end

  describe "Article association" do
    before(:each) do
      @attr.merge(:article_id => "")
      @comment = @article.comments.create(@attr)
    end

    it "should have an article attribute" do
      @comment.should respond_to(:article)
    end

    it "should have the right associated article" do
      @comment.article_id.should == @article.id
    end
  end

end
