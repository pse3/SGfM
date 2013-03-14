class ActorValidator < ActiveModel::Validator
	def validate(record)
		if !validate_infos(record)
			record.errors[:infos] = "Not all infos given."
		end
	end

	private
	def validate_infos(record)
		valid=true
		for info_type in record.actor_type.information_type do
			info = record.informations.first{|info| info.information_type == info_type}
			valid &= info && !info.value.empty?
		end
		valid
	end
end