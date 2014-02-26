module ApplicationHelper
	def full_title(page_title)
		base_title = "FPLMoneyBall"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
	def link_to_add_fields(name, f, association)
  	new_object = f.object.send(association).klass.new
  	id = new_object.object_id
  	fields = f.fields_for(association, new_object, child_index: id) do |builder|
    	render("shared/" + association.to_s.singularize + "_fields", tp: builder)
  	end
  	link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	end
	def teamid
		Team.find_by(user_id: current_user.id).id
	end
end
