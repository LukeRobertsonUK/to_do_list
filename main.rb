require 'pry'
require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'

get '/' do
  erb :home
end

get '/list/?:title?' do
  db = PG.connect(dbname: 'to_do_app_database', host: 'localhost')
  begin
    if params[:title]
      sql = "select * from to_do where title like '%#{params[:title]}%'"
    else
      sql = "select * from to_do"
    end
    @results = db.exec(sql)
  ensure
    db.close
  end

  erb :list
end

get '/show/:id' do
db = PG.connect(dbname: 'to_do_app_database', host: 'localhost')
  begin
    sql = "select * from to_do where id = '#{params[:id]}'"
    @result = db.exec(sql).first
  ensure
    db.close
  end
  erb :show
end

get '/show/:id/delete' do
  begin
    db = PG.connect(dbname: 'to_do_app_database', host: 'localhost')
    sql = "DELETE FROM to_do WHERE id = '#{params[:id]}'"
    db.exec(sql)
  ensure
    db.close
  end
  erb :delete
end


post '/new' do
    @title = params[:title].to_s
    @due_date = params[:due_date].to_s
    @status = params[:status].to_s
    @details = params[:details].to_s
    @owner = params[:owner].to_s
    begin
      db = PG.connect(dbname: 'to_do_app_database', host: 'localhost')
      sql = "insert into to_do (title, due_date, status, details, owner) values ('#{@title}', '#{@due_date}', '#{@status}', '#{@details}', '#{@owner}')"
      db.exec(sql)
    ensure
      db.close
    end
   redirect to '/'
end

get '/new' do
  erb :new
end

get '/show/:id/update' do
  begin
    db = PG.connect(dbname: 'to_do_app_database', host: 'localhost')
    sql = "select * from to_do where id= '#{params[:id]}'"
    @result = db.exec(sql).first

    erb :update
  ensure
    db.close
  end
end

post '/show/:id/update' do
    @title = params[:title].to_s
    @due_date = params[:due_date].to_s
    @status = params[:status].to_s
    @details = params[:details].to_s
    @owner = params[:owner].to_s
    @id = params[:id]

  begin
    db = PG.connect(dbname: 'to_do_app_database', host: 'localhost')
    sql = "UPDATE to_do SET title='#{@title}', due_date='#{@due_date}', status='#{@status}', details='#{@details}', owner='#{@owner}' WHERE id='#{@id}'"

    db.exec(sql)

  ensure
    db.close
  end
    redirect to '/'
end





