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

  get :show, :with => :id do
    @id = params[:id]
    @lifter = Lifter.find(@id)
    lifter = Lifter.where(:gender => @id)
    lifters = lifter.all

    record = Record.joins(:championship)
    record = record.where(:lifter_id => @id).order('championships.date')
    @records = record.all
    p @records
    render 'lifters/show'
  end

  get :csv, :with => :id do
    @id = params[:id]
    record = Record.joins(:championship)
    records = record.where(:lifter_id => @id).order('championships.date')
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

    @text
    p text
  end

  post :data do
  end

  get :data do
  end

end
