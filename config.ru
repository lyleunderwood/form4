require 'sprockets'

project_root = File.join(File.expand_path(File.dirname(__FILE__)), 'lib')
assets = Sprockets::Environment.new(project_root) do |env|
  env.logger = Logger.new(STDOUT)
end

assets.append_path(File.join(project_root, 'assets'))
assets.append_path(File.join(project_root, 'assets', 'javascripts'))
assets.append_path(File.join(project_root, 'assets', 'stylesheets'))

use Rack::Static, :urls => ['/images'], :root => File.join(project_root, 'public')

app = lambda do |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('lib/public/index.html', File::RDONLY)
  ]
end

map '/assets' do
  run assets
end

map '/' do
  run app
end