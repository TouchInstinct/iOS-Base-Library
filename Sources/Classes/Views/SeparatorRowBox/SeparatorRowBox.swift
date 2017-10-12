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

import TableKit

/// Class that used to configure separators when multiply cells presented in one section
/// Holds TableRow<T> with any model inherited from BaseCellViewModel
public final class SeparatorRowBox {
    /// Row `item`, that typed as BaseCellViewModel
    public let viewModel: SeparatorCellViewModel

    /// TableRow that typed to generic Row
    public let row: Row

    /// Initialize AnyBaseTableRow with tableRow
    /// - parameter tableRow: TableRow which `item` conforms to BaseCellViewModel
    public init<T>(tableRow: TableRow<T>) where T: SeparatorCell, T.T: SeparatorCellViewModel {
        row = tableRow
        viewModel = tableRow.item
    }

}