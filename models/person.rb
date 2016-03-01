# person.rb
# encoding: utf-8

class Person
  include Mongoid::Document
  field :first_name
  field :middle_name
  field :last_name
  store_in collection: "data", database: 'people'
end