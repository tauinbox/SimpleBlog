class ProfilesController < ApplicationController

  def show
    @profile = Profile.where(user_id: current_user.id).first
  end

  def edit
    @profile = Profile.where(user_id: current_user.id).first
    @image = @profile.image

    unless @image
      @profile.image = Image.new
      @image = @profile.image
    end

  end

  def update
    @profile = Profile.where(user_id: current_user.id).first
    if @profile.update(profile_params)
      redirect_to action: 'show'
    else
      render action: 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:description)
  end

end
