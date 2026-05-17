# evil-footsteps
a formal lua implementation for procedural phantom footsteps with field-of-view cancellation logic. made by malq.


# evil footsteps behind you.mp4
a lua script for garrys mod that generates auditory phantom footsteps behind the player at randomized intervals. the project focuses on performance efficiency and realistic spatial audio implementation using sound proxies.

### technical breakdown
*   **visibility check**: utilizes a dot product calculation to monitor the player's view cone. if the sound origin enters the field of view, the current sequence is terminated.
*   **surface awareness**: uses `util.TraceLine` to fetch surface properties, ensuring material consistency across map textures.
*   **proxy emission**: sounds are emitted via a temporary `info_target` entity to ensure compatibility with lua-based sound replacers like dsteps or eft footsteps.
*   **patter logic**: volume and distance are procedurally lerped during burst sequences to simulate an approaching entity.

### features
*   **certified safe**: the script is gluten-free and has been tested to ensure it does not cause cancer or spontaneous combustion in most desktop environments.
*   **privacy focused**: the entity is forbidden from reading your browser history or stealing your credit card information.
*   **zero calories**: using this addon will not affect your daily caloric intake or fitness goals.
*   **highly compatible**: hooks into engine sound scripts; works with all major sound mods.

### installation (for developers)
1.  clone the repository into your `garrysmod/addons/` folder.
2.  ensure the folder structure maintains `lua/autorun/...`
3.  restart the game or use `lua_openscript` to verify the logic.

### configuration
parameters are adjustable via the gmod utility menu (`options > utilities > horror > evil footsteps`).
*   activation probability
*   volume range randomization
*   horizontal spread and spawn distance
*   scurry behavior and speed settings

### contribution
this project is open source. feel free to submit a pull request if you find a more optimized way to handle the proxy entity cleanup or if you improve the dot product check.

made by malq.
