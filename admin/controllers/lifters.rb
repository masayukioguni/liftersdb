Admin.controllers :lifters do

  get :index do
    @lifters = Lifter.all
    render 'lifters/index'
  end

  get :new do
    @lifter = Lifter.new
    render 'lifters/new'
  end

  post :create do
    @lifter = Lifter.new(params[:lifter])
    if @lifter.save
      flash[:notice] = 'Lifter was successfully created.'
      redirect url(:lifters, :edit, :id => @lifter.id)
    else
      render 'lifters/new'
    end
  end

  get :edit, :with => :id do
    @lifter = Lifter.find(params[:id])
    render 'lifters/edit'
  end

  put :update, :with => :id do
    @lifter = Lifter.find(params[:id])
    if @lifter.update_attributes(params[:lifter])
      flash[:notice] = 'Lifter was successfully updated.'
      redirect url(:lifters, :edit, :id => @lifter.id)
    else
      render 'lifters/edit'
    end
  end

  delete :destroy, :with => :id do
    lifter = Lifter.find(params[:id])
    if lifter.destroy
      flash[:notice] = 'Lifter was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Lifter!'
    end
    redirect url(:lifters, :index)
  end
end
