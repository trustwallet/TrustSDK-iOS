// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public struct TrustButtonTheme {
    let styles: [TrustButtonStyle]

    public init(_ styles: TrustButtonStyle...) {
        self.styles = styles
    }

    init(styles: [TrustButtonStyle]) {
        self.styles = styles
    }

    public func with(styles: TrustButtonStyle...) -> TrustButtonTheme {
        let current = self.styles.filter { !styles.contains($0) }
        return TrustButtonTheme(styles: current + styles)
    }

    public static let white = TrustButtonTheme(
        .font(.systemFont(ofSize: 18, weight: .regular)),
        .tintColor(TrustSDK.Colors.blue),
        .backgroundColor(TrustSDK.Colors.light),
        .border(width: 1, color: TrustSDK.Colors.blue),
        .round(radius: 8.0)
    )

    public static let blue = TrustButtonTheme(
        .font(.systemFont(ofSize: 18, weight: .regular)),
        .tintColor(TrustSDK.Colors.white),
        .backgroundColor(TrustSDK.Colors.blue),
        .round(radius: 8.0)
    )

    public static let black = TrustButtonTheme(
        .font(.systemFont(ofSize: 18, weight: .regular)),
        .tintColor(TrustSDK.Colors.white),
        .backgroundColor(TrustSDK.Colors.black),
        .border(width: 1, color: TrustSDK.Colors.white),
        .round(radius: 8.0)
    )
}

enum TrustButtonStyleName: String {
    case icon
    case font
    case title
    case backgroundColor
    case tintColor
    case border
    case round
    case roundFull
}

public enum TrustButtonTitleStyle {
    case plain(String)
    case payWithTrust(icon: TrustSDK.Icon, size: CGSize = CGSize(width: 20, height: 20))

    func title(font: UIFont) -> NSAttributedString {
        switch self {
        case .plain(let title):
            return NSAttributedString(string: title)
        case let .payWithTrust(icon, iconSize):
            let titleString = NSMutableAttributedString(string: "Pay with".localized())
            titleString.append(NSAttributedString(string: " "))

            let iconAttachment = NSTextAttachment()
            iconAttachment.image = icon.image
            iconAttachment.bounds = CGRect(origin: CGPoint(x: 0, y: (font.capHeight - iconSize.height) / 2), size: iconSize)

            titleString.append(NSAttributedString(attachment: iconAttachment))
            titleString.append(NSAttributedString(string: "Wallet".localized()))

            return titleString
        }

    }
}

public enum TrustButtonStyle {
    case backgroundColor(UIColor)
    case tintColor(UIColor)
    case font(UIFont)
    case icon(TrustSDK.Icon, insets: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 0, bottom: 5.0, right: 8.0))
    case title(TrustButtonTitleStyle)
    case border(width: CGFloat, color: UIColor)
    case round(radius: CGFloat)
    case roundFull

    var name: TrustButtonStyleName {
        switch self {
        case .icon: return .icon
        case .font: return .font
        case .title: return .title
        case .backgroundColor: return .backgroundColor
        case .tintColor: return .tintColor
        case .border: return .border
        case .round: return .round
        case .roundFull: return .roundFull
        }
    }
}

extension TrustButtonStyle: Hashable {
    public static func == (lhs: TrustButtonStyle, rhs: TrustButtonStyle) -> Bool {
        return lhs.name == rhs.name
    }

    public func hash(into hasher: inout Hasher) {
        self.name.hash(into: &hasher)
    }
}

extension Array where Element == TrustButtonStyle {
    func unique() -> [Element] {
        return Array(Set(self))
    }
}
