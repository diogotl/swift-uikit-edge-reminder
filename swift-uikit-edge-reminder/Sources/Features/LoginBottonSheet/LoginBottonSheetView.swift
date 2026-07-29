//
//  LoginBottonSheetView.swift
//  swift-uikit-edge-reminder
//
//  Created by Diogo on 20/07/2026.
//

import Foundation
import UIKit

class LoginBottonSheetView:UIView {

    var onClose: (() -> Void)?

    private let swipeHandle: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Metrics.little
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✕", for: .normal)
        button.tintColor = Colors.Gray.g500
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = String(localized: "email@example.com")
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let passwordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = String(localized: "Password")
        text.borderStyle = .roundedRect
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private let submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.Red.dark
        button.setTitle(String(localized: "Sign In"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Typography.label
        button.layer.cornerRadius = Metrics.small
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        backgroundColor = .white
        layer.cornerRadius = Metrics.medium
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true

        addSubview(swipeHandle)
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(submitButton)

        closeButton.addTarget(self, action: #selector(handleCloseTap), for: .touchUpInside)

        submitButton.addTarget(self, action: #selector(handleSubmitTouchDown), for: .touchDown)
        submitButton.addTarget(self, action: #selector(handleSubmitTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])

        setupConstraints()
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            swipeHandle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            swipeHandle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),

            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.small),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.small),

            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            passwordLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Metrics.small),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            passwordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            emailTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: Metrics.small),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Metrics.small),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            submitButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Metrics.small),
            submitButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            submitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: Metrics.huge)
        ])
    }

    @objc private func handleCloseTap() {
        onClose?()
    }

    @objc private func handleSubmitTouchDown() {
        UIView.animate(withDuration: 0.16, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) {
            self.submitButton.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }
    }

    @objc private func handleSubmitTouchUp() {
        UIView.animate(withDuration: 0.16, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) {
            self.submitButton.transform = .identity
        }
    }
}
