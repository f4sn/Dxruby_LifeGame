class Rules
	def initialize(rules = {birth:[3], stable:[2, 3]})
	  #rules = {birth:[4,7,8], stable:[4,5,6,7,8]}
	  #rules = {birth:[1,2,4], stable:[1,2,3,4,5,6,7]}
	  #rules = {birth:[4,6,7,8], stable:[3,4,6,7,8]}
		@rules = rules
	end

	def birth?(cell_num)
		@rules[:birth].include?(cell_num)
	end

	def stable?(cell_num)
		@rules[:stable].include?(cell_num)
	end

end
