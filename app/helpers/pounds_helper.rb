module PoundsHelper
	def pounds(amount)
		number_to_currency(amount, unit: "&pound;", negative_format: "(%u%n)")
	end
end
