class FiguresController < ApplicationController
  

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do #refactor this!!!!
    @figure = Figure.create(name: params[:figure][:name])
    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |title_id|
        FigureTitle.create(figure_id: @figure.id, title_id: title_id)
      end
    end
    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |landmark_id|
        Landmark.find(landmark_id.to_i).update(figure_id: @figure.id)
      end
    end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year]) 
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])
    if !params[:figure][:title_ids].empty?
      params[:figure][:title_ids].each do |title_id|
        FigureTitle.create(figure_id: @figure.id, title_id: title_id)
      end
    end
    if !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].each do |landmark_id|
        Landmark.find(landmark_id.to_i).update(figure_id: @figure.id)
      end
    end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year]) 
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
