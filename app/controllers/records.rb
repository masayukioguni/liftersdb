Liftersdb.controllers :records do
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
    index = params[:page] != nil ? params[:page] : 1
    @title = "lifters page:" + index.to_s
    #@records = Record.page(params[:page] || 1).per(20)
    @records = Record.all
    @records.each{|record| 
      p record
      #['total'] = record.squat + record.benchpress + record.deadlift
    }
    
    
    render 'records/index'
  end

  get :show do
  end

end
