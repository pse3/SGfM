class InformationsNotEmptyValidator < ActiveModel::EachValidator

	def validate_each( record, attribute, value )
		record.actor_type.information_type.each do |info_type|
			i = value.find_index {|info| info.information_type == info_type}
			unless !i.nil? && !value[i].value.empty?
				record.errors[attribute] = Hash.new
				record.errors[attribute].push(info_type.key,info_type.key.to_s + " is empty.")
			end
		end
  end

end