def ar2init(x,y,s = nil)
	Array.new(x).map{Array.new(y, s)}
end

class Cell
	require "./cell_rules"
	attr_reader :x, :y
	attr_accessor :state

	@@rule = Rules.new(birth:[4,6,7,8], stable:[3,4,6,7,8])
	@@ww = Window.width - 120
	@@wh = Window.height
	@@size = 9
	@@num_x = ((@@ww-1)/(@@size+1).to_i)
	@@num_y = ((@@wh-1)/(@@size+1).to_i)
	@@image = Image.new(@@ww,@@wh,[0,0,0])
	@@generation = 0

	@@live = Image.new(@@size,@@size,[20,20,20]).circle(@@size/2,@@size/2,@@size/2,[0,255,0])
	@@dead = Image.new(@@size,@@size,[20,20,20])

	def initialize(x, y, state = false)
		@x = x
		@y = y
		@state = state ? @@live : @@dead
	end


	def set
		self.state = @@live
	end

	def self.draw(cells)
		cells.each do |c|
			c.each do |cell|
				Window.draw(cell.x, cell.y, cell.state)
			end
		end
	end

=begin
	def self.draw(cells)
		cells.each do |c|
			c.each do |cell|
				if cell.state == @@live
					@@image[cell.x, cell.y] = [0,200,0]
				else
					@@image[cell.x, cell.y] = [0,0,0]
				end
			end
		end
		Window.draw(0,0,@@image)
	end
=end
	def self.state_update(cells)
		next_cell_state = ar2init(@@num_x, @@num_y)
		adjoin_num = get_adjoin_cells_nun(cells)
		@@num_x.times do |x|
			@@num_y.times do |y|
				if @@rule.birth?(adjoin_num[x][y]) && cells[x][y].state == @@dead
					next_cell_state[x][y] = @@live
				elsif @@rule.stable?(adjoin_num[x][y]) && cells[x][y].state == @@live
					next_cell_state[x][y] = @@live
				else
					next_cell_state[x][y] = @@dead
				end
			end
		end

		@@num_x.times do |x|
			@@num_y.times do |y|
				cells[x][y].state = next_cell_state[x][y]
			end
		end
		@@generation += 1
	end

	def self.get_adjoin_cells_nun(cells)
		cells_num = ar2init(@@num_x, @@num_y, 0)
		a_x = [1, 1,  1,  0, -1, -1, -1, 0]
		a_y = [1, 0, -1, -1, -1,  0,  1, 1]
		@@num_x.times do |x|
			@@num_y.times do |y|

				if cells[x][y].state == @@live
					8.times do |i|
						tx = (x + a_x[i]) % @@num_x
						ty = (y + a_y[i]) % @@num_y
						cells_num[tx][ty] += 1
					end
				end
			end
		end

		return cells_num
	end

	def self.test(cells)
		p get_adjoin_cells_nun(cells)
	end

	def self.get_input(cells)

	end
	
	def self.rule_update
	
	  case @@generation
	  when 200
	    @@rule = Rules.new(birth:[1,2,4], stable:[2,3,4,5,6,7])
	    	  
	  when 300
	    @@rule = Rules.new(birth:[5,8], stable:[2,4,5,8])
	  
	  when 400
	    @@rule = Rules.new(birth:[1,2,4], stable:[2,3,4,5,6,7])
	  
	  when 500
	    @@rule = Rules.new(birth:[8], stable:[1,2,3,4,5,7,8])
	  
	  when 600
	    @@rule = Rules.new(birth:[2,3], stable:[1,2,3,4,5,6])
	  
	  when 700 
	    @@rule = Rules.new(birth:[], stable:[2,3])
	  
	  when 800
	    @@rule = Rules.new(birth:[3], stable:[3])
	  
	  when 900
	    @@rule = Rules.new(birth:[1,2,4], stable:[2,3,4,5,6,7])
	  
	  when 1000 
	    @@rule = Rules.new(birth:[], stable:[2,3])
	  
	  when 1100
	    @@rule = Rules.new(birth:[3], stable:[2,3])
	  
	  when 1200
	    @@rule = Rules.new(birth:[1,3,5,6], stable:[1,3,5,6,7,8])
	  
	  when 1300
	    @@rule = Rules.new(birth:[8], stable:[1,8])
	    
	  when 1400
	    @@rule = Rules.new(birth:[2], stable:[2,4,6,8])
	    
	  when 1500
	    @@rule = Rules.new(birth:[3,6,7,8], stable:[3,4,6,7,8])
	  
	  when 1800
	    @@rule = Rules.new(birth:[6,7,8], stable:[3,4,6,7,8])
	    
	  when 1900
	    @@rule = Rules.new(birth:[2], stable:[2,3,4])
	    
	  when 2100
	    @@rule = Rules.new(birth:[2], stable:[2,3])
	  
	  when 2300
	    @@rule = Rules.new(birth:[3,6,7,8], stable:[3,4,6,7,8])
	    
	  when 2500
	    @@rule = Rules.new(birth:[3], stable:[2,3])
	  
	  when 2800
	    @@generation = 0
	    
	  end
	  
	end

	def self.size
		@@size
	end

	def self.num_x
		@@num_x
	end

	def self.num_y
		@@num_y
	end

	def self.dead
		@@dead
	end

	def self.live
		@@live
	end

	def self.size=(n)
		@@size=n
	end
	
	def self.generation
	  @@generation
	end
end
