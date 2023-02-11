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

import TIUIKitCore
import UIKit

extension UILabel {
    open class BaseAppearance<Layout: ViewLayout>: UIView.BaseAppearance<Layout> {

        public var textAttributes: BaseTextAttributes?

        public init(layout: Layout = .defaultLayout,
                    backgroundColor: UIColor = .clear,
                    roundedCorners: CACornerMask = [],
                    cornerRadius: CGFloat = .zero,
                    shadow: UIViewShadow? = nil,
                    textAttributes: BaseTextAttributes? = nil) {

            self.textAttributes = textAttributes

            super.init(layout: layout,
                       backgroundColor: backgroundColor,
                       roundedCorners: roundedCorners,
                       cornerRadius: cornerRadius,
                       shadow: shadow)
        }
    }

    public final class DefaultAppearance: BaseAppearance<UIView.DefaultWrappedLayout>, WrappedViewAppearance {
        public static var defaultAppearance: DefaultAppearance {
            DefaultAppearance()
        }
    }
}
