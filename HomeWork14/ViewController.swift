//
//  ViewController.swift
//  HomeWork14
//
//  Created by Darya Grabowskaya on 12.10.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var rabbitView: UIView!
    
    // MARK: - Private properties
    private let imageBackground = UIImage(named: "background")
    private var imageCarrot = UIImage(named: "carrot")
    private lazy var imageViewCarrot = UIImageView(image: imageCarrot)
    private lazy var imageViewCarrotSecond = UIImageView(image: imageCarrot)
    private var imageCabbage = UIImage(named: "cabbage")
    private lazy var imageViewCabbage = UIImageView(image: imageCabbage)
    private var isFirstLoad = true
    private var rabbitSize: CGFloat = 0
    private var defaultSpacing: CGFloat = 0
    private var rabbitLocation: Location = .center {
        willSet (newLocation) {
            layoutRabbit(at: newLocation)
        }
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: imageBackground ?? UIImage())
        imageViewCarrot.frame = CGRect(x: 30, y: -100, width: 90, height: 90)
        imageViewCarrotSecond.frame = CGRect(x: 280, y: -190, width: 90, height: 90)
        imageViewCabbage.frame = CGRect(x: 150, y: -220, width: 75, height: 75)
        
        view.addSubview(imageViewCarrot)
        view.addSubview(imageViewCarrotSecond)
        view.addSubview(imageViewCabbage)
        setupRabbit()
        rabbitLocation = .center
    }
    
    override func viewWillLayoutSubviews() {
        if isFirstLoad {
            rabbitSize = 140
            defaultSpacing = (view.frame.width - rabbitSize * 3) / 4
            setupRabbit()
            view.addSubview(rabbitView)
            layoutRabbit(at: .center)
            isFirstLoad = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2, delay: 0.4, options: [.curveEaseInOut, .repeat], animations: {
            self.imageViewCarrot.frame.origin.y += self.view.frame.height + 150
        })
        UIView.animate(withDuration: 2.5, delay: 0.6, options: [.curveEaseInOut, .repeat], animations: {
            self.imageViewCarrotSecond.frame.origin.y += self.view.frame.height + 300
        })
        UIView.animate(withDuration: 2.3, delay: 1, options: [.curveEaseInOut, .repeat], animations: {
            self.imageViewCabbage.frame.origin.y += self.view.frame.height + 320
        })
        
    }
    
    // MARK: - Private methods
    private func setupRabbit() {
        rabbitView.frame = CGRect(
            x: getOriginX(for: .center),
            y: view.frame.size.height - rabbitSize,
            width: rabbitSize,
            height: rabbitSize
        )
        
        addSwipeGesture(to: rabbitView, direction: .left)
        addSwipeGesture(to: rabbitView, direction: .right)
    }
    
    private func addSwipeGesture(to view: UIView, direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveRabbit))
        swipeGesture.direction = direction
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func moveRabbit(_ gestureRecognizer: UISwipeGestureRecognizer) {
        
        switch gestureRecognizer.direction {
        case .left:
            if rabbitLocation == .center {
                rabbitLocation = .left }
            if rabbitLocation == .right {
                rabbitLocation = .center }
        case .right:
            if rabbitLocation == .center {
                rabbitLocation = .right }
            if rabbitLocation == .left {
                rabbitLocation = .center }
        default:
            return
        }
    }
    
    private func layoutRabbit(at location: Location) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.rabbitView.frame.origin.x = self.getOriginX(for: location)
        }
        }
        
        private func getOriginX(for location: Location) -> CGFloat {
            switch location {
            case .left:
                return defaultSpacing
            case .center:
                return defaultSpacing * 2 + rabbitSize
            case .right:
                return defaultSpacing * 3 + rabbitSize * 2
            }
        }
    
    private func intersects(_ rabbitView: CGRect) -> Bool {
        let intersect = imageViewCarrot.frame.intersects(rabbitView)
        return true
    }
    
}
