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
        .title(font: .systemFont(ofSize: 18, weight: .regular), icon: .shieldLined),
        .tintColor(TrustSDK.Colors.blue),
        .backgroundColor(TrustSDK.Colors.white),
        .border(width: 1, color: TrustSDK.Colors.blue),
        .round(radius: 8.0)
    )

    public static let blue = TrustButtonTheme(
        .title(font: .systemFont(ofSize: 18, weight: .regular), icon: .shieldLined),
        .tintColor(TrustSDK.Colors.white),
        .backgroundColor(TrustSDK.Colors.blue),
        .round(radius: 8.0)
    )

    public static let black = TrustButtonTheme(
        .title(font: .systemFont(ofSize: 18, weight: .regular), icon: .shieldLined),
        .tintColor(TrustSDK.Colors.white),
        .backgroundColor(TrustSDK.Colors.black),
        .border(width: 1, color: TrustSDK.Colors.white),
        .round(radius: 8.0)
    )
}

enum TrustButtonStyleName: String {
    case title
    case backgroundColor
    case tintColor
    case border
    case round
    case roundFull
}

public enum TrustButtonStyle {
    case backgroundColor(UIColor)
    case tintColor(UIColor)
    case title(font: UIFont, icon: TrustSDK.Icon)
    case border(width: CGFloat, color: UIColor)
    case round(radius: CGFloat)
    case roundFull

    var name: TrustButtonStyleName {
        switch self {
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
