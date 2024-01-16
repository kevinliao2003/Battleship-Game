# Battleship Game

Welcome to the Battleship Game, a Ruby implementation of the classic battleship-style game. This game allows players to create a game board, add ships to it, and attempt attacks to sink the opponent's ships.

## Installation

Clone the repository to your local machine:

```bash
git clone <repository_url>

Navigate to the project directory:
```

```bash
cd battleship-game-ruby
```

## Usage

To use the Battleship Game, include the necessary files in your Ruby project:

```ruby
require_relative 'path/to/game_board'
require_relative 'path/to/ship'
require_relative 'path/to/position'
```

Create instances of the GameBoard, Ship, and Position classes to set up the game.

## File Handling

The provided script includes functions for reading ship and attack information from files. You can use the read_ships_file and read_attacks_file functions to populate the game board from external files.

## GameBoard Class

The GameBoard class provides the core functionality for the game. It includes methods to add ships, perform attacks, check for successful attacks, and determine if all ships are sunk. Additionally, there is a method to obtain a string representation of the game board for easy debugging.

### GameBoard Initialization

```ruby
# Example:
game_board = GameBoard.new(10, 10)
```

### Adding Ships

```ruby
# Example:
ship = Ship.new(Position.new(2, 3), 'Down', 3)
game_board.add_ship(ship)
```

### Performing Attacks

```ruby
# Example:
position = Position.new(2, 3)
game_board.attack_pos(position)
```

## Sample Usage

Here's a basic example of using the Battleship Game:

```ruby
# Initialize the game board
game_board = GameBoard.new(10, 10)

# Add ships to the board
ship1 = Ship.new(Position.new(2, 3), 'Down', 3)
ship2 = Ship.new(Position.new(5, 5), 'Right', 4)

game_board.add_ship(ship1)
game_board.add_ship(ship2)

# Perform attacks
attack_position = Position.new(2, 3)
game_board.attack_pos(attack_position)

# Check successful attacks
puts "Successful Attacks: #{game_board.num_successful_attacks}"

# Check if all ships are sunk
if game_board.all_sunk?
  puts "Congratulations! You sank all the ships!"
else
  puts "Keep attacking! Some ships are still afloat."
end
```

## Contributing

If you'd like to contribute to the development of the Battleship Game, feel free to submit pull requests or open issues on the GitHub repository.

## License

This project is licensed under the MIT License.

```typescript
Replace `<repository_url>` with the actual URL of your GitHub repository. Customize the README to include specific details about your project, such as additional features, dependencies, or any other relevant information.
```