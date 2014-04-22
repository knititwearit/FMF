class IdentitiesController < ApplicationController
  def new
    @identity = env['omniauth.identity']
  end
  
  def show
    @identity  = Identity.find(params[:id])
  end
end