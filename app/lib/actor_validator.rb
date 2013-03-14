class ActorValidator < ActiveModel::Validator
	def validate(record)
		if !validate_infos(record)
			record.errors[:infos] = "Not all infos given."
		end
	end

	private
	def validate_infos(record)
		valid=true
		record.actor_type.information_type.each do |info_type|
			info = record.informations.first{|info| info.information_type == info_type}
			valid = valid && ( !info.nil? && !info.value.empty? )
			puts info_type.key.to_s+"====================>"+valid.to_s+" "+info.to_s
		end

		valid
	end
end