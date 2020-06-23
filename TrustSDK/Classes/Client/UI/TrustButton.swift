// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit

public final class TrustButton: UIButton {
    private var isFullRounded: Bool = false

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        self.apply(theme: .blue)
    }

    public func apply(theme: TrustButtonTheme) {
        for style in theme.styles {
            apply(style: style)
        }
    }

    func apply(style: TrustButtonStyle) {
        switch style {
        case let .title(font, icon):
            self.titleLabel?.font = font
            self.applyTitle(font: font, icon: icon)
        case let .tintColor(color):
            self.tintColor = color
        case let .backgroundColor(color):
            self.backgroundColor = color
        case let .border(width, color):
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = width
        case let .round(radius):
            self.layer.cornerRadius = radius
            self.isFullRounded = false
        case .roundFull:
            self.layer.cornerRadius = 0
            self.isFullRounded = true
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if isFullRounded {
            self.layer.cornerRadius = self.bounds.height / 2.0
        }
    }

    private func applyTitle(font: UIFont, icon: TrustSDK.Icon) {
        let imageSize = CGSize(width: 20, height: 20)
        let titleString = NSMutableAttributedString(string: "Pay With ")
        let iconAttachment = NSTextAttachment()
        iconAttachment.image = icon.image
        iconAttachment.bounds = CGRect(origin: CGPoint(x: 0, y: (font.capHeight - imageSize.height) / 2), size: imageSize)
        let iconString = NSAttributedString(attachment: iconAttachment)
        let trustString = NSAttributedString(string: "Wallet")

        titleString.append(iconString)
        titleString.append(trustString)

        super.setAttributedTitle(titleString, for: .normal)
    }

    public override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {

    }

    public override func setTitle(_ title: String?, for state: UIControl.State) {

    }

    public override func setImage(_ image: UIImage?, for state: UIControl.State) {

    }
}
