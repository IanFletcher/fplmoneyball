module FlashHelper
	def flash_display
	  response = ""
	  flash.each do |name, msg|
	    response = response + 
	      content_tag(:div, msg, :id => "flash_#{name}", :class => "alert alert-danger")
	  end
	  response
	end
end