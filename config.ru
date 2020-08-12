require_relative 'config/enviroment'

map '/auth' do
  run AuthRoutes
end

map '/user' do
  run UserRoutes
end

map '/user_session' do
  run UserSessionRoutes
end