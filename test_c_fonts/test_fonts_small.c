/*******************************************************************************************
*
*   raylib [text] example - raylib fonts loading
*
*   NOTE: raylib is distributed with some free to use fonts (even for commercial pourposes!)
*         To view details and credits for those fonts, check raylib license file
*
*   Example originally created with raylib 1.7, last time updated with raylib 3.7
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2024 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#include "raylib.h"

#define MAX_FONTS   8

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
int main(void)
{
    // Initialization
    //--------------------------------------------------------------------------------------
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib [text] example - raylib fonts");

    // NOTE: Textures MUST be loaded after Window initialization (OpenGL context is required)
    // Font font = LoadFont("resources/fonts/alagard.png");
    Vector2 position = {60, 60};

    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

            ClearBackground(RAYWHITE);

            // DrawText("free fonts included with raylib", 250, 20, 20, DARKGRAY);
            // DrawLine(220, 50, 590, 50, DARKGRAY);

            // DrawTextEx(font, "Some font", position, 20.0, 1.0, ORANGE);
            
           // DrawTextEx(fonts[i], messages[i], positions[i], fonts[i].baseSize*2.0f, (float)spacings[i], colors[i]);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------

    // Fonts unloading
    // UnloadFont(font);

    CloseWindow();                 // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}
