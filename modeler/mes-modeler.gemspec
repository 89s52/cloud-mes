version = File.read(File.expand_path('../../MES_VERSION', __FILE__)).strip

Gem::Specification.new do |s|
  s.name        = 'mes-modeler'
  s.version     = version
  s.authors     = ['Eric Guo']
  s.email       = ['eric@cloud-mes.com']
  s.homepage    = 'http://www.cloud-mes.com/'
  s.summary     = 'Modeling require object in MES system'
  s.description = 'Modeling require object in MES system'
  s.license     = 'BSD-3'

  s.files = Dir['{app,config,db,lib}/**/*', 'Rakefile', 'LICENSE.MD']

  s.add_dependency 'bootstrap-sass',  '~> 3.3.5'
  s.add_dependency 'jquery-rails',    '~> 4.0.5'

  s.add_development_dependency 'sqlite3'
end
