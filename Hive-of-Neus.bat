@echo off
title The Hive of Neus
color 1B
if "%1" neq "" ( goto %1)

:Menu
cls
echo You must enter 1, 2, 3, or 4.
echo.
echo 1. New Game
echo 2. Load Game
echo 3. Credits
echo 4. Exit
set /p answer=Type the number of your option and press enter : 
if %answer%==1 goto New_Game
if %answer%==2 goto Load_Game
if %answer%==3 goto Credits
if %answer%==4 goto Exit
else goto Menu

:Exit
cls
echo Thanks for playing!
pause
exit /b

:Credits
cls
echo Credits
echo.
echo Thank you for playing The Hive of Neus!
echo Game created by Benjamin Napier.
pause
goto Menu

:New_Game
cls
echo Are you sure you would like to start a new game?
echo This will erase any previous saved game data.
echo.
echo 1. Yes, start new game
echo 2. No, back to the menu
set /p answer=Type the number of your option and press enter : 
if %answer%==1 goto Start_1
if %answer%==2 goto Menu
else goto New_Game

:Start_1
cls
SET /A player_health = 100
SET /A player_attack = 5
SET /A battles_won = 0
SET /A health_potions = 1
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
(
	echo %player_health%
	echo %player_attack%
    echo %battles_won%
    echo %health_potions%
) > savegame.sav
echo.
echo You find yourself outside of the Hive of Neus, a cavern of dark treachery from which beasts emerge and terrorize the surrounding villages.
echo You have been tasked with getting to the bottom of the cavern and defeating the hive mind which is controlling the beasts.
echo In order to accomplish your task you have been armed with a crudely crafted spear and a health potion.
echo.
pause
goto Load_Game

:Load_Game
cls
(
	set /p player_health=
	set /p player_attack=
    set /p battles_won=
    set /p health_potions =
) < savegame.sav 
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo Continue your adventure.
echo.
pause
if %battles_won% GEQ 5 goto Final_Battle
set /a num=%random% %%2 +1
if %num%==1 goto Event_1
if %num%==2 goto Event_2
else goto Menu

:Event_1
SET /A goblin_health = 50
SET /A goblin_attack = 3
goto Event_1_1
:Event_1_1
set /a attackNum1=%random% %%3 +1
SET /A player_damage=%player_attack%+%attackNum1%
set /a attackNum2=%random% %%3 +1
set /A goblin_damage=%goblin_attack%+%attackNum2%
set /a player_defend=%player_damage% - 2
set /a goblin_defend=%goblin_damage% - 3
SET /A potionNum1=%random% %%3 +1
set /a potion_heal=%potionNum1%+15
cls
echo Health: %player_health%     Attack: %player_attack%
echo Health Potions: %health_potions%
echo.
echo As you enter a dark room of the Hive, one goblin warrior emerges with club raised to fight.
echo Goblin Health: %goblin_health%     Goblin Attack: %goblin_attack%
echo.
echo 1. Attack with spear.
echo 2. Defend with spear.
if %health_potions% GEQ 1 echo 3. Drink health potion.
set /p answer=Type the number of your option and press enter : 
if %answer%==1 (
    SET /A goblin_health -= %player_damage%
    SET /A player_health -= %goblin_damage%
    echo.
    echo You stab the goblin and it strikes back!
    echo The goblin takes %player_damage% damage!
    echo You take %goblin_damage% damage!
    pause
)
if %answer%==2 (
    SET /A goblin_health -= %player_defend%
    SET /A player_health -= %goblin_defend%
    echo.
    echo You hold your spear out and the goblin scrapes it as it rushes to club you.
    echo The goblin takes %player_defend% damage!
    echo You take %goblin_defend% damage!
    pause
)
if %answer%==3 (
    SET /A player_health += %potion_heal%
    set /a player_health -= %goblin_damage%
    SET /A health_potions -= 1
    echo.
    echo You chug a potion from your inventory and gain %potion_heal% health.
    echo The goblin clubs you and you take %goblin_damage% damage!
    pause
)
if %goblin_health% LEQ 0 (
    SET /A battles_won = %battles_won% + 1
    (
	    echo %player_health%
	    echo %player_attack%
        echo %battles_won%
        echo %health_potions%
    ) > savegame.sav
    if %battles_won% GEQ 5 (
        goto Final_Battle
    )
    goto Random_Event_1
)
if %player_health% LEQ 0 (
    goto Credits
)
goto Event_1_1

:Event_2
cls
echo Event_2
pause
goto Menu

:Random_Event_1
cls
echo Random_Event_1
pause
goto Menu

:Final_Battle
cls
echo Final_Battle
pause
goto Victory

:Victory
cls
echo Victory
pause
goto Menu