# Extends Scope - represents a Blacklist: Every account_type in the list is NOT allowed to view.
class BlacklistScope < Scope

	# If viewer is in list (literally or as ":Self") he is NOT allowed to view the element which this Scope is attributed to.
	def visible? (viewer, viewed)
		visible = true
		list = self.list
		if viewer.nil?
			return !(list.include? (:unauthorized))
		end
		list.each do |allowed_viewer|
			currently_visible = false
			if allowed_viewer == :Self
				currently_visible = !(viewer.id == viewed.id) # current_visibility means visibility to current "allowed_viewer"
			else
				currently_visible = !(viewer.user_type == allowed_viewer)
			end
			visible = (visible and currently_visible)
			break unless visible
		end
		visible
	end

	def to_s
		'Blacklist Scope'
  end

end