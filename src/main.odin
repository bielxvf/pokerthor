package main

import rl "vendor:raylib"
import rw "raywrap"

WindowState :: enum {
    Menu,
    NewDatabase,
    DatabaseOptions,
}

main :: proc() {
    screenWidth :: 1920 * 2 / 3
    screenHeight :: 1080 * 2 / 3

    rl.InitWindow(screenWidth, screenHeight, "Pokerthor - Poker home game manager and tracker")
    defer rl.CloseWindow()

    rl.SetTargetFPS(60)

    font := rl.LoadFontEx("/usr/share/fonts/TTF/DejaVuSans.ttf", 45, nil, 0)
    defer rl.UnloadFont(font)


    state: WindowState = WindowState.Menu

    btn_new_database: rw.Button = {
	font,
	"New database",
	rl.Vector2{screenWidth * 1 / 6, screenHeight * 1 / 4},
	25,
	2,
	rl.BLACK,
	25/3,
	rl.GREEN,
    }

    /* TODO: Scan for .json databases in ~/.config/pokerthor/ */
    /* Database idea: folder named X is the database, contains global.json with the global P&L, and history.json with all sessions */

    for !rl.WindowShouldClose() {

	/* ---- STATE ---- */

	switch state {
	case WindowState.Menu:
	    if rw.ButtonIsClicked(btn_new_database, rl.MouseButton.LEFT) {
		state = WindowState.NewDatabase
		continue
	    }
	case WindowState.NewDatabase:
	case WindowState.DatabaseOptions:
	}


	/* ---- DRAWING  ---- */
        rl.BeginDrawing()

        rl.ClearBackground(rl.RAYWHITE)

	switch state {
	case WindowState.Menu:
	    /* Title */
	    rw.DrawTextExCentered(font,
				  "Pokerthor",
				  rl.Vector2{screenWidth / 2, screenHeight * 1 / 12},
				  50,
				  2,
				  rl.BLACK)

	    /* New database button */
	    rw.DrawButtonExCentered(btn_new_database)

	    /* Subtitle */
	    rw.DrawTextExCentered(font,
				  "Click on a database for options",
				  rl.Vector2{screenWidth / 2, screenHeight * 1 / 6},
				  30,
				  2,
				  rl.GRAY)

	    /* TODO: Show databases, allow rightclick for options */

	case WindowState.NewDatabase:
	    /* TODO */
	case WindowState.DatabaseOptions:
	}

        rl.EndDrawing()
    }
}
