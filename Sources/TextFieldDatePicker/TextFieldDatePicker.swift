// The Swift Programming Language
// https://docs.swift.org/swift-book
//

//
//  TextFieldDatePicker.swift
//
//
//  Created by Daniel Eze on 2024-10-04.
//  Copyright © 2024 Daniel Eze. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.4, *)
public struct TextFieldDatePicker: UIViewRepresentable {
    @Binding private var date: Date?
    private var datePickerMode: UIDatePicker.Mode
    private var dateStyle: DateFormatter.Style
    private var minimumDate: Date?
    private var maximumDate: Date?
    private var placeHolder: String?
    private var selectionUpdateMode: TextFieldDatePickerSelectionUpdateMode

    public init(_ title: String, date: Binding<Date?>) {
        self.placeHolder = title
        self._date = date
        self.datePickerMode = .date
        self.dateStyle = .medium
        self.minimumDate = nil
        self.maximumDate = nil
        self.selectionUpdateMode = .onSelect
    }

    public init(_ title: String, date: Binding<Date?>, datePickerMode: UIDatePicker.Mode = .date, dateStyle: DateFormatter.Style = .medium, minimumDate: Date? = nil, maximumDate: Date? = nil) {
        self.placeHolder = title
        self._date = date
        self.datePickerMode = datePickerMode
        self.dateStyle = dateStyle
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.selectionUpdateMode = .onSelect
    }

    public func makeUIView(context: Context) -> TextFieldDatePickerUIView {
        let view = TextFieldDatePickerUIView()
        view.datePickerMode = datePickerMode
        view.dateStyle = dateStyle
        view.maximumDate = maximumDate
        view.minimumDate = minimumDate
        view.placeHolder = placeHolder
        view.delegate = context.coordinator
        return view
    }
    
    public func updateUIView(_ uiView: TextFieldDatePickerUIView, context: Context) {
        uiView.placeHolder = placeHolder
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

@available(iOS 13.4, *)
extension TextFieldDatePicker {
    /// Sets the selection update mode in this view.
    public func selectionUpdateMode(_ mode: TextFieldDatePickerSelectionUpdateMode) -> TextFieldDatePicker {
        var view = self
        view.selectionUpdateMode = mode
        return view
    }
}

@available(iOS 13.4, *)
extension TextFieldDatePicker {
    public class Coordinator: NSObject, TextFieldDatePickerDelegate {
        let view: TextFieldDatePicker

        init(_ view: TextFieldDatePicker) {
            self.view = view
        }

        public func picker(_ picker: TextFieldDatePickerUIView, didSelectDate date: Date) {
            view.date = date
        }
    }
}
