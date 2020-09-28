require_relative 'config/enviroment'
use Rack::Runtime
use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter
use Rack::Ougai::LogRequests, Application.logger
run Rack::URLMap.new(
    '/v1/auth' => AuthRoutes,
    '/v1/login' => UserSessionRoutes,
    '/v1/signup' => UserRoutes
)
