# Scoped is a module that implements functionality of Scope.
# If a class includes Scoped, each of its objects has a Scope that
# defines which other objects are allowed to see this object.
module Scoped

  def self.included(base)
    base.extend ClassMethods
    base.belongs_to :scope, class_name: 'Scope', inverse_of: nil
  end

  def set_scope(child)
    child.scope=scope if scope
  end

  def visible?(viewer)
		#TODO - self.actor.owner - quick fix - don't know if this is the most beautiful solution. (Assuming every scoped has a .actor.owner - works for now)
    scope.visible?(viewer, self.actor.owner)
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