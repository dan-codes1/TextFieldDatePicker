//
//  File.swift
//  
//
//  Created by Daniel Eze on 2024-10-04.
//  Copyright © 2024 Daniel Eze. All rights reserved.
//

import Foundation

@available(iOS 13.4, *)
public protocol TextFieldDatePickerDelegate {
    /// Informs the delegate that an item has been selected.
    /// - Note: This informs the delegate based on the `TextFieldDatePickerSelectionUpdateMode` of the picker.
    /// - Parameters:
    ///     - picker: The picker view.
    ///     - date: the selected date.
    func picker(_ picker: TextFieldDatePickerUIView, didSelectDate date: Date)
}
