class ProfilesController < ApplicationController

  def show
    @profile = Profile.where(user_id: params[:user_id]).first

    unless @profile
      redirect_to home_index_path
    end
  end

  def edit
    @profile = Profile.where(user_id: current_user.id).first
    @image = @profile.image
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
