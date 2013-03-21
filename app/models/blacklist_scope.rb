class BlacklistScope < Scope

	def visible? (viewer, viewed)
		visible = true
		list = self.list
		if viewer.nil?
			return !(list.include? (:unauthorized))
		end
		list.each do |allowed_viewer|
			currently_visible = false
			if allowed_viewer == :self
				currently_visible = !(viewer.id == viewed.id) #current_visibility means visibility to current "allowed_viewer"
			else
				currently_visible = !(viewer.user_type == allowed_viewer)
			end
			visible = (visible and currently_visible)
			if !visible
				break
			end
		end
		return visible
	end

	def to_s
		'Blacklist Scope'
	end
end