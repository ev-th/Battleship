require 'game'
require 'board'
require 'ship'

# place ship adds a ship to the player's board

# place ship removes ship from player's board's unplaced ships

# place ship adds ship to player's board's placed_ships

# placing a ship outside the bounds of the board throws an error

# placing a ship on another ship throws an error by Board which is caught by Game


# shoot adds shot to opponents board

# When attempting to hit the same spot, fails

# When attempting to hit invalid coordinate(eg. ouside the board), fails

# shoot damages a hit ship

# shoot returns result with successful hit

# shoot returns result when sinking a battleship.

# shoot returns result with unsuccessful hit

# shoot makes no changes to ships with a miss