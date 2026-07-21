//
//  LoginBottonSheetViewController.swift
//  swift-uikit-edge-reminder
//
//  Created by Diogo on 20/07/2026.
//

import Foundation
import UIKit

class LoginBottonSheetViewController: UIViewController {

    private let contentView = LoginBottonSheetView()
    private let dismissThreshold: CGFloat = 0.3
    private let dismissVelocity: CGFloat = 800

    private let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var contentViewTopConstraint: NSLayoutConstraint?

    private var contentViewHeight: CGFloat {
        view.bounds.height / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animatePresent()
    }

    private func setup() {
   
        view.addSubview(dimmingView)
        view.addSubview(contentView)

        contentView.onClose = { [weak self] in
            self?.animateDismiss()
        }

        setupConstraints()
        setupGesture()
    }

    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = contentView.topAnchor.constraint(equalTo: view.bottomAnchor)
        contentViewTopConstraint = topConstraint

        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            topConstraint,
        ])
    }

    private func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        contentView.addGestureRecognizer(panGesture)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDimmingTap))
        dimmingView.addGestureRecognizer(tapGesture)
    }

    @objc private func handleDimmingTap() {
        animateDismiss()
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let offset = max(0, gesture.translation(in: contentView).y)

        switch gesture.state {
        case .changed:
            contentViewTopConstraint?.constant = -contentViewHeight + offset
            view.layoutIfNeeded()

        case .ended, .cancelled:
            let velocity = gesture.velocity(in: contentView).y
            let shouldDismiss = offset > contentViewHeight * dismissThreshold || velocity > dismissVelocity

            if shouldDismiss {
                animateDismiss(velocity: velocity)
            } else {
                animateReopen(velocity: velocity)
            }

        default:
            break
        }
    }

    private func animatePresent() {
        animate(to: -contentViewHeight, velocity: 0, alpha: 1, duration: 0.45)
    }

    private func animateReopen(velocity: CGFloat = 0) {
        animate(to: -contentViewHeight, velocity: velocity, alpha: 1, duration: 0.4)
    }

    private func animateDismiss(velocity: CGFloat = 0) {
        animate(to: 0, velocity: velocity, alpha: 0, duration: 0.3) { [weak self] in
            self?.dismiss(animated: false)
        }
    }

    private func animate(
        to constant: CGFloat,
        velocity: CGFloat,
        alpha: CGFloat,
        duration: TimeInterval,
        completion: (() -> Void)? = nil
    ) {
        let distance = abs(constant - (contentViewTopConstraint?.constant ?? 0))
        let springVelocity = distance > 0 ? abs(velocity) / distance : 0

        contentViewTopConstraint?.constant = constant

        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: springVelocity,
            options: [],
            animations: {
                self.dimmingView.alpha = alpha
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                completion?()
            }
        )
    }
}
