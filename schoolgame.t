%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Programmer  : Brandon Tu
% Teacher     : Mr. Chow
% Course      : ICS3U1
%
% Program Name: Lawn Mower Simulator
% Description : The objective of the game is to mow all the grass on the lawn by moving over it. 
%               By mowing grass, you obtain money which you can use to buy speed upgrades! (And the special fireball upgrade)
%               As you progress through each level, the enemy also gets faster and faster, making the upgrades nesscesary to win. 
%               Have fun!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% HEADS UP DISPLAY (HUD) %%%%%%%%%%
import GUI %allows for button use 
var window1 : int %opens window
window1 := Window.Open ("graphics:500;500,nocursor")



%%%%%%%%%% VARIABLES & CONSTANTS %%%%%%%%%%
var guyleft := Pic.FileNew ("guyleft.jpg")
var guyright := Pic.FileNew ("guyright.jpg")
var enemyguyleft := Pic.FileNew ("badguyleft.jpg")
var enemyguyright := Pic.FileNew ("badguyright.jpg")

var blueguyleft := Pic.FileNew ("blueguyleft.jpg")
var greenguyleft := Pic.FileNew ("greenguyleft.jpg")
var pinkguyleft := Pic.FileNew ("pinkguyleft.jpg")
var goldguyleft := Pic.FileNew ("goldguyleft.jpg")

var instructions := Pic.FileNew ("instructions.jpg")

var grass := Pic.FileNew ("grass.jpg")
var leftright : string := "right"

var centreX, centreY, %x and y coordinates of your guy
    gridX, gridY, %x and y coordinates of your guy on the array "arr"
    enemyX, enemyY, %x and y coordinates of the enemy
    enemygridX, enemygridY, %x and y coordinates of your enemy on the array "arr"
    speed, enemyspeed, score, money, level : int
centreX := 0
centreY := 0
gridX := 1
gridY := 1
enemyX := 450
enemyY := 450
enemygridX := 10
enemygridY := 10
speed := 30 %Your speed, lower is faster
enemyspeed := 10 %Enemy's movement intervals

var input : string (1) %determines keyboard presses

var gameover : boolean := false %tells if the game is over
var arr : array 1 .. 10 of array 1 .. 10 of string %the array that determines wether the points on the grid are grass or empty
var skin : string := "default"
score := 0
money := 0
level := 1


var mousex, mousey, button : int


var font, smallfont : int
font := Font.New ("Comicsans:30:bold,italic")
smallfont := Font.New ("Comicsans:10:bold,italic")

%%%%%%%%%% FUNCTIONS & PROCEDURES %%%%%%%%%%
procedure updategrid %changes array value of the current location of your guy from g (grass) to e (empty)
    if arr (gridX) (gridY) = "g" then
	arr (gridX) (gridY) := "e"
	score += 1
	money += 5
    end if
end updategrid


procedure move (letter : string) %moves your character in the direction of your key press, does not move if you reach the edge: l=left, r=right, u=up, d=down
    if letter = "l" then
	leftright := "left"
	if centreX > 49 then
	    gridX -= 1
	    updategrid
	    for i : 1 .. 5
		Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
		centreX -= 10
		Pic.Draw (guyleft, centreX, centreY, picMerge)
		delay (speed)
	    end for
	else
	    centreX := 0
	    Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
	    Pic.Draw (guyleft, centreX, centreY, picMerge)
	end if
    elsif letter = "r" then
	leftright := "right"
	if centreX < 449 then
	    gridX += 1
	    updategrid
	    for i : 1 .. 5
		Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
		centreX += 10
		Pic.Draw (guyright, centreX, centreY, picMerge)
		delay (speed)
	    end for
	else
	    centreX := 450
	    Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
	    Pic.Draw (guyright, centreX, centreY, picMerge)
	end if
    elsif letter = "u" and leftright = "left" then
	if centreY < 449 then
	    gridY += 1
	    updategrid
	    for i : 1 .. 5
		Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
		centreY += 10
		Pic.Draw (guyleft, centreX, centreY, picMerge)
		delay (speed)
	    end for
	else
	    centreY := 450
	    Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
	    Pic.Draw (guyleft, centreX, centreY, picMerge)
	end if
    elsif letter = "u" and leftright = "right" then
	if centreY < 450 then
	    gridY += 1
	    updategrid
	    for i : 1 .. 5
		Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
		centreY += 10
		Pic.Draw (guyright, centreX, centreY, picMerge)
		delay (speed)
	    end for
	else
	    centreY := 450
	    Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
	    Pic.Draw (guyright, centreX, centreY, picMerge)
	end if
    elsif letter = "d" and leftright = "left" then
	if centreY > 49 then
	    gridY -= 1
	    updategrid
	    for i : 1 .. 5
		Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
		centreY -= 10
		Pic.Draw (guyleft, centreX, centreY, picMerge)
		delay (speed)
	    end for
	else
	    Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
	    centreY := 0
	    Pic.Draw (guyleft, centreX, centreY, picMerge)
	end if
    elsif letter = "d" and leftright = "right" then
	if centreY > 49 then
	    gridY -= 1
	    updategrid
	    for i : 1 .. 5
		Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
		centreY -= 10
		Pic.Draw (guyright, centreX, centreY, picMerge)
		delay (speed)
	    end for
	else
	    Draw.FillBox (centreX, centreY, centreX + 50, centreY + 50, 137)
	    centreY := 0
	    Pic.Draw (guyright, centreX, centreY, picMerge)
	end if
    else

    end if
end move

procedure fireball (x, y : int, d : string)
    var c : int := 0
    if d = "right" then
	c := x + 50
	loop
	    Draw.FillBox (c, y, c + 50, y + 50, 137)
	    c := c + 1
	    Draw.Oval (c + 10, y + 30, 10, 10, 44)
	    Draw.Oval (c + 10, y + 30, 9, 9, 43)
	    Draw.Oval (c + 10, y + 30, 8, 8, 43)
	    Draw.Oval (c + 10, y + 30, 7, 7, 42)
	    Draw.Oval (c + 10, y + 30, 6, 6, 42)
	    Draw.Oval (c + 10, y + 30, 5, 5, 41)
	    Draw.Oval (c + 10, y + 30, 4, 4, 41)
	    Draw.Oval (c + 10, y + 30, 3, 3, 40)
	    Draw.Oval (c + 10, y + 30, 2, 2, 40)
	    Draw.Oval (c + 10, y + 30, 1, 1, 40)
	    delay (2)
	    %draw (x,y,1)
	    exit when c >= 510
	    for i : gridX + 1 .. 10
		arr (i) (gridY) := "e"
	    end for
	end loop
	%Draw.FillOval(c,y+30,10,10,0)
    elsif d = "left" then
	c := x - 50
	loop
	    Draw.FillBox (c, y, c + 50, y + 50, 137)
	    c := c - 1
	    Draw.Oval (c, y + 30, 10, 10, 44)
	    Draw.Oval (c, y + 30, 9, 9, 43)
	    Draw.Oval (c, y + 30, 8, 8, 43)
	    Draw.Oval (c, y + 30, 7, 7, 42)
	    Draw.Oval (c, y + 30, 6, 6, 42)
	    Draw.Oval (c, y + 30, 5, 5, 41)
	    Draw.Oval (c, y + 30, 4, 4, 41)
	    Draw.Oval (c, y + 30, 3, 3, 40)
	    Draw.Oval (c, y + 30, 2, 2, 40)
	    Draw.Oval (c, y + 30, 1, 1, 40)
	    delay (2)
	    %draw (x,y,1)
	    exit when c <= -20
	    for decreasing i : gridX - 1 .. 1
		arr (i) (gridY) := "e"
	    end for
	end loop
	%Draw.FillOval(c,y+30,50,50,0)
    end if
end fireball


procedure enemymove %moves your enemy in the x axis towards your character, then in the y axis towards your character
    if gameover = false then
	if enemygridX > gridX and arr (enemygridX) (enemygridY) = "e" then
	    enemygridX -= 1
	    for i : 1 .. 5
		Draw.FillBox (enemyX, enemyY, enemyX + 50, enemyY + 50, 137)
		enemyX -= enemyspeed
		Pic.Draw (enemyguyleft, enemyX, enemyY, picMerge)
		delay (200 - level * 20)
	    end for
	elsif enemygridX < gridX and arr (enemygridX) (enemygridY) = "e" then
	    enemygridX += 1
	    for i : 1 .. 5
		Draw.FillBox (enemyX, enemyY, enemyX + 50, enemyY + 50, 137)
		enemyX += enemyspeed
		Pic.Draw (enemyguyright, enemyX, enemyY, picMerge)
		delay (200 - level * 20)
	    end for
	elsif enemygridX > gridX and arr (enemygridX) (enemygridY) = "g" then
	    enemygridX -= 1
	    for i : 1 .. 5
		Pic.Draw (grass, enemyX, enemyY, picMerge)
		enemyX -= enemyspeed
		Pic.Draw (enemyguyleft, enemyX, enemyY, picMerge)
		delay (200 - level * 20)
	    end for
	elsif enemygridX < gridX and arr (enemygridX) (enemygridY) = "g" then
	    enemygridX += 1
	    for i : 1 .. 5
		Pic.Draw (grass, enemyX, enemyY, picMerge)
		enemyX += enemyspeed
		Pic.Draw (enemyguyright, enemyX, enemyY, picMerge)
		delay (200 - level * 20)
	    end for
	end if
	if enemygridY > gridY and arr (enemygridX) (enemygridY) = "e" then
	    enemygridY -= 1
	    for i : 1 .. 5
		Draw.FillBox (enemyX, enemyY, enemyX + 50, enemyY + 50, 137)
		enemyY -= enemyspeed
		Pic.Draw (enemyguyleft, enemyX, enemyY, picMerge)
		delay (200 - level * 20)
	    end for
	elsif enemygridY < gridY and arr (enemygridX) (enemygridY) = "e" then
	    enemygridY += 1
	    for i : 1 .. 5
		Draw.FillBox (enemyX, enemyY, enemyX + 50, enemyY + 50, 137)
		enemyY += enemyspeed
		Pic.Draw (enemyguyright, enemyX, enemyY, picMerge)
		delay (200 - level * 20)
	    end for
	elsif enemygridY > gridY and arr (enemygridX) (enemygridY) = "g" then
	    enemygridY -= 1
	    for i : 1 .. 5
		Pic.Draw (grass, enemyX, enemyY, picMerge)
		enemyY -= enemyspeed
		Pic.Draw (enemyguyleft, enemyX, enemyY, picMerge)
		delay (200 - level * 20)
	    end for
	elsif enemygridY < gridY and arr (enemygridX) (enemygridY) = "g" then
	    enemygridY += 1
	    for i : 1 .. 5
		Pic.Draw (grass, enemyX, enemyY, picMerge)
		enemyY += enemyspeed
		Pic.Draw (enemyguyright, enemyX, enemyY, picMerge)
		delay (200 - level * 20)
	    end for
	end if
    else
    end if
end enemymove

function istheregrassleft (arr : array 1 .. 10 of array 1 .. 10 of string) : boolean %checks if there are any blocks left with grass in the array (used in the win function)
    for i : 1 .. upper (arr)
	for j : 1 .. upper (arr)
	    if arr (i) (j) = "g"
		    then
		result true
	    end if
	end for
    end for
    result false
end istheregrassleft

function win (arr : array 1 .. 10 of array 1 .. 10 of string) : string %checks if you have either eaten all the grass or if the enemy has touched your character
    if centreX + 50 >= enemyX and centreY + 50 >= enemyY and centreX - 50 <= enemyX and centreY - 50 <= enemyY then
	gameover := true
	result "lose"
    elsif istheregrassleft (arr) = false then
	gameover := true
	result "win"
    elsif istheregrassleft (arr) = true then
	result " "
    end if
end win

procedure resetgame %resets all variables to their original amounts and redraws both characters and grass in their original positions
    if win (arr) = "win" then
	level += 1
    end if
    gameover := false
    centreX := 0
    centreY := 0
    gridX := 1
    gridY := 1
    enemyX := 450
    enemyY := 450
    enemygridX := 10
    enemygridY := 10
    score := 0

    delay (100)
    cls
    Draw.FillBox (0, 0, maxx, maxy, 80)
    Font.Draw ("Level " + intstr (level), 200, 300, font, 56)
    delay (1000)
    enemyspeed := 10
    for i : 1 .. 10
	for j : 1 .. 10
	    Pic.Draw (grass, i * 50 - 50, j * 50 - 50, picMerge)
	end for
    end for
    Pic.Draw (guyright, centreX, centreY, picMerge)
    Pic.Draw (guyleft, enemyX, enemyY, picMerge)
    for i : 1 .. 10
	for j : 1 .. 10
	    arr (j) (i) := "g"
	end for
    end for
    GUI.Quit
end resetgame

procedure changeblue %changes your character image colour, subtracts from your money, boosts speed
    if money >= 100 and skin not= "blue" then
	Font.Draw ("Your money:  $" + intstr (money), 60, 370, smallfont, 80)
	money -= 100
	skin := "blue"
	speed := 20
	Font.Draw ("Your money: $" + intstr (money), 60, 370, smallfont, 56)
	guyright := Pic.FileNew ("blueguyright.jpg")
	guyleft := Pic.FileNew ("blueguyleft.jpg")
	Font.Draw ("Purchased", 10, 100, smallfont, 56)
    elsif money < 100 then
	Font.Draw ("Insufficient Funds", 10, 100, smallfont, 56)
    elsif skin = "blue" then
	Font.Draw ("You already have that skin equipped", 10, 100, smallfont, 56)
    end if
end changeblue

procedure changegreen %changes your character image colour, subtracts from your money, boosts speed
    if money >= 300 and skin not= "green" then
	Font.Draw ("Your money:  $" + intstr (money), 60, 370, smallfont, 80)
	money -= 300
	skin := "green"
	speed := 10
	Font.Draw ("Your money: $" + intstr (money), 60, 370, smallfont, 56)
	guyright := Pic.FileNew ("greenguyright.jpg")
	guyleft := Pic.FileNew ("greenguyleft.jpg")
	Font.Draw ("Purchased", 10, 100, smallfont, 56)
    elsif money < 300 then
	Font.Draw ("Insufficient Funds", 10, 100, smallfont, 56)
    elsif skin = "green" then
	Font.Draw ("You already have that skin equipped", 10, 100, smallfont, 56)
    end if
end changegreen

procedure changepink %changes your character image colour, subtracts from your money, boosts speed
    if money >= 500 and skin not= "pink" then
	Font.Draw ("Your money:  $" + intstr (money), 60, 370, smallfont, 80)
	money -= 500
	skin := "pink"
	speed := 5
	Font.Draw ("Your money: $" + intstr (money), 60, 370, smallfont, 56)
	guyright := Pic.FileNew ("pinkguyright.jpg")
	guyleft := Pic.FileNew ("pinkguyleft.jpg")
	Font.Draw ("Purchased", 10, 100, smallfont, 56)
    elsif money < 500 then
	Font.Draw ("Insufficient Funds", 10, 100, smallfont, 56)
    elsif skin = "pink" then
	Font.Draw ("You already have that skin equipped", 10, 100, smallfont, 56)
    end if
end changepink

procedure changegold %changes your character image colour, subtracts from your money, boosts speed, adds fireballs
    if money >= 1000 and skin not= "gold" then
	Font.Draw ("Your money:  $" + intstr (money), 60, 370, smallfont, 80)
	money -= 1000
	skin := "gold"
	speed := 1
	Font.Draw ("Your money: $" + intstr (money), 60, 370, smallfont, 56)
	guyright := Pic.FileNew ("goldguyright.jpg")
	guyleft := Pic.FileNew ("goldguyleft.jpg")
	Font.Draw ("Purchased", 10, 100, smallfont, 56)
    elsif money < 1000 then
	Font.Draw ("Insufficient Funds", 10, 100, smallfont, 56)
    elsif skin = "gold" then
	Font.Draw ("You already have that skin equipped", 10, 100, smallfont, 56)
    end if
end changegold


procedure start %exits loops when buttons are pressed
    GUI.Quit
end start

procedure menu %draws instructions and button to go back to shop
    Draw.FillBox (0, 0, maxx, maxy, 80)
    Pic.Draw (instructions, 110, 100, picMerge)
    var startgame : int := GUI.CreateButton (230, 30, 0, "Play", start)
    Input.Flush
    Font.Draw ("Watch out! The enemy will sometimes create fake blocks of grass to trick you!", 10, 70, smallfont, 56)
    Text.Locate (1, 1)
    loop
	Mouse.Where (mousex, mousey, button)
	exit when button = 1 and GUI.ProcessEvent and mousex >= 230 and mousey >= 30 and mousex <= 280 and mousey <= 50
    end loop
end menu

procedure shop %draws shop screen and shop buttons, draws a menu button to show instructions, draws button to replay
    cls
    Draw.FillBox (0, 0, maxx, maxy, 80)
    Font.Draw ("Your score: " + intstr (score), 60, 400, smallfont, 56)
    Font.Draw ("Your money:  $" + intstr (money), 60, 370, smallfont, 56)
    Font.Draw ("+Speed              ++Speed             +++Speed           +Fireballs!", 40, 230, smallfont, 56)
    Font.Draw ("(Space to shoot)", 335, 210, smallfont, 56)
    Pic.Draw (blueguyleft, 45, 150, picMerge)
    var guyblue : int := GUI.CreateButton (25, 125, 0, "Blue: $100", changeblue)
    Pic.Draw (greenguyleft, 145, 150, picMerge)
    var guygreen : int := GUI.CreateButton (125, 125, 0, "Green: $300", changegreen)
    Pic.Draw (pinkguyleft, 255, 150, picMerge)
    var guypink : int := GUI.CreateButton (235, 125, 0, "Pink: $500", changepink)
    Pic.Draw (goldguyleft, 360, 150, picMerge)
    var guygold : int := GUI.CreateButton (340, 125, 0, "Gold: $1000", changegold)


    var replay : int := GUI.CreateButton (25, 25, 0, "Replay?", resetgame)
    var menu : int := GUI.CreateButton (325, 25, 0, "Instructions?", menu)
    loop
	exit when GUI.ProcessEvent
    end loop
end shop

procedure winlosetext %Draws "you win" or "you lose" when you win or lose in flashing text
    if gameover = true then
	if win (arr) = "win" then
	    Font.Draw ("You won!", 150, 450, font, 56)
	    delay (100)
	    Font.Draw ("You won!", 150, 450, font, 58)
	    delay (100)
	elsif win (arr) = "lose" then
	    Font.Draw ("You lost!", 150, 450, font, 56)
	    delay (100)
	    Font.Draw ("You lost!", 150, 450, font, 58)
	    delay (100)
	end if
    elsif gameover = false then
    end if
end winlosetext



procedure starttext %Draws flashing text during start screen
    loop
	Font.Draw ("Lawn Mower Simulator", 40, 450, font, 56)
	delay (29)
	Font.Draw ("Lawn Mower Simulator", 40, 450, font, 59)
	exit when GUI.ProcessEvent
    end loop
end starttext

procedure playmusic
    loop
	Music.PlayFile ("hopup.mp3")
    end loop
end playmusic

%%%%%%%%%% MAIN CODE %%%%%%%%%%
process game (word : string) %Forks enemy movement, win/lose text, and starting text so that they are always running independently of the main code
    if word = "enemy" then
	loop
	    enemymove
	end loop

    elsif word = "text" then
	loop
	    winlosetext
	end loop

    elsif word = "starttext" then
	starttext

    elsif word = "music" then
	playmusic
    end if


end game


loop
    Draw.FillBox (0, 0, maxx, maxy, 80) %Draws purple background of the start screen
    Pic.Draw (instructions, 110, 100, picMerge)
    Font.Draw ("Watch out! The enemy will sometimes create fake blocks of grass to trick you!", 10, 70, smallfont, 56)
    var startgame : int := GUI.CreateButton (230, 30, 0, "Play", start)
    fork game ("starttext")

    loop
	exit when GUI.ProcessEvent
    end loop


    gameover := false
    centreX := 0
    centreY := 0
    gridX := 1
    gridY := 1
    enemyX := 450
    enemyY := 450
    enemygridX := 10
    enemygridY := 10
    score := 0
    delay (100)
    cls
    Draw.FillBox (0, 0, maxx, maxy, 80)
    Font.Draw ("Level " + intstr (level), 200, 300, font, 56)
    Font.Draw ("The enemy gets faster each level!" , 160, 200, smallfont, 56)
    delay (1000)
    enemyspeed := 10
    for i : 1 .. 10
	for j : 1 .. 10
	    Pic.Draw (grass, i * 50 - 50, j * 50 - 50, picMerge)
	end for
    end for
    Pic.Draw (guyright, centreX, centreY, picMerge)
    Pic.Draw (guyleft, enemyX, enemyY, picMerge)
    for i : 1 .. 10
	for j : 1 .. 10
	    arr (j) (i) := "g"
	end for
    end for


    fork game ("enemy")
    fork game ("text")
    fork game ("music")


    loop

	updategrid
	loop
	    if win (arr) = "win" or win (arr) = "lose" then
		exit
	    end if
	    getch (input) %gets keyboard presses for movement
	    if input = KEY_LEFT_ARROW then
		move ("l")
	    elsif input = KEY_RIGHT_ARROW then
		move ("r")
	    elsif input = KEY_UP_ARROW then
		move ("u")
	    elsif input = KEY_DOWN_ARROW then
		move ("d")
	    elsif input = " " and skin = "gold" then
		fireball (centreX, centreY, leftright)
	    else

	    end if
	    Input.Flush ()
	end loop
	gameover := true
	enemyspeed := 0

	delay (500)
	shop

    end loop

end loop

