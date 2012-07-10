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

  get :index do    @title = "lifters list:"
    @lifters = Lifter.all
    render 'lifters/index'
  end
   
  def find_by_lifter_id(lifter_id)
    records = Record.joins(:championship)
    return records.where(:lifter_id => lifter_id).order('championships.date')
  end

  def find_by_equipment_powerlifing(lifter_id)
    records = find_by_lifter_id(lifter_id)
    records.where(:equipment => 1)
    return records.all
  end

  get :show, :with => :id do
    @id = params[:id]
    @equipment = params[:equipment] ? params[:equipment] : 1
    @type = params[:type] ? params[:type] : 1
    @lifter = Lifter.find(@id)
    @records = find_by_equipment_type(@id,@equipment,@type)
    render 'lifters/show'
  end

  get :csv, :with => :id do
    @id = params[:id]
    @equipment = params[:equipment] ? params[:equipment] : 1
    @type = params[:type] ? params[:type] : 1
    records = find_by_equipment_type(@id,@equipment,@type)
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
    return @text
  end

  post :data do
  end

  get :data do
  end

end
