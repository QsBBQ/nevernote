require 'data_mapper'

#DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite:nevernote.db')

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String
  property :password, BCryptHash

  has n, :notebooks
  has n, :notes, through: :notebooks
end

class Note
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :content, Text

  belongs_to :notebook
  has 1, :user, through: :notebook

  has n, :taggings
  has n, :tags, through: :taggings
end

class Notebook
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  belongs_to :user
  has n, :notes
end

class Tagging
  include DataMapper::Resource
  property :id, Serial

  belongs_to :note
  belongs_to :tag
end

class Tag
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has n, :taggings
  has n, :notes, through: :taggings
end

DataMapper.finalize
DataMapper.auto_migrate!
