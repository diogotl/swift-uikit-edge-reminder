//
//  SplashViewController.swift
//  swift-uikit-edge-reminder
//
//  Created by Diogo on 20/07/2026.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {

    let contentView = SplashView()

    private let loginBottomSheetDelay: TimeInterval = 2
    private var hasPresentedLoginBottomSheet = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard !hasPresentedLoginBottomSheet else { return }
        hasPresentedLoginBottomSheet = true

        DispatchQueue.main.asyncAfter(deadline: .now() + loginBottomSheetDelay) { [weak self] in
            self?.presentLoginBottomSheet()
        }
    }

    private func setup(){
        self.view.addSubview(contentView)
 
        
        setupConstraints()
    }

    private func presentLoginBottomSheet(){
        let loginBottomSheetViewController = LoginBottonSheetViewController()
        loginBottomSheetViewController.modalPresentationStyle = .overFullScreen
        present(loginBottomSheetViewController, animated: false)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}
