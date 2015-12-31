class HostingsController < ApplicationController
  def new
    @hosting ||= Hosting.new(host_id: params[:user_id])
  end

  def create
    @hosting = Hosting.new(hosting_params)
    @hosting.host_id = current_user.id

    if @hosting.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @hosting.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @hosting = Hosting.find(params[:id])

    if @hosting.host_id == current_user.id && @hosting.update(hosting_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @hosting.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @hosting = Hosting.find(params[:id])
  end

  def destroy
    @hosting = Hosting.find(params[:id])

    if @hosting.host_id == current_user.id && @hosting.destroy
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @hosting.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def hosting_params
    params
      .require(:hosting)
      .permit(:zipcode, :max_guests)
  end
end
