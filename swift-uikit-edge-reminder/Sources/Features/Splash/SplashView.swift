//
//  SplashView.swift
//  swift-uikit-edge-reminder
//
//  Created by Diogo on 20/07/2026.
//

import Foundation
import UIKit

class SplashView: UIView {

    private let logoImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reminder"
        label.font = .boldSystemFont(ofSize: 48)
        label.textColor = Colors.Gray.g100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = Colors.Red.base
        addSubview(logoImg)
        addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 24),
            subtitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            logoImg.trailingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor, constant: -8),
            logoImg.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor)
        ])
    }
}
