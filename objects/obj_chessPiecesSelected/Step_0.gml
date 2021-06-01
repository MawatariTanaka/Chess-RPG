// Change piece's position
global.board[initX, initY] = 0
// Follow mouse
if (mouse_check_button(mb_left) and 0 <= mouse_x and mouse_x < 1704 and 0 <= mouse_y and mouse_y < 1704) {
	x = mouse_x - global.squareWidth / 2
	y = mouse_y - global.squareWidth / 2
} else {
	x = initX * global.squareWidth
	y = initY * global.squareWidth
}
// Move piece
if (mouse_check_button_released(mb_left)) {
	if (instance_position(mouse_x, mouse_y, obj_highlight) or instance_position(mouse_x, mouse_y, obj_selected)) {
		if (instance_position(mouse_x, mouse_y, obj_highlight)) {
			x = floor(mouse_x / global.squareWidth) * global.squareWidth
			y = floor(mouse_y / global.squareWidth) * global.squareWidth
			if (instance_position(x + 1, y + 1, obj_chessPieces)) {
				instance_destroy(instance_nearest(x, y, obj_chessPieces))
			} else if (instance_nearest(x, y, obj_highlight).type == "en_passant") {
				instance_destroy(instance_nearest(x, y + global.squareWidth * sign(pieceId), obj_chessPieces))
			}
			with (obj_chessPieces) {
				move_number = ceil(move_number)
			}
			move_number = ceil(move_number) + 0.5
			obj_controller.xStart = initX
			obj_controller.yStart = initY
			obj_controller.xEnd = floor(x / global.squareWidth)
			obj_controller.yEnd = floor(y / global.squareWidth)
		} else if (instance_position(mouse_x, mouse_y, obj_selected)) {
			x = initX * global.squareWidth
			y = initY * global.squareWidth
			click_number += 1
		}
		if (instance_position(x, y, obj_highlight) or click_number > 1) {
			released = instance_create_layer(x, y, "Pieces", obj_chessPieces)
			released.sprite_index = sprite_index
			released.image_index = image_index
			released.move_number = move_number
			released.pieceId = pieceId
			if (x != initX * global.squareWidth or y != initY * global.squareWidth){
				obj_controller.turn = obj_controller.turn * (-1)	
			}
			global.board[round(x / global.squareWidth), round(y / global.squareWidth)] = pieceId
			instance_destroy()
		}
	} else {
		released = instance_create_layer(initX * global.squareWidth, initY * global.squareWidth, "Pieces", obj_chessPieces)
		released.sprite_index = sprite_index
		released.image_index = image_index
		released.move_number = move_number
		released.pieceId = pieceId
		global.board[initX, initY] = pieceId
		instance_destroy()
	}
	with(obj_chessPieces) {
		range_count = 0
		move_range = []
		capture_range = []
		move_and_capture_range = []
	}
}