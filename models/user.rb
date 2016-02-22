# user.rb
# encoding: utf-8

class User
  include  MongoId::Document
  field  :name, type: String
  field  :email, type: String
end
