//
//  Brainteaser.swift
//  Crown-iOS
//
//  Created by Andrey Sysoev on 07.04.2023.
//

import Foundation

final class Brainteaser {
    var closed: Set<State> = []
    var opened: Array<State> = area.state
    var end: State? = nil
    
    func start() -> [State] {
        while !opened.isEmpty {
            guard let firstMin = opened.min(by: { $0.f < $1.f }) else { fatalError("State with min F isn't found") }
            
            let min = firstMin.f
            let minimums = opened.filter { $0.f == min }
            
            let currentState = minimums.shuffled().first!
            
            let crown = currentState.figures["crown"]
            
            print("closed: \(closed.count); opened: \(opened.count); h: \(currentState.h), g: \(currentState.g); crown: \(crown!.x),\(crown!.y)")
            
            if currentState.h == 0 {
                end = currentState
                break
            }
            
            guard let currentStateIndex = opened.firstIndex(of: currentState) else { fatalError("Unable to find state") }
            
            opened.remove(at: currentStateIndex)
            closed.insert(currentState)
            
            var neighbours = [State]()
            
            for (_, figure) in currentState.figures {
                let availableMoves = Direction.allCases.filter { currentState.checkIfMoveAvailable(for: figure, in: $0) }

                availableMoves.forEach { direction in
                    neighbours.append(currentState.generateStateByMoving(figure, to: direction))
                }
            }
            
            let unclosedNeighbours = neighbours.filter { !closed.contains($0) }
            
            for unclosedNeighbour in unclosedNeighbours {
                let indexInOpened = opened.firstIndex(of: unclosedNeighbour)
                
                if indexInOpened == nil {
                    opened.append(unclosedNeighbour)
                } else if unclosedNeighbour.g < opened[opened.distance(from: opened.startIndex, to: indexInOpened!)].g  {
                    opened[opened.distance(from: opened.startIndex, to: indexInOpened!)].from = currentState
                }
            }
        }
        
        var paths = [State]()
        
        guard var end else { fatalError("Solution was not found") }
        
        repeat {
            paths.append(end)
            end = end.from!
        } while end.from != nil
        
        paths = paths.reversed()
        
        return paths
    }
}

extension Brainteaser {
    struct Area {
        let gridWidth: Int
        let gridHeight: Int
        var state: Array<State>
    }
    
    static var area: Area = area20
    
    static let area21 = Area(
        gridWidth: 4,
        gridHeight: 5,
        state: [State(figures: [
            "crown": Figure(name: "crown", width: 2, height: 2, x: 1, y: 1),
            "": Figure(name: "1", width: 1, height: 1, x: 1, y: 3),
            "2": Figure(name: "2", width: 1, height: 2, x: 1, y: 4),
            "3": Figure(name: "3", width: 1, height: 1, x: 2, y: 3),
            "4": Figure(name: "4", width: 1, height: 2, x: 2, y: 4),
            "5": Figure(name: "5", width: 2, height: 1, x: 3, y: 1),
            "6": Figure(name: "6", width: 2, height: 1, x: 3, y: 2),
            "7": Figure(name: "7", width: 2, height: 1, x: 3, y: 4),
            "8": Figure(name: "8", width: 2, height: 1, x: 3, y: 5),
        ])]
    )
    
    static let area20 = Area(
        gridWidth: 4,
        gridHeight: 6,
        state: [State(figures: [
            "crown": Figure(name: "crown", width: 2, height: 2, x: 2, y: 1),
            "view1": Figure(name: "view1", width: 1, height: 1, x: 1, y: 1),
            "view2": Figure(name: "view2", width: 1, height: 1, x: 1, y: 2),
            "view3": Figure(name: "view3", width: 1, height: 2, x: 1, y: 3),
            "view4": Figure(name: "view4", width: 1, height: 1, x: 1, y: 5),
            "view5": Figure(name: "view5", width: 1, height: 1, x: 4, y: 1),
            "view6": Figure(name: "view6", width: 1, height: 1, x: 4, y: 2),
            "view7": Figure(name: "view7", width: 1, height: 2, x: 4, y: 3),
            "view8": Figure(name: "view8", width: 1, height: 1, x: 4, y: 5),
            "view9": Figure(name: "view9", width: 2, height: 1, x: 2, y: 3),
            "view10": Figure(name: "view10", width: 1, height: 1, x: 2, y: 4),
            "view11": Figure(name: "view11", width: 1, height: 1, x: 3, y: 4)
        ])]
    )
}
