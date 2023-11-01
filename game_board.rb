class GameBoard
    # @max_row is an `Integer`
    # @max_column is an `Integer`
    attr_reader :max_row, :max_column

    # @board marks the ships
    # @attacked marks the ships have been attacked
    # @attacks is the # of successful attacks
    def initialize(max_row, max_column)
        @max_row = max_row
        @max_column = max_column
        @board = Array.new(max_row){Array.new(max_column)}
        @attacked = Array.new(max_row){Array.new(max_column)}
        @attacks = 0

        # initializes board
        # true - ship, false - no ship
        for r in 0..(max_row-1) do
            for c in 0..(max_column-1) do
                @board[r][c] = false 
            end
        end

        # initializes attacked
        # true - position attacked, false - position not attacked
        for r in 0..(max_row-1) do
            for c in 0..(max_column-1) do
                @board[r][c] = false
            end
        end
    end

    # adds a Ship object to the GameBoard
    # returns Boolean
    # Returns true on successfully added the ship, false otherwise
    # Note that Position pair starts from 1 to max_row/max_column
    def add_ship(ship)
        start_position = ship.start_position;
        orientation = ship.orientation
        size = ship.size
        
        # row and col of start_position
        start_row = start_position.row
        start_col = start_position.column

        # checks if start_position is valid
        if start_row < 1 && start_row > @max_row && start_col < 1 && start_col > @max_column
            return false
        end

        # row and col of the end position
        end_row = 0
        end_col = 0

        # determines the end position
        if orientation == "Up"
            end_row = start_row - (size - 1)
            end_col = start_col
        elsif orientation == "Down"
            end_row = start_row + (size - 1)
            end_col = start_col
        elsif orientation == "Left"
            end_row = start_row
            end_col = start_col - (size - 1)
        else
            end_row = start_row
            end_col = start_col + (size - 1)
        end

        # swaps end_row and start_row, if end_row is less than start_row
        if end_row < start_row
            temp = end_row
            end_row = start_row
            start_row = temp
        end
        # swaps end_col and start_col, if end_col is less than end_col
        if end_col < start_col
            temp = end_col
            end_col = start_col
            start_col = temp
        end

        # if the ship is inside the gameboard
        if end_row >= 1 && end_row <= @max_row && end_col >= 1 && end_col <= @max_column
            for r in start_row..end_row do
                for c in start_col..end_col do
                    # if there is already another ship in the position
                    if @board[r - 1][c - 1] || @attacked[r - 1][c - 1]
                        return false # the ship cannot be added
                    end
                end
            end
        else
            return false
        end

        # adds the ship
        for r in start_row..end_row do
            for c in start_col..end_col do
                @board[r - 1][c - 1] = true
            end
        end

        true # else, the ship can be added
    end

    # return Boolean on whether attack was successful or not (hit a ship?)
    # return nil if Position is invalid (out of the boundary defined)
    def attack_pos(position)
        # checks the position
        row = position.row
        col = position.column
        if row < 1 || row > @max_row || col < 1 || col > @max_column
            return nil
        end

        # attacking a position that was previously attacked will return true
        if @attacked[row - 1][col - 1]
            return true
        end
        # checks if the attack was successful
        if @board[row - 1][col - 1]
            @board[row - 1][col - 1] = false # removes part of the ship
            @attacked[row - 1][col - 1] = true
            @attacks += 1
            return true
        end

        false # else, the attack was unsuccessful
    end

    # Number of successful attacks made by the "opponent" on this player GameBoard
    def num_successful_attacks
        @attacks
    end

    # returns Boolean
    # returns True if all the ships are sunk.
    # Return false if at least one ship hasn't sunk.
    def all_sunk?
        for r in 0..(@max_row - 1) do
            for c in 0..(@max_column - 1) do
                # if a part of a ship has not been sunk
                if @board[r][c]
                    return false
                end
            end
        end

        true
    end

    # String representation of GameBoard (optional but recommended)
    def to_s
        for r in 0..(@max_row - 1) do
            string = ""

            for c in 0..(@max_column - 1) do
                string += "| "
                if @board[r][c]
                    string += "B"
                else 
                    string += "-"
                end

                if @attacked[r][c]
                    string += ", A |"
                else
                    string += ", - |"
                end
            end

            puts string
            puts "\n" # prints out an empty line
        end
    end
end