class ImagesController < ApplicationController
 
  def new
    @image = Image.new
  end

  def edit
    @profile = Profile.where(user_id: current_user.id).first
    @image = @profile.image    
  end

  def update
    @profile = Profile.where(user_id: current_user.id).first
    @image = @profile.image
    if @image.update(image_params)
      redirect_to user_profile_path(current_user.id)
    else
      render "edit"
    end
  end

  private
  def image_params
    params.require(:image).permit(:attachment, :description)
  end

end
