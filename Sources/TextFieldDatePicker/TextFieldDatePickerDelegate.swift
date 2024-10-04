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
    func picker(_ picker: TextFieldDatePickerUIView, didSelectDate date: Date)
}
