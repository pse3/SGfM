class BlacklistScope < Scope
	def visible? (viewer, viewed)
		list = self.list
		visible = true
		list.each do |disallowed_viewer|
			if allowed_viewer == :self
				currently_visible = !(viewer == viewed) #current_visibility means visibility to current "allowed_viewer"
			else
				currently_visible = !(viewer.user_type == allowed_viewer)
			end
			visible = visible and currently_visible

			unless visible
				break
			end
		end
		end
	end
end

