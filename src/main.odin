package main

import rl "vendor:raylib"

State :: enum {
    MainMenu,
    NewDatabase,
}

main :: proc() {
    screenWidth :: 1920 * 2 / 3
    screenHeight :: 1080 * 2 / 3
    rl.InitWindow(screenWidth, screenHeight, "Pokerthor - Poker home game manager and tracker")
    defer rl.CloseWindow()
    rl.SetTargetFPS(60)

    windowState: State = State.MainMenu
    title_text: cstring = "Main Menu"
    font_size := rl.GetFontDefault().baseSize

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.RAYWHITE)

	rl.DrawLineEx(rl.Vector2{0, 0}, rl.Vector2{screenWidth, 0}, 30.0, rl.LIGHTGRAY)
	rl.DrawLineEx(rl.Vector2{screenWidth, 0}, rl.Vector2{screenWidth, screenHeight}, 30.0, rl.LIGHTGRAY)
	rl.DrawLineEx(rl.Vector2{screenWidth, screenHeight}, rl.Vector2{0, screenHeight}, 30.0, rl.LIGHTGRAY)
	rl.DrawLineEx(rl.Vector2{0, screenHeight}, rl.Vector2{0, 0}, 30.0, rl.LIGHTGRAY)

	/* TODO: Use different font */
	switch windowState {
	case State.MainMenu:

	    text_width: f32 = cast(f32) rl.MeasureText(title_text, font_size)
	    text_height: f32 = cast(f32) font_size
	    x: f32 = (screenWidth - text_width) / 2
	    y: f32 = cast(f32) screenHeight * 1 / 8

	    rl.GuiLabel(rl.Rectangle{x, y, text_width, text_height}, title_text)

	    if rl.GuiButton(rl.Rectangle{(screenWidth - 120) / 2, (screenHeight - 30) / 2 - 30, 120, 30}, "New Database") {
		windowState = State.NewDatabase
	    }
	case State.NewDatabase:
	}

        rl.EndDrawing()
    }
}
