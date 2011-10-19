/**
 * Game grid
 * 
 * 
 * 1: Normal food
 * 2: Special food (TODO)
 * 5: Teleport - Moving the player at one end of the line will teleport it at
 *    the other end - Ghosts can't teleport. (TODO)
 * 8: Wall
 */

grid = [
  [1,1,1,1,1,1,1,1,1,1,1,1,8,8,1,1,1,1,1,1,1,1,1,1,1,1],
  [2,8,8,8,8,1,8,8,8,8,8,1,8,8,1,8,8,8,8,8,1,8,8,8,8,2],
  [1,8,8,8,8,1,8,8,8,8,8,1,8,8,1,8,8,8,8,8,1,8,8,8,8,1],
  [1,8,8,8,8,1,8,8,8,8,8,1,8,8,1,8,8,8,8,8,1,8,8,8,8,1],
  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
  [1,8,8,8,8,1,8,8,1,8,8,8,8,8,8,8,8,1,8,8,1,8,8,8,8,1],
  [1,8,8,8,8,1,8,8,1,8,8,8,8,8,8,8,8,1,8,8,1,8,8,8,8,1],
  [1,1,1,1,1,1,8,8,1,1,1,1,8,8,1,1,1,1,8,8,1,1,1,1,1,1],
  [8,8,8,8,8,1,8,8,8,8,8,0,8,8,0,8,8,8,8,8,1,8,8,8,8,8],
  [8,8,8,8,8,1,8,8,8,8,8,0,8,8,0,8,8,8,8,8,1,8,8,8,8,8],
  [8,8,8,8,8,1,8,8,0,0,0,0,0,0,0,0,0,0,8,8,1,8,8,8,8,8],
  [8,8,8,8,8,1,8,8,0,8,8,8,0,0,8,8,8,0,8,8,1,8,8,8,8,8],
  [8,8,8,8,8,1,8,8,0,8,0,0,8,8,0,0,8,0,8,8,1,8,8,8,8,8],
  [5,0,0,0,0,1,0,0,0,8,0,0,0,0,0,0,8,0,0,0,1,0,0,0,0,5],
  [8,8,8,8,8,1,8,8,0,8,0,0,0,0,0,0,8,0,8,8,1,8,8,8,8,8],
  [8,8,8,8,8,1,8,8,0,8,8,8,8,8,8,8,8,0,8,8,1,8,8,8,8,8],
  [8,8,8,8,8,1,8,8,0,0,0,0,0,0,0,0,0,0,8,8,1,8,8,8,8,8],
  [8,8,8,8,8,1,8,8,0,8,8,8,8,8,8,8,8,0,8,8,1,8,8,8,8,8],
  [8,8,8,8,8,1,8,8,0,8,8,8,8,8,8,8,8,0,8,8,1,8,8,8,8,8],
  [1,1,1,1,1,1,1,1,1,1,1,1,8,8,1,1,1,1,1,1,1,1,1,1,1,1],
  [1,8,8,8,8,1,8,8,8,8,8,1,8,8,1,8,8,8,8,8,1,8,8,8,8,1],
  [2,8,8,8,8,1,8,8,8,8,8,1,8,8,1,8,8,8,8,8,1,8,8,8,8,2],
  [1,1,1,8,8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,8,8,1,1,1],
  [8,8,1,8,8,1,8,8,1,8,8,8,8,8,8,8,8,1,8,8,1,8,8,1,8,8],
  [8,8,1,8,8,1,8,8,1,8,8,8,8,8,8,8,8,1,8,8,1,8,8,1,8,8],
  [1,1,1,1,1,1,8,8,1,1,1,1,8,8,1,1,1,1,8,8,1,1,1,1,1,1],
  [1,8,8,8,8,8,8,8,8,8,8,1,8,8,1,8,8,8,8,8,8,8,8,8,8,1],
  [1,8,8,8,8,8,8,8,8,8,8,1,8,8,1,8,8,8,8,8,8,8,8,8,8,1],
  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
]

Default = {{

  @private get_grid_nums(n) : set(Base.pos) =
    List.foldi(
      y, l, acc ->
        List.foldi(
          x, v, acc ->
            if v == n then Set.add(~{x y}, acc)
            else acc,
          l, acc),
      grid, Set.empty:set(Base.pos))

  food = get_grid_nums(1)
  walls = get_grid_nums(8)

  pacman = {
    base       = Base.make(0, 0, {right}, 10)
    next_dir   = {right}
    mouth_step = 0
    mouth_incr = 1
    mouth_steps = 10
  } : Pacman.t

  @private make_ghost(ai, x, y, dir, color, eye_color) = {
    ~ai ~color ~eye_color
    base      = Base.make(x, y, dir, 10)
    eye_step  = 0
    eye_steps = 32
  } : Ghost.t

  ghosts = [
    make_ghost({dumb}, 5, 4, {right}, Color.orange, Color.crimson),
    make_ghost({guard}, 20, 4, {down}, Color.darkred, Color.gold),
    make_ghost({dumb}, 20, 22, {left}, Color.purple, Color.silver),
    make_ghost({guard}, 5, 22, {up}, Color.green, Color.navy),
  ] : list(Ghost.t)

}}