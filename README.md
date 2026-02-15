# WeGuide - Coding Challenge

## The Pawn Simulator

TODO: prep readme

Initial Plannings:
### Models
- ChessGame
  - holds current pawn state
  - history of commands/results
- Potential Fields
  - pawn_x integer
  - pawn_y integer
  - direction string
  - colour string
  - history json
  - timestamps

### Domain Logics
- Board
  - own board properties: size
  - ensures pawn is in bound
- Pawn
  - position: position (coordinates) on the board
  - actions: movement, rotation
  - rules: rules for actions

### Service
- Command Executor Service
  - parse raw commands
  - excercise domain logic on the Board model
  - validate command and arguments
  - ignore invalid commands

### Controller
- Board Controller
  - executes commands
  - render results
  - resets the board state

### Viewes
- Single Board View
  - textarea for command & arguments input
  - buttons: submit and rest
  - scrollable div: display result logs
  - tailwindCss for css clases
  - Turbo Stream for preventing page reload (TBC)

### Test
- pawn movement behaviour
- edge cases: invalid commands, board boundry
