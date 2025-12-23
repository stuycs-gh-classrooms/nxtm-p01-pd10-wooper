[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/Mfyqb_T6)
# NeXtCS Project 01
### thinker0: Unmesh Ghosh
---

### Overview
Your mission is create either:
- Life-like cellular automata [life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life), [life-like](https://en.wikipedia.org/wiki/Life-like_cellular_automaton), [demo](https://www.netlogoweb.org/launch#https://www.netlogoweb.org/assets/modelslib/Sample%20Models/Computer%20Science/Cellular%20Automata/Life.nlogo).
- Breakout/Arkanoid [demo 0](https://elgoog.im/breakout/)  [demo 1](https://www.crazygames.com/game/atari-breakout)
- Space Invaders/Galaga

This project will be completed in phases.  
The first phase will be to work on this document. 
* Use markdown formatting.
* For more markdown help
  - [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or
  - [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)


---

## Phase 0: Selection, Analysis & Plan

#### Selected Project: Space Invaders

### Necessary Features
What are the core features that your program should have? These should be things that __must__ be implemented in order to make the program useable/playable, not extra features that could be added to make the program more interesting/fun.

- A movable player ship that can shoot projectiles
- Enemy ships that can be destroyed by projectiles, but also shoot projectiles at you

### Extra Features
What are some features that are not essential to the program, but you would like to see (provided you have time after completing the necessary features. Theses can be customizations that are not part of the core requirements.

- Some powerups, like a shield or an increased fire rate, or maybe a health pickup if I include a healthbar for the player as well

YOUR ANSWERS HERE

### Array Usage
How will you be using arrays in this project?

1D Array:
- Since multiple Projectile class instances will be on the screen at once, there should be an array containing all of them 

2D Array:
- The enemy ships, since they will be organized as a grid on the window


### Controls
How will your program be controlled? List all keyboard commands and mouse interactions.

Keyboard Commands:
- LEFT and RIGHT controls left to right movement of player ship
- SPACE will shoot a Projectile object from the positon of the player ship
- R will restart the game
- P will pause the game

Mouse Control:
- Mouse movement: N/A
- Mouse pressed: N/A


### Classes
What classes will you be creating for this project? Include the instance variables and methods that you believe you will need. You will be required to create at least 2 different classes. If you are going to use classes similar to those we've made for previous assignments, you will have to add new features to them.

Player
- Instance variables:
  - PVector position;
  - int health;
- METHODS
  - void display() {}
  - void shoot() {}

Projectile
- Instance variables:
  - PVector position;
  - int speed;
- METHODS
  - void display() {}
  - void move() {}

Enemy
- Instance variables:
  - PVector position
  - int type;
  - int speed;
  - int health;
- METHODS
  - void display() {}
  - void shoot() {}
  - void move() {}
