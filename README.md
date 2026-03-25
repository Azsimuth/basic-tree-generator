# basic-tree-generator
Quick hacked together GML white/pink wild-cherry tree generator.
This is meant to be used by only drawing the screen upon key press, and saved as an image.
It is not designed to be ran in real time. The code has not been optimized at all, and may not be of particularly high quality.

initial goal: 
f(int height) -> (draws a tree to the screen)

## Requires
[Game maker 8.2](https://gm82.cherry-treehouse.com/), Game Maker 8.2 Core extention. ( for point_in_circle() ) 
[/media/sprites](./media/sprites) to be loaded, and named spr_folliage_main, spr_folliage_greener, ... and so on, as the code references it.

## Output

![White](https://github.com/Azsimuth/basic-tree-generator/blob/main/media/white-cherry.gif)
![Pink](https://github.com/Azsimuth/basic-tree-generator/blob/main/media/pink-cherry.gif)

## Improvement opportunities

- [ ] Read sprites programatically by the script
- [ ] Save generated tree sprites programatically with the script
- [ ] generate variants to enable motion, in an imitation of some for of animation

## Likelyness that I'll touch this script again

Very rather little.
