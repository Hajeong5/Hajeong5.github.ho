class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :search]
  skip_before_action :verify_authenticity_token, only: [:search]

  # GET /posts
  # GET /posts.json
  
  
  def mypage
     
     @posts = Post.all
     
     @mypage = Post.find_by(user_id: current_user.id)
     
    # @pages = Post.order(:id).page(params[:page]).per(5)
  end
  
  
  def index
    
    # @pages = Post.order(:id).page(params[:page])
    @pages = Post.order(:id).page(params[:page]).per(5)
    
    @posts = Post.all
    
    # @last = Post.last.id
   
    @posts.each do |p|
        # random =rand(Post.count)
        random = (1..Post.last.id).to_a.sample
         
        if p.id == random
          @random = Post.find(random)
        end
        
        if @random.nil?
          @random = Post.last
        end
    end
    
   
   
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end
  

  # GET /posts/new
  def new
    @post = Post.new

  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '성공적인 메모였습니다.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
    ####################
  def search
    @search = Post.find_by(title: params[:search])
    
    # if @search.nil?
    #   redirect_to('/posts', data: { confirm: "로그아웃 하시겠습니까?" })
    # end
  
  end
  
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      
      d = @post.updated_at
      t = Time.now
      
      u_day = d.day
      u_month = d.month
      u_year = d.year
      u_hour = d.hour
      u_minute = d.min
      u_second = d.sec
      
      t_day = t.day
      t_month = t.month
      t_year = t.year
      t_hour = t.hour
      t_minute = t.min
      t_second = t.sec
      
      if u_year < t_year && t_month - u_month >= 0
        @between = t_year - u_year
        @ago = 1
      else
        if u_month < t_month && t_day - u_day >= 0
          @between = t_month - u_month
          @ago = 2
        else
          if t_day > u_day && t_hour - u_hour >= 0
            @between = t_day - u_day
            @ago =3
          else
            if t_hour > u_hour && t_minute - u_minute >= 0
              @between = t_hour - u_hour
              @ago = 4
            else
              if t_minute > u_minute && t_second - u_second >= 0
                @between = t_minute - u_minute
                @ago =5
              else
                if t_second > u_second
                  @between = t_day - u_day
                  @ago =6
                else
                  @ago = 0;
                end
              end
            end
          end
        end
      end
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text, :lock)
    end
    

end
