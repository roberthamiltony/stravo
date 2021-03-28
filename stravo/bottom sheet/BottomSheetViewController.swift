//
//  BottomSheetViewController.swift
//  stravo
//
//  Created by Robert Hamilton on 20/03/2021.
//  Copyright © 2021 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol BottomSheetViewControllerDelegate: class {
    func snapped(to point: SnapPoint)
}

/// A view controller presenting content through a bottom sheet.
/// TODO: How can I get content within the sheet to pin to the bottom of the sheet
class BottomSheetViewController: UIViewController {
    
    weak var delegate: BottomSheetViewControllerDelegate?
    var contentSize: SnapPoint { SnapPoint(constant: sheet.intrinsicContentSize.height) }
    var hidden: SnapPoint { SnapPoint(constant: 0) }
    open var snapPoints: [SnapPoint] { [contentSize, hidden] }
    
    /// The bottom sheet view, containing the content for the view controller.
    var sheet: BottomSheetView = {
        return BottomSheetView()
    }()
    
    /// Whether the bottom sheet can be panned to be larger than it's content. If true, the content will remain at the top of the bottom
    /// sheet with empty space below.
    var stretchable: Bool = false
    
    private var panGesture: UIPanGestureRecognizer!
    private var bottomSheetTopConstraint: NSLayoutConstraint!
    private static let maxBackgroundAlpha: CGFloat = 0
    
    override func loadView() {
        view = PassthroughView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        addViews()
        addConstraints()
        setupPanGestureRecogniser()
    }
    
    private func addViews() {
        view.addSubview(sheet)
    }
    
    private func addConstraints() {
        bottomSheetTopConstraint = sheet.topAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([
            sheet.leftAnchor.constraint(equalTo: view.leftAnchor),
            sheet.rightAnchor.constraint(equalTo: view.rightAnchor),
            sheet.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor),
            bottomSheetTopConstraint
        ])
    }
    
    private func setupPanGestureRecogniser() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(_:)))
        sheet.addGestureRecognizer(panGesture)
        sheet.isUserInteractionEnabled = true
    }
    
    @objc func panGestureHandler(_ recogniser: UIPanGestureRecognizer) {
        switch recogniser.state {
        case .began, .changed:
            let translation = recogniser.translation(in: view)
            let newConstant = bottomSheetTopConstraint.constant + translation.y
            if !stretchable && (abs(newConstant) > sheet.intrinsicContentSize.height) {
                updateBottomSheetConstraint(withConstant: -sheet.intrinsicContentSize.height)
            } else {
                updateBottomSheetConstraint(withConstant: newConstant)
            }
            recogniser.setTranslation(.zero, in: view)
        case .ended:
            self.snap(to: calculateSnapPoint())
        default:
            break
        }
    }
    
    private func calculateSnapPoint() -> SnapPoint {
        let currentOffset = abs(bottomSheetTopConstraint.constant)
        let minimum = snapPoints.min(by: { lhs, rhs in
            abs(lhs.constant - currentOffset) < abs(rhs.constant - currentOffset)
        })
        return minimum ?? hidden
    }
    
    private func updateBottomSheetConstraint(withConstant constant: CGFloat) {
        bottomSheetTopConstraint.constant = constant
        view.backgroundColor = view.backgroundColor?.withAlphaComponent(
            min(abs(constant) / sheet.intrinsicContentSize.height, 1) * BottomSheetViewController.maxBackgroundAlpha
        )
    }
    
    /// Snaps the bottom sheet to the given position.
    ///
    /// - Parameters:
    ///   - snapPoint: The position to snap the bottom sheet to.
    ///   - animated: Whether the snap should be animated.
    func snap(to snapPoint: SnapPoint, animated: Bool = true) {
        UIView.animate(
            withDuration: animated ? 0.15 : 0, delay: 0, options: [.curveEaseOut],
            animations: {
                self.updateBottomSheetConstraint(withConstant: -snapPoint.constant)
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.didSnap(to: snapPoint)
            }
        )
    }
    
    /// Called after the bottom sheet snaps to a point. Subclasses should override this to implement reactions to the bottom sheet
    /// state.
    ///
    /// - Parameter snapPoint: The position the bottom sheet snapped to.
    open func didSnap(to snapPoint: SnapPoint) {
        delegate?.snapped(to: snapPoint)
    }
}

/// A simple view containing a handle and a content view.
class BottomSheetView: UIView {
    let handleHeight = 4
    let handleTopInset = 10
    
    /// When providing custom Snap Points, include this.
    /// Probably a nicer way of doing this
    var insetToContent: Int { handleHeight + handleTopInset }
    
    private let handle: UIView = {
        var handleView = UIView()
        handleView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.24).cgColor
        handleView.layer.cornerRadius = 2
        return handleView
    }()
    
    var contentView: UIView = {
        var content = UIView()
        return content
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: contentView.frame.height + handle.frame.height)
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        backgroundColor = .systemBackground
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(contentView)
        addSubview(handle)
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        handle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(handleTopInset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top)
            make.width.equalTo(35)
            make.height.equalTo(handleHeight)
        }
    }
}

class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}

struct SnapPoint: Equatable {
    let constant: CGFloat
}
