class PostsController < ApplicationController  
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path
      flash[:notice] = 'Success. Post has been created.'
    else
      flash.now[:alert] = 'Not posted. Errors in form.'
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.update(post_params)
      redirect_to @post
      flash[:notice] = 'Success. Post has been edited.'
    else
      flash.now[:alert] = 'Not updated. Errors in form.'
      render :edit
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
