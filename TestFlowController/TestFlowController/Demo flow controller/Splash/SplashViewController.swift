//
//  SplashViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/20.
//

import UIKit
import Combine

protocol SplashViewControllerDelegate: AnyObject {
    func splashViewControllerDidFinishLaunch(_ viewController: SplashViewController)
}

class SplashViewController: LogViewController {
    private var timerCancellable: AnyCancellable?
    weak var delegate: SplashViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .red
        label.text = "Splash"
        label.center = view.center
        label.frame.size = CGSize(width: 100, height: 40)
        view.addSubview(label)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timerCancellable = Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.timerCancellable?.cancel()
                self.timerCancellable = nil
                self.delegate?.splashViewControllerDidFinishLaunch(self)
            })
    }
}
