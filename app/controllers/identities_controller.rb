class IdentitiesController < ApplicationController
  def show
    @identity = Identity.find(params[:id])
    @name  = @identity.name
    @email = @identity.email
  end
  
  def new
    @identity = env['omniauth.identity']
  end
end