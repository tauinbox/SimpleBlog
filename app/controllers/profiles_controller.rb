class ProfilesController < ApplicationController

  def show
    @profile = Profile.where(user_id: current_user.id)
    # @profile = UserProfile.user
  end

  def edit
    #@profile = Profile.where(user_id: current_user.id)
    #if current_user.id != @profile.user_id
      # flash.now[:error] = I18n.t('flashes.cant_edit')
      # @articles = Article.all
      # @users = User.all
      # render action: 'index'
    #end
  end

  def update
    # @profile = Profile.where(user_id: current_user.id)
    # if @uprofile.update(profile_params)
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
