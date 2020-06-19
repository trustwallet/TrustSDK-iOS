// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public struct TrustButtonTheme {
    let styles: [TrustButtonStyle]

    public init(styles: TrustButtonStyle...) {
        self.styles = styles
    }

    init(styles: [TrustButtonStyle]) {
        self.styles = styles
    }

    public func with(styles: TrustButtonStyle...) -> TrustButtonTheme {
        let current = self.styles.filter { !styles.contains($0) }
        return TrustButtonTheme(styles: current + styles)
    }

    public static let white = TrustButtonTheme(styles:
        .font(.systemFont(ofSize: 17, weight: .bold)),
        .tintColor(TrustSDK.Colors.blue, for: .normal),
        .tintColor(TrustSDK.Colors.blue, for: .highlighted),
        .backgroundColor(TrustSDK.Colors.white),
        .round(radius: 8.0)
    )

    public static let blue = TrustButtonTheme(styles:
        .font(.systemFont(ofSize: 17, weight: .bold)),
        .tintColor(TrustSDK.Colors.white, for: .normal),
        .tintColor(TrustSDK.Colors.white, for: .highlighted),
        .backgroundColor(TrustSDK.Colors.blue),
        .round(radius: 8.0)
    )
}

enum TrustButtonStyleName: String {
    case font
    case backgroundColor
    case tintColor
    case border
    case round
    case roundFull
}

public enum TrustButtonStyle {
    case backgroundColor(UIColor)
    case tintColor(UIColor, for: UIControl.State)
    case font(UIFont)
    case border(width: CGFloat, color: UIColor)
    case round(radius: CGFloat)
    case roundFull

    var name: TrustButtonStyleName {
        switch self {
        case .font: return .font
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
        switch (lhs, rhs) {
        case let (.tintColor(_, lhsState), .tintColor(_, rhsState)):
            return lhs.name == rhs.name && lhsState == rhsState
        default:
            return lhs.name == rhs.name
        }
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
