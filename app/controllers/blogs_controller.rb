class BlogsController < ApplicationController
    before_action :set_blog, only:[:show,:edit,:update,:destroy]
    before_action :logged_in_user, only: [:new,:index,:edit,:show,:destroy]

    def index
        @blogs = Blog.all
    end

    def new
      if params[:back]
          @blog = Blog.new(blog_params)
      else
          @blog = Blog.new
      end

    end

    def create
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id #現在ログインしているuserのidをblog.user_idに代入し、blogのuser_idカラムに挿入
        #user_idはすでに、テーブルが関連づけられているだけでは、使用できない。アソシエーションをかけ、t.referencesを使用して、外部キーの
        #カラムをblogsに作成する。また、その際,外部キーを使用する際、blogsは belongs_to :user　になる

        if @blog.save
          # メール送信機能
          ContactMailer.contact_mail(@blog).deliver
          redirect_to blogs_path, notice: 'ブログが作成されました'
        else
          render 'new'
        end
    end

    def show
      @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    end

    def edit
    end

    def update
      if @blog.update(blog_params)
        redirect_to blogs_path, notice: '編集しました'
      else
        render 'edit'
      end
    end

    def destroy
        @blog.destroy
        redirect_to blogs_path, notice: 'ブログを削除しました'
    end

    def confirm
      @blog = Blog.new(blog_params)
      #ここにも記入
      @blog.user_id = current_user.id
      render :new if @blog.invalid?  # render 'new'でもいいはず
    end


    private
    def blog_params
        params.require(:blog).permit(:title, :content)
    end
    def set_blog
       @blog = Blog.find(params[:id])
    end
    def logged_in_user
      unless current_user #ログイン中のuserでない場合は、ログイン画面へリダイレクト
        render new_session_path
      end
    end
end
