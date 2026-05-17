# evil footsteps behind you !! - made by a VERY early lua programmer 

a utility script designed to generate auditory phantom footsteps behind the player at randomized intervals within garry's mod. the project focuses on performance efficiency and realistic spatial audio implementation, ensuring compatibility with common sound replacement mods like dsteps and eft footsteps.

## technical overview

this addon utilizes several core lua functionalities to achieve its effect:

*   **field-of-view cancellation:** a dot product calculation monitors the player's aim vector against the calculated position of the phantom footstep. if the origin enters the player's field of view (simulated by a dot product threshold), the sound sequence is terminated. this provides a responsive "hiding" mechanic.

*   **surface awareness:** a trace line is cast downwards from the potential sound origin to identify the ground material. [code]util.GetSurfacePropName[/code] is used to dynamically select the appropriate sound script (e.g., "[i]concrete.StepLeft[/i]").

*   **sound proxy emission:** to ensure compatibility with lua-based sound replacers (such as dsteps or eft footsteps), a temporary [code]info_target[/code] entity is spawned at the calculated sound position. [code]entity:EmitSound[/code] is then called on this proxy. this method ensures that other lua scripts listening for entity sounds can intercept and replace them as intended. the proxy is safely removed after a short delay.

*   **procedural pattering:** a configurable burst system allows for sequences of footsteps. the "lerp toward player" option interpolates both volume and distance over the sequence, simulating an entity that is actively approaching the player.

## features

*   **compatibility:** hooks into engine sound scripts and entity emission events, ensuring seamless integration with dsteps, eft footsteps, and similar mods.
*   **dynamic positioning:** adjustable distance and horizontal spread allow for varied sound origins behind the player.
*   **responsive cancellation:** sounds cease if the player looks towards their source, adding a layer of interactive horror.
*   **configurable behavior:** parameters for delay, volume, burst chance, and approach behavior are all adjustable via the in-game utility menu.
*   **performance:** designed with efficiency in mind, minimizing server load.

## installation

this addon is intended to be installed via the steam workshop. however, for development or direct use:

1.  clone this repository or download the source files.
2.  place the `evil_footsteps` folder (containing `addon.json` and the `lua` folder) into your `garrysmod/addons/` directory.
3.  ensure the addon.jsontags and type match the compiler's requirements for successful packing.

## configuration

all runtime parameters can be adjusted through the garry's mod utility menu:
`options > utilities > horror > evil footsteps`

*   general logic: enable/disable, activation probability, min/max intervals.
*   volume: min/max volume levels.
*   positioning: starting distance, horizontal variance.
*   sequence behavior: burst chance, lerp toward player, steps per sequence, delay between steps.
*   debugging: enable debug marker visualization.

## license

this project is licensed under the [mit license](LICENSE).

## contribution

this project is open source. contributions are welcome. please submit pull requests for bug fixes or enhancements.

[b]made by malq.[/b]
