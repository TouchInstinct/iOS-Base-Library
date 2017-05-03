//
//  Copyright (c) 2017 Touch Instinct
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

/// Type that performs some kind of type erasure for LoadingIndicator.
public struct AnyLoadingIndicator: Animatable {

    private let internalView: UIView
    private let animatableView: Animatable

    /// Initializer with indicator that should be wrapped.
    ///
    /// - Parameter _: indicator for wrapping.
    public init<Indicator>(_ base: Indicator) where Indicator: LoadingIndicator {
        self.internalView = base.view
        self.animatableView = base.view
    }

    /// The indicator view.
    var view: UIView {
        return internalView
    }

    public func startAnimating() {
        animatableView.startAnimating()
    }

    public func stopAnimating() {
        animatableView.stopAnimating()
    }

}
