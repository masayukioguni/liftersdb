Liftersdb.controllers :lifters do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :index do
    #@project_name = get_project_name
    index = params[:page] != nil ? params[:page] : 1
    @title = "lifters page:" + index.to_s
    @lifters = Lifter.page(params[:page] || 1).per(5)
    p @lifters
    render 'lifters/index'

  end

  get :show do
  end

  post :data do
  end

end
