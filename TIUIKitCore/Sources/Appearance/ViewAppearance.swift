//
//  Copyright (c) 2023 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public protocol ViewAppearance {
    associatedtype Layout: ViewLayout

    static var defaultAppearance: Self { get }

    var layout: Layout { get }
    var backgroundColor: UIColor { get }
    var roundedCorners: CACornerMask { get }
    var cornerRadius: CGFloat { get }
    var shadow: UIViewShadow? { get }
}

// MARK: - ViewAppearance Variations

public protocol WrappedViewAppearance: ViewAppearance where Layout: WrappedViewLayout {}

public protocol WrappedViewHolderAppearance: ViewAppearance {
    associatedtype SubviewAppearance: WrappedViewAppearance

    var subviewAppearance: SubviewAppearance { get }
}

// MARK: - Creation methods

extension ViewAppearance {
    public static func make(builder: (Self) -> Void) -> Self {
        let appearance = Self.defaultAppearance
        builder(appearance)
        return appearance
    }

    public static func callAsFunction(builder: (Self) -> Void) -> Self {
        let appearance = Self.defaultAppearance
        builder(appearance)
        return appearance
    }

    @discardableResult
    public func update(builder: (Self) -> Void) -> Self {
        builder(self)
        return self
    }

    @discardableResult
    public func callAsFunction(builder: (Self) -> Void) -> Self {
        builder(self)
        return self
    }
}
