class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update, :voteup, :votedown]

  def show
    @profile = Profile.where(user_id: params[:user_id]).first

    unless @profile
      redirect_to home_index_path
    end
  end

  def edit
    @profile = Profile.where(user_id: current_user.id).first
    unless @profile.image
      @profile.image = Image.new
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

  def voteup
    @profile = Profile.where(user_id: params[:user_id]).first
    # flash[:notice] = @article.votes.where(user_id: current_user.id).first.inspect
    unless @profile.user == current_user
      unless vote == @profile.votes.where(user_id: current_user.id).first
        vote = @profile.votes.new
        vote.user = current_user
      end
      if vote.value == 1
        result = false
      else
        vote.value += 1
        vote.save
        result = true
      end
    end

    respond_to do |format|
      format.json { render json: {vote: result} }
      format.html { redirect_to action: 'show' }      
    end
  end

  def votedown
    @profile = Profile.where(user_id: params[:user_id]).first
    unless @profile.user == current_user
      unless vote == @profile.votes.where(user_id: current_user.id).first
        vote = @profile.votes.new
        vote.user = current_user
      end
      if vote.value == -1
        result = false
      else
        vote.value -= 1
        vote.save
        result = true
      end
    end
    
    respond_to do |format|
      format.json { render json: {vote: result} }
      format.html { redirect_to action: 'show' }      
    end
  end

  def votemap
    @profile = Profile.where(user_id: params[:user_id]).first
    @votes = @profile.votes
  end

  private

  def profile_params
    params.require(:profile).permit(:gender, :birthdate, :description, image_attributes: [:attachment])
  end

end
