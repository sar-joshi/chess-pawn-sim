# WeGuide - Coding Challenge

## The Pawn Simulator

TODO: prep readme

Initial Plannings:
### Models
- Board
  - holds current board state
  - validates pawn movements
- Fields
  - pawn_x
  - pawn_y
  - direction
  - colour

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
