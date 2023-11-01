require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'

# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
def read_ships_file(path)
    board = GameBoard.new 10, 10

    ships_added = 0
    read_file_lines(path) { |line|
        if (ships_added < 5)
            pattern = /\(([0-9]+),([0-9]+)\), ([A-Z][a-z]+), ([0-9]+)/ # regex pattern
            valid_ships = 0 # number of valid ships
            if pattern =~ line then # checks if the line is formatted like the pattern
                # Position dimensions
                row = $1 # backreferencing
                column = $2
                # converts row and column to integers
                row = row.to_i
                column = column.to_i

                # Ship dimensions
                position = Position.new row, column
                orientation = $3
                # converts size to an integer
                size = $4

                # creates and adds the ship
                size = size.to_i
                ship = Ship.new position, orientation, size
                # checks if the ship was correctly added
                if board.add_ship(ship)
                    ships_added += 1 # increments the number of ships added
                end
            end
        end
    }

    # if less than 5 ships were added
    if ships_added < 5
        return nil
    else
        return board # otherwise, returns the board
    end
end


# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path)
    positions = Array.new(){Array.new()}

    # if the file doesn't exist
    if !read_file_lines(path)
        return nil
    end
    
    read_file_lines(path) { |line|
        pattern = /\(([0-9]+),([0-9]+)\)/
        if pattern =~ line then
            row = $1
            column = $2
            # converts the row and columns to integers
            row = row.to_i
            column = column.to_i

            position = Position.new row, column
            positions.push(position) # adds the Position to the array
        end
    }

    positions # returns the array of Position
end


# ===========================================
# =====DON'T modify the following code=======
# ===========================================
# Use this code for reading files
# Pass a code block that would accept a file line
# and does something with it
# Returns True on successfully opening the file
# Returns False if file doesn't exist
def read_file_lines(path)
    return false unless File.exist? path
    if block_given?
        File.open(path).each do |line|
            yield line
        end
    end

    true
end