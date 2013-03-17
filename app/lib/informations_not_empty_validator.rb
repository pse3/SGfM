class InformationsNotEmptyValidator < ActiveModel::EachValidator

	def validate_each( record, attribute, value )
		all_errors= Hash.new
		record.actor_type.information_type.each do |info_type|
			i = value.find_index {|info| info.information_type == info_type}
			unless !i.nil? && !value[i].value.empty?
				all_errors[info_type.key] = info_type.key.to_s+" is empty."
			end
		end
		record.errors[attribute].push(all_errors)
  end

end