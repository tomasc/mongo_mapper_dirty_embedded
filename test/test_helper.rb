require 'rubygems'
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'mongo_mapper'
require 'mongo_mapper/plugins/dirty_embedded'
require 'test/unit'
require 'shoulda'
require 'ruby-debug'



class ActiveSupport::TestCase
  
  # Drop all collections after each test case.
  def teardown
    MongoMapper.database.collections.each { |coll| coll.remove }
  end

  # Make sure that each test case has a teardown
  # method to clear the db after each test.
  def inherited(base)
    base.define_method teardown do 
      super
    end
  end

end



MongoMapper.connection = Mongo::Connection.new('127.0.0.1', 27017)
MongoMapper.database = "mongo_mapper_dirty_embedded_test"
MongoMapper.database.collections.each { |c| c.drop_indexes }
