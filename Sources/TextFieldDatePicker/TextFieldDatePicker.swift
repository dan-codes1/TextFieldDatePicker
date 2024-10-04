// The Swift Programming Language
// https://docs.swift.org/swift-book
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
struct TextFieldDatePicker: UIViewRepresentable {
    @Binding var date: Date?
    private var datePickerMode: UIDatePicker.Mode = .date
    private var dateStyle: DateFormatter.Style = .medium
    private var minimumDate: Date? = nil
    private var maximumDate: Date? = nil
    private var placeHolder: String?

    init(_ title: String, date: Binding<Date?>, datePickerMode: UIDatePicker.Mode, dateStyle: DateFormatter.Style, minimumDate: Date? = nil, maximumDate: Date? = nil) {
        self.placeHolder = title
        self._date = date
        self.datePickerMode = datePickerMode
        self.dateStyle = dateStyle
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
    }

    func makeUIView(context: Context) -> TextFieldDatePickerUIView {
        let view = TextFieldDatePickerUIView()
        view.dateStyle = dateStyle
        view.datePickerMode = datePickerMode
        view.minimumDate = minimumDate
        view.maximumDate = maximumDate
        view.placeHolder = placeHolder
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: TextFieldDatePickerUIView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

@available(iOS 13.4, *)
extension TextFieldDatePicker {
    class Coordinator: NSObject, TextFieldDatePickerDelegate {
        let view: TextFieldDatePicker

        init(_ view: TextFieldDatePicker) {
            self.view = view
        }

        func picker(_ picker: TextFieldDatePickerUIView, didSelectDate date: Date) {
            view.date = date
        }
    }
}
