package raywrap

import rl "vendor:raylib"

Button :: struct {
    font: rl.Font,
    text: cstring,
    pos: rl.Vector2,
    fontSize: f32,
    spacing: f32,
    fg_color: rl.Color,
    padding: f32,
    bg_color: rl.Color,
}

DrawTextExCentered :: proc(font: rl.Font, text: cstring, position: [2]f32, fontSize: f32, spacing: f32, tint: rl.Color) {
    msg_length := rl.MeasureTextEx(font, text, fontSize, spacing)
    x := position[0] - msg_length[0] / 2
    y := position[1] - msg_length[1] / 2
    centered_position := rl.Vector2{x, y}
    rl.DrawTextEx(font, text, centered_position, fontSize, spacing, tint)
}

GetButtonX :: proc(btn: Button) -> f32 {
    msg_length := rl.MeasureTextEx(btn.font, btn.text, btn.fontSize, btn.spacing)
    return btn.pos[0] - ((msg_length[0] + btn.padding) / 2)
}

GetButtonY :: proc(btn: Button) -> f32 {
    msg_length := rl.MeasureTextEx(btn.font, btn.text, btn.fontSize, btn.spacing)
    return btn.pos[1] - ((msg_length[1] + btn.padding) / 2)
}

GetButtonWidth :: proc (btn: Button) -> f32 {
    msg_length := rl.MeasureTextEx(btn.font, btn.text, btn.fontSize, btn.spacing)
    return msg_length[0] + btn.padding
}

GetButtonHeight :: proc (btn: Button) -> f32 {
    msg_length := rl.MeasureTextEx(btn.font, btn.text, btn.fontSize, btn.spacing)
    return msg_length[1] + btn.padding
}

DrawButtonExCentered :: proc(btn: Button) {
    btn_x := GetButtonX(btn)
    btn_y := GetButtonY(btn)
    btn_width := GetButtonWidth(btn)
    btn_height := GetButtonHeight(btn)
    rl.DrawRectangle(cast(i32) btn_x,
		     cast(i32) btn_y,
		     cast(i32) btn_width,
		     cast(i32) btn_height,
		     btn.bg_color)

    thick := btn.padding / 4

    rl.DrawLineEx(rl.Vector2{btn_x - thick, btn_y - thick/2},
		  rl.Vector2{btn_x + btn_width - 1 + thick, btn_y - thick/2},
		  thick,
		  btn.fg_color)

    rl.DrawLineEx(rl.Vector2{btn_x + btn_width - 1 + thick/2, btn_y - thick/2},
		  rl.Vector2{btn_x + btn_width - 1 + thick/2, btn_y + btn_height + thick},
		  thick,
		  btn.fg_color)

    rl.DrawLineEx(rl.Vector2{btn_x - thick, btn_y + btn_height + thick/2},
		  rl.Vector2{btn_x + btn_width - 1 + thick/2, btn_y + btn_height + thick/2},
		  thick,
		  btn.fg_color)

    rl.DrawLineEx(rl.Vector2{btn_x - thick/2, btn_y - thick/2},
		  rl.Vector2{btn_x - thick/2, btn_y + btn_height + thick/2},
		  thick,
		  btn.fg_color)

    DrawTextExCentered(btn.font, btn.text, btn.pos, btn.fontSize, btn.spacing, btn.fg_color)
}

ButtonIsClicked :: proc(btn: Button, mouse_button: rl.MouseButton) -> bool {
    if !rl.IsMouseButtonPressed(mouse_button) {
	return false
    }

    mouse_pos := rl.GetMousePosition()
    x := mouse_pos[0]
    y := mouse_pos[1]
    btn_x := GetButtonX(btn)
    btn_y := GetButtonY(btn)
    btn_width := GetButtonWidth(btn)
    btn_height := GetButtonHeight(btn)

    if btn_x <= x && x <= (btn_x + btn_width) && btn_y <= y && y <= (btn_y + btn_height) {
	return true
    }

    return false
}
