//
//  State.swift
//  Crown-iOS
//
//  Created by Andrey Sysoev on 07.04.2023.
//

import Foundation

let gridWidth = 4
let gridHeight = 5

final class State {
    weak var from: State?
    var g: Int {
        guard let g = from?.g else { return 0 }
        return g + 1
    }
    var h: Int {
        guard let crown = figures["crown"] else { fatalError("Короны нет") }
        
        if 5 - crown.y == 0 {
            return 0
        }
        
        var sum = 0
        
        for (_, figure) in figures {
            if figure.name == "crown" {
                continue
            }
            
            if figure.width > 1 {
                sum += figure.x + figure.y * 2
                continue
            }
            
            if figure.height > 1 {
                sum += figure.x * 2 + figure.y
                continue
            }
            
            sum += figure.x + figure.y
        }
        
        return (5 - crown.y) * 2000 + (3 - crown.x) * 1000 + sum
    }
    var f: Int {
        g + h
    }
    var figures: [String: Figure]
    private var emptyCells: [Cell: Cell] {
        var cells: [Cell: Cell] = [:]
        
        for x in 1...Brainteaser.area.gridWidth {
            for y in 1...Brainteaser.area.gridHeight {
                var isEmpty = true
                for (_, figure) in figures {
                    if figure.width - 1 + figure.x >= x &&
                        figure.x <= x &&
                        figure.height - 1 + figure.y >= y &&
                        figure.y <= y
                    {
                        isEmpty = false
                    }
                }
                if isEmpty {
                    let emptyCell = Cell(x: x, y: y)
                    cells[emptyCell] = emptyCell
                }
            }
        }
        
        return cells
    }
    
    init(figures: [String: Figure], from: State? = nil) {
        self.figures = figures
        self.from = from
    }
    
    func generateStateByMoving(_ figure: Figure, to direction: Direction) -> State {
        let newState = State(figures: figures, from: self)
        guard let _ = newState.figures[figure.name] else { fatalError("Фигура для движения не найдена") }
        
        switch direction {
        case .top:
            newState.figures[figure.name]!.y -= 1
        case .right:
            newState.figures[figure.name]!.x += 1
        case .bottom:
            newState.figures[figure.name]!.y += 1
        case .left:
            newState.figures[figure.name]!.x -= 1
        }
        
        return newState
    }
    
    func checkIfMoveAvailable(for figure: Figure, in direction: Direction) -> Bool {
        var emptyCellsCount = 0
        switch direction {
        case .top:
            for w in 0..<figure.width {
                if let _ = emptyCells[Cell(x: figure.x + w, y: figure.y - 1)] {
                    emptyCellsCount += 1
                }
            }
        case .right:
            for h in 0..<figure.height {
                if let _ = emptyCells[Cell(x: figure.x + figure.width, y: figure.y + h)] {
                    emptyCellsCount += 1
                }
            }
        case .bottom:
            for w in 0..<figure.width {
                if let _ = emptyCells[Cell(x: figure.x + w, y: figure.y + figure.height)] {
                    emptyCellsCount += 1
                }
            }
        case .left:
            for h in 0..<figure.height {
                if let _ = emptyCells[Cell(x: figure.x - 1, y: figure.y + h)] {
                    emptyCellsCount += 1
                }
            }
        }
        
        switch direction {
        case .top, .bottom:
            return emptyCellsCount == figure.width
        case .left, .right:
            return emptyCellsCount == figure.height
        }
    }
}

extension State: CustomDebugStringConvertible {
    var debugDescription: String {
        "figures: \(self.figures)"
    }
}

extension State: Equatable {
    static func == (lhs: State, rhs: State) -> Bool {
        lhs.figures == rhs.figures
    }
}

extension State: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(figures)
    }
}
