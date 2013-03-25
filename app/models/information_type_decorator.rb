class InformationTypeDecorator
  include Mongoid::Document

  field :required, type: Boolean
  field :searchable, type: Boolean
  field :index, type: Integer

  belongs_to :information_type, class_name: 'InformationType', inverse_of: nil

  def method_missing(method, *args)
    args.empty? ? information_type.send(method) : information_type.send(method, args)
  end

end

