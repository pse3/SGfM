class WhitelistScope < Scope

	def visible? (viewer, viewed)
		list = self.list
		if viewer.nil?
			return list.include? (:unauthorized)
		end
		visible = false
		list.each do |allowed_viewer|
			if allowed_viewer == :self
				currently_visible = (viewer == viewed) #current_visibility means visibility to current "allowed_viewer"
			else
				currently_visible = (viewer.user_type == allowed_viewer)
			end
			visible = visible or currently_visible

			if visible
				break
			end
		end
		return visible
	end
end

