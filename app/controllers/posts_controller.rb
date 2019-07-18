class PostsController < ApplicationController
  
  before_action(:move_to_index, except: [:index, :show])

  def index
    @posts = Post.includes(:user).all().order("created_at DESC")
  end

  def new
    @post = Post.new(post_params)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :article).merge(user_id: current_user.id)
  end

  def move_to_index
    #ログインしていない時indexアクションを強制的に実行する
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
