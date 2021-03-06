class PostsController < ApplicationController

  before_action(:move_to_index, except: [:index, :show])

  def index
    @posts = Post.includes(:user)
              .page(params[:page]).per(3)
              .order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new()
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿を作成しました。"
    else
      flash.now[:alert] = "入力をしてください"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.update(post_params)
      redirect_to posts_path, notice: "投稿を更新しました。"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました。"
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
