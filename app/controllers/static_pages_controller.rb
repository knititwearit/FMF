class StaticPagesController < ApplicationController
  
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
        if params[:search]
             search_param = CGI::escapeHTML(params[:search])   
             redirect_to ("/users?search=#{search_param}&commit=Search") 
           return
         end
    end
  end
  
  def help
         if params[:search]
             search_param = CGI::escapeHTML(params[:search])   
             redirect_to ("/users?search=#{search_param}&commit=Search") 
           return
         end
  end

  def about
  end

  def contact
  end
  
end
