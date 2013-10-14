class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  require "rqrcode"
require "chunky_png"
  
  def index
    @search = User.search do
      fulltext params[:search]
    end
    @users = @search.results
  end
 
   
  def show
    @user = User.find(params[:id])
   
    # qr_code_img = RQRCode::QRCode.new( 'MATMSG:TO:knititwearit@gmail.com;SUB:Hello;Body:example;;', :size => 8, :level => :h ).to_img
    
    # qr_code_img = RQRCode::QRCode.new( 'MATMSG:TO:knititwearit@gmail.com;SUB:Hello;Body:Join me http://fiveminutefriend-18901.euw1.actionbox.io:3000;;', :size => 12, :level => :h ).to_img
    
    # qr_code_img = RQRCode::QRCode.new( 'http://fiveminutefriend-18901.euw1.actionbox.io:3000/users/16', :size => 12, :level => :h ).to_img
    
    qr_code_img = RQRCode::QRCode.new( 'MECARD:N:Noah Coad;TEL:4258028842;EMAIL:noah@coad.net;ADR:1419 Comanche,Allen,TX,75013,;URL:http://fiveminutefriend-18901.euw1.actionbox.io:3000;', :size => 12, :level => :h ).to_img
    
    @qr = qr_code_img.to_image.resize(150,150).to_data_url 
    
    @microposts = @user.microposts.paginate(page: params[:page])
         if params[:search]
             search_param = CGI::escapeHTML(params[:search])   
             redirect_to ("/users?search=#{search_param}&commit=Search") 
           return
         end
  end
  
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
         if params[:search]
             search_param = CGI::escapeHTML(params[:search])   
             redirect_to ("/users?search=#{search_param}&commit=Search") 
           return
         end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end