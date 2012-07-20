# -*- encoding: utf-8 -*-
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

  get :index  do
    @gender,@equipment,@type = parse_request_params(params)
    @title = get_title(@gender,@equipment,@type)
    @lifters = find_by_lifter_list(@gender,@equipment,@type)
    render 'lifters/index'
  end  

  get :show, :with => :id do
    @id = params[:id]
    @gender,@equipment,@type = parse_request_params(params)
    @title = get_title(@gender,@equipment,@type)
    @lifter = Lifter.find(@id)
    @template_name = get_template_name(@type) + ".slim"
    @records = find_by_gender_equipment_type(@id,@equipment,@type) 
    render 'lifters/show'
  end

  get :csv, :with => :id do
    @id = params[:id]
    @gender,@equipment,@type = parse_request_params(params)
    records = find_by_gender_equipment_type(@id,@equipment,@type).all
    return record_to_csv(@type,records)
  end

  post :data do
  end

  get :data do
  end

end
