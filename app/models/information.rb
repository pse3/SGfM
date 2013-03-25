module Scoped

  def self.included(base)
    base.extend ClassMethods
    base.belongs_to :scope, class_name: 'Scope', inverse_of: nil
  end

  def set_scope(child)
    child.scope=scope if scope
  end

  module ClassMethods
    def inherit_scope_from(parent)
      method_name = "#{parent}="
      orig_method_name = "orig_#{method_name}"
      alias_method orig_method_name.to_sym, method_name.to_sym
      define_method(method_name) do |param|
        #add some callback
        self.send(orig_method_name, param)
        param.set_scope(self)
      end
    end
  end
end

class Information
  # base class for the actual data

  include Mongoid::Document
  include Scoped

  field :value, :type => String

  field :created_at, :type => DateTime
  field :changed_a, :type => DateTime

  belongs_to :creator, class_name: 'User', inverse_of: nil                              #referenced  / one way relationship                                                                                                                                                                                                                                                 #embedded
  belongs_to :information_type, class_name: 'InformationType', inverse_of: nil          #referenced  / one way relationship
  embedded_in :actor, class_name: 'Actor'                                               #embedded

  inherit_scope_from :information_type

  def initialize
    super
    self.created_at = DateTime.now
  end

  def to_s
    self.value
  end

  def name
    self.information_type.name
  end

  def key
    self.information_type.key
  end
end