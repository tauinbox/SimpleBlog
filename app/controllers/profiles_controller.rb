class ProfilesController < ApplicationController

  def show
    @profile = Profile.where(user_id: current_user.id)
    # @profile = UserProfile.user
  end

  def edit
    @profile = Profile.where(user_id: current_user.id)
  end

  def update
    @profile = Profile.where(user_id: current_user.id)
    # if @profile.update(profile_params)
    #   redirect_to action: 'show'
    # else
    #   render action: 'edit'
    # end
    redirect_to action: 'show'
  end

  private

  def profile_params
    params.require(:profile).permit(:image_id, :description)
  end

end
