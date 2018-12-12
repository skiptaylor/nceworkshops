get '/admin/?' do
  authenticate
  @workshops = Workshop.all
  erb :'admin/index'
end

get '/admin/new/?' do
  authenticate
  @workshop = Workshop.new
  erb :'admin/workshop'
end

post '/admin/new/?' do
  authenticate
  workshop = Workshop.create(
    :start_date  => Chronic.parse("#{params[:start_date_year]}-#{params[:start_date_month]}-#{params[:start_date_day]}"),
    :end_date    => Chronic.parse("#{params[:end_date_year]}-#{params[:end_date_month]}-#{params[:end_date_day]}"),
    :venue       => params[:venue],
    :description => params[:description],
    :program     => params[:program],
    :location    => params[:location],
    :address1    => params[:address1],
    :address2    => params[:address2],
    :city        => params[:city],
    :state       => params[:state],
    :zip         => params[:zip],
    :time        => params[:time],
    :price1      => params[:price1],
    :price2      => params[:price2],
    :auth_code   => params[:auth_code]
  )
  
  params[:special] ? workshop.update(:special => true) : workshop.update(:special => false)
  
  session[:flash] = 'Your workshop has been created.'
  redirect '/admin'
end

get '/admin/:id/edit/?' do
  authenticate
  @workshop = Workshop.get(params[:id])
  erb :'admin/workshop'
end

post '/admin/:id/edit/?' do
  authenticate
  workshop = Workshop.get(params[:id])
  workshop.update(
    :start_date  => Chronic.parse("#{params[:start_date_year]}-#{params[:start_date_month]}-#{params[:start_date_day]}"),
    :end_date    => Chronic.parse("#{params[:end_date_year]}-#{params[:end_date_month]}-#{params[:end_date_day]}"),
    :venue       => params[:venue],
    :description => params[:description],
    :program     => params[:program],
    :location    => params[:location],
    :address1    => params[:address1],
    :address2    => params[:address2],
    :city        => params[:city],
    :state       => params[:state],
    :zip         => params[:zip],
    :time        => params[:time],
    :price1      => params[:price1],
    :price2      => params[:price2],
    :auth_code   => params[:auth_code]
  )
  
  params[:special] ? workshop.update(:special => true) : workshop.update(:special => false) 
  
  session[:flash] = 'Your workshop has been updated.'
  redirect '/admin'
end

get '/admin/:id/delete' do
  authenticate
  workshop = Workshop.get(params[:id])
  workshop.destroy
  session[:flash] = 'Your workshop has been removed.'
  redirect '/admin'
end

get '/admin/expired?' do
  authenticate
  @workshops = Workshop.all
  erb :'admin/expired'
end

get '/admin/:id/view?' do
  authenticate
  @workshop = Workshop.get(params[:id])
  @reservation = Reservation.get(params[:id])
  erb :'admin/view'
end
