# Puzzle Solver

This project provides solutions to various sliding puzzle problems using the A* (A-star) search algorithm. The puzzles are implemented in Swift, with visualization handled by UIKit. Each puzzle has a unique goal and layout, challenging spatial reasoning and logical thinking.

## Problem Descriptions

### Crown Puzzle

The "Crown Puzzle" consists of a grid with various pieces arranged in different shapes and sizes. The objective is to move the "Crown" piece from its starting position in the upper part of the grid to the bottom row by sliding other pieces around within the grid's constraints.

**Goal:** Move the "Crown" piece to the bottom row.

### Dad's Puzzle (`dad-puzzle` branch)

The "Dad's Puzzle" is another variant with a different layout and objective. In this puzzle, the numbered pieces are arranged in a grid, and the goal is to move the piece labeled "1" from its initial position in the upper left corner to the bottom left corner.

**Goal:** Move the piece with number "1" to the bottom left corner.

## Algorithm

This application uses the A* (A-star) algorithm to find solutions for each puzzle variant. A* is a pathfinding and graph traversal algorithm that combines the cost to reach a node (g-cost) and an estimated cost to the goal (h-cost) to prioritize the most promising nodes in the search space.

1. **Heuristic Function:** A heuristic function estimates the distance from the current state to the goal. For each puzzle, the heuristic considers the unique layout and positioning of pieces relative to the goal.
2. **Search Process:** The algorithm maintains an open list of states to explore and a closed list of states already evaluated. At each step, it selects the state with the lowest combined cost (g-cost + h-cost) and expands it by generating possible moves.
3. **Path to Solution:** When the algorithm finds a solution, it reconstructs the path from the initial state to the goal by tracing back the moves.

This approach ensures that the solution found is optimal in terms of the minimum number of moves required.

## Tech Stack

- **Language:** Swift
- **Algorithm:** A* (A-star) Search
- **User Interface:** UIKit (for visualization)

## Demo

<img src="https://github.com/user-attachments/assets/8dcf7bc5-fe97-4c5b-b2bc-7a911c6dbc5d" height="400" />
<img src="https://github.com/user-attachments/assets/1199d365-d226-46a7-97be-839004bdaf37" height="400" />

## Usage

1. Clone this repository.
2. Open the project in Xcode.
3. Run the application on a simulator or an iOS device.
4. Use the UI to visualize the steps the A* algorithm takes to solve each puzzle and reach the goal.

## License

This project is licensed under the MIT License.
