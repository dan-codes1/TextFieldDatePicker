//
//  File.swift
//  
//
//  Created by Daniel Eze on 2024-10-04.
//  Copyright © 2024 Daniel Eze. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.4, *)
public final class TextFieldDatePickerUIView: UIView {
    public var datePickerMode: UIDatePicker.Mode = .date {
        didSet {
            picker.datePickerMode = datePickerMode
        }
    }
    public var dateStyle: DateFormatter.Style = .medium
    public var delegate: TextFieldDatePickerDelegate?
    public var initialDate: Date? {
        didSet {
            if let initialDate {
                let formatter = DateFormatter()
                formatter.dateStyle = dateStyle
                picker.date = initialDate
                textField.text = formatter.string(from: initialDate)
            }
        }
    }
    public var minimumDate: Date? = nil {
        didSet {
            picker.minimumDate = minimumDate
        }
    }
    public var maximumDate: Date? = nil {
        didSet {
            picker.maximumDate = maximumDate
        }
    }
    public var placeHolder: String? {
        didSet {
            textField.placeholder = placeHolder
        }
    }
    public var selectionUpdateMode: TextFieldDatePickerSelectionUpdateMode = .onSelect
    private var isIntialSelection: Bool = true

    private lazy var picker: UIDatePicker = {
        let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.datePickerMode = datePickerMode
        view.preferredDatePickerStyle = .wheels
        view.minimumDate = minimumDate
        view.maximumDate = maximumDate
        view.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        return view
    }()

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        field.placeholder = placeHolder
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(removePicker))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        field.inputAccessoryView = toolbar
        return field
    }()

    public init() {
        super.init(frame: .zero)
        self.configure()
        self.layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 13.4, *)
private extension TextFieldDatePickerUIView {
    func configure() {
        textField.inputView = picker
    }
    
    func layout() {
        addSubview(textField)
        let constraints: [NSLayoutConstraint] = [
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc func dateChanged(_ picker: UIDatePicker) {
        if selectionUpdateMode == .onSelect {
            delegate?.picker(self, didSelectDate: picker.date)
        }
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        textField.text = formatter.string(from: picker.date)
    }

    @objc func removePicker() {
        endEditing(true)
    }
}

@available(iOS 13.4, *)
extension TextFieldDatePickerUIView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if isIntialSelection && initialDate == nil {
            let formatter = DateFormatter()
            formatter.dateStyle = dateStyle
            textField.text = formatter.string(from: picker.date)
            isIntialSelection = false
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.picker(self, didSelectDate: picker.date)
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        textField.text = formatter.string(from: picker.date)
    }
}
