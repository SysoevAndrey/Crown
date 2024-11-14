//
//  ViewController.swift
//  Crown-iOS
//
//  Created by Andrey Sysoev on 07.04.2023.
//

import UIKit

final class ViewController: UIViewController {
    static let gap: CGFloat = 5
    
    private lazy var area: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.frame = CGRect(x: 60, y: 150, width: 200, height: 250)
        return view
    }()
    
    private lazy var view1: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view3: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view4: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view5: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view6: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view7: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view8: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view9: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view10: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var view11: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()
    private lazy var crown: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.borderWidth = 1
        view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        let brainteaser = Brainteaser()
        let paths = brainteaser.start()
        
        print(paths)
        print(paths.count)
        
        setInitialFrame(state: paths[0])

        let views: [UIView: String] = [
            crown: "crown",
//            view1: "view1",
            view2: "view2",
            view3: "view3",
            view4: "view4",
            view5: "view5",
            view6: "view6",
            view7: "view7",
            view8: "view8",
            view9: "view9",
//            view10: "view10",
//            view11: "view11"
        ]

        for (view, name) in views {
            let animation = makeKeyframes(for: name, in: paths)
            view.layer.add(animation, forKey: "animation")
        }
    }

    private func setupView() {
        view.addSubview(area)
        view.addSubview(view1)
        view.addSubview(view2)
        view.addSubview(view3)
        view.addSubview(view4)
        view.addSubview(view5)
        view.addSubview(view6)
        view.addSubview(view7)
        view.addSubview(view8)
        view.addSubview(view9)
        view.addSubview(view10)
        view.addSubview(view11)
        view.addSubview(crown)
    }
    
    private func setInitialFrame(state: State) {
        crown.frame = makeFrame(by: "crown", from: state.figures)
//        view1.frame = makeFrame(by: "view1", from: state.figures)
        view2.frame = makeFrame(by: "view2", from: state.figures)
        view3.frame = makeFrame(by: "view3", from: state.figures)
        view4.frame = makeFrame(by: "view4", from: state.figures)
        view5.frame = makeFrame(by: "view5", from: state.figures)
        view6.frame = makeFrame(by: "view6", from: state.figures)
        view7.frame = makeFrame(by: "view7", from: state.figures)
        view8.frame = makeFrame(by: "view8", from: state.figures)
        view9.frame = makeFrame(by: "view9", from: state.figures)
//        view10.frame = makeFrame(by: "view10", from: state.figures)
//        view11.frame = makeFrame(by: "view11", from: state.figures)
    }
    
    private func makeKeyframes(for view: String, in states: [State]) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        var values = [CGPoint]()
        for state in states {
            guard let figure = state.figures[view] else { fatalError("Фигура не найдена") }
            values.append(CGPoint(x: figure.x * 50 + 10, y: figure.y * 50 + 100))
        }
        animation.values = values
        animation.duration = 20
        return animation
    }
    
    private func makeFrame(by name: String, from figures: [String: Figure]) -> CGRect {
        guard let figure = figures[name] else { fatalError("Фигура не найдена") }
        return CGRect(x: figure.x * 50 + 10, y: figure.y * 50 + 100, width: figure.width * 50, height: figure.height * 50)
    }
}
