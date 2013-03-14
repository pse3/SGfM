class ActorValidator < ActiveModel::Validator
	def validate(record)
		validate_infos record
	end

	private
	def validate_infos record
		#record.errors[:base] = "This record is invalid"
	end
end