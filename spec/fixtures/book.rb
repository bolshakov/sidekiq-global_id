require 'sqlite3'
require 'temping'

GlobalID.app = 'test'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:',
)

Temping.create :book do
  include GlobalID::Identification
end
