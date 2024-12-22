package main

import "vendor:raylib"

main :: proc() {
    screenWidth :: 800
    screenHeight :: 450

    raylib.InitWindow(screenWidth, screenHeight, "raylib [text] example - font loading")

    raylib.SetTargetFPS(60)

    for !raylib.WindowShouldClose() {
        raylib.BeginDrawing()
        raylib.ClearBackground(raylib.RAYWHITE)
        raylib.EndDrawing()
    }

    raylib.CloseWindow()
}
