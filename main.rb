require "dxruby"
require "./class_cell"

Window.width = 1900 + 1
Window.height = 1000 + 1


cells = ar2init(Cell.num_x, Cell.num_y)
r = Random.new(1)
Cell.num_x.times do |i|
	Cell.num_y.times do |j|
		x = 1+i*(Cell.size+1)
		y = 1+j*(Cell.size+1)
		cells[i][j] = Cell.new(x, y,[true,false][r.rand(2)])
	end
end

font = Font.new(32)
i = 0
Window.loop do
	Cell.draw(cells)
	Cell.get_input(cells)
	Cell.rule_update
	Cell.state_update(cells)# if i%10 == 0
	#Cell.test(cells) if i == 0
	Window.draw_font(0,0,Cell.generation.to_s,font)
	i += 1
end
