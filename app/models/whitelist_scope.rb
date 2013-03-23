#Extends Scope - represents a Whitelist: Every account_type in the list is allowed to view.
class WhitelistScope < Scope

	#If viewer is in list (literally or as ":Self") he is allowed to view the element which this Scope is attributed to.
	def visible? (viewer, viewed)
		visible = false
		list = self.list
		if viewer.nil?
			return list.include? (:unauthorized)
		end
		list.each do |allowed_viewer|
			currently_visible = false
			if allowed_viewer == :Self
				currently_visible = (viewer.id == viewed.id) #current_visibility means visibility to current "allowed_viewer"
			else
				currently_visible = (viewer.user_type == allowed_viewer)
			end
			visible = (visible or currently_visible)
			if visible
				break
			end
		end
		return visible
	end

	def to_s
		'Whitelist Scope'
	end
end

