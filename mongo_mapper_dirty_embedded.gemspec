# encoding: UTF-8
require File.expand_path('../lib/mongo_mapper/plugins/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'mongo_mapper_dirty_embedded'
  s.homepage = 'http://github.com/tomasc/mongo_mapper_dirty_embedded'
  s.summary = "Dirty tracking of Embedded Document"
  s.require_path = 'lib'
  s.authors = ['Tomas Celizna']
  s.email = ['tomas.celizna@gmail.com']
  s.version = MongoMapper::Plugins::DirtyEmbedded::Version
  s.platform = Gem::Platform::RUBY
  s.files = Dir.glob("{lib,test}/**/*") + %w[README.rdoc]

  s.add_dependency 'mongo_mapper'

  s.add_development_dependency 'rake'
end
