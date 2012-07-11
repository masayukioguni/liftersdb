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

  get :index do    
    @title = "lifters list:"
    @lifters = Lifter.all
    render 'lifters/index'
  end

  get "/men" do    
    @title = "lifters list"
    @lifters = find_by_gender(1).all
    p @lifters
    render 'lifters/index'
  end  

  get "/women" do    
    @title = "lifters list"
    @lifters = find_by_gender(0).all
    render 'lifters/index'
  end 

  get :show, :with => :id do
    @id = params[:id]
    @gender,@equipment,@type = parse_request_params(params)
    @lifter = Lifter.find(@id)
    @records = find_by_gender_equipment_type(@id,@gender,@equipment,@type) 
    render 'lifters/show'
  end

  get :csv, :with => :id do
    @id = params[:id]
    @gender,@equipment,@type = parse_request_params(params)
    
    records = find_by_gender_equipment_type(@id,@gender,@equipment,@type)
    records = records.all
    text = "date,weight,squat,bencpress,deadlift,total\n";
    records.each{|record|
      text += record.championship.date.to_s
      text += ","
      text += record.weight.to_s
      text += ","
      text += record.squat.to_s
      text += ","
      text += record.benchpress.to_s
      text += ","
      text += record.deadlift.to_s
      text += ","
      text += record.total.to_s
      text += "\n"
    }
    @text = text
    p @text
    return @text
  end

  post :data do
  end

  get :data do
  end

end
