# term.rb
# encoding: utf-8

class Term
  include Mongoid::Document
  field :term
  field :deffinition
  field :source_def
  field :acronym
  field :secure_class
  field :more_term
  field :samp_val
  field :note
  field :requester
  field :accept_dt
  field :method
  field :status
      store_in collection: "data", database: 'glossary'
end