Necessary Features:
- A movable ship that will shoot projectiles, which can damage the enemies
- Enemy ships can shoot their own projectiles, and will march from side to side, slowly creeping down the screen everytime they hit the side.
- Gameplay should get harder over stages: enemies moving faster
- If I add custom images for the sprites I might need to include "hit-boxes" that are drawn behind the sprites

Extra Features:
- There should be some powerups:
  - A health pickup(not exactly a powerup, but needed if an integer amount of health will be added)
  - A fire rate increase
  - A score multiplier
  - A temporary shield that last only a few hits(otherwise it'd be too easy, and wears off after enough time
  - A double shot upgrade
- Certains types of enemies could:
  - Give more points and need more hits to kill  than others 
  - Have different types of projectiles(ie: laser beams, explosive missiles with AOE, kamikaze ships, multishot, etc)
  - Potentially be boss variants, which are significantly tankier and stronger, but reward a lot more points
- The player ship might not be limited to only left-right movement, but up-down movment will be limited, for more dodgablitiy

Array:
- 1D arrays:
  - There will be multiple projectiles on the screen at once, for both the player and the enemies, so they will need to be stored so that collision can be detected for all projectiles and so that there is a projectile limit
- 2D arrays:
  - The main enemy hordes will include organized grids of enemies, which need 2D arrays to position them
  - If I potentially add powerups, all the powerups that the player picks up should be recorded so that they can be detected, applying the effect
  - The enemy horde variants will need their own 2D arrays for their unique organization.

Controls:
- Keyboard Commands:
  - Arrow keys or WASD for movement of player ships
  - Spacebar for shooting projectiles
  - Shift for a dash ability(might not be added?)
  - R to reset game
  - P to pause game (not sure how to implement this)
- Mouse Commands:
  - Mousepressed as an alternate control for shooting

Classes:
- class Player{
  - Instance Vars:
    - PVector position;
    - int health;
    - int lives;
  - Methods
    - void display(int size)
    - void shoot()
- }
Not yet finished







