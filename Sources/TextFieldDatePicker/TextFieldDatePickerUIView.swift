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
    var datePickerMode: UIDatePicker.Mode = .date {
        didSet {
            picker.datePickerMode = datePickerMode
        }
    }
    var dateStyle: DateFormatter.Style = .medium
    var delegate: TextFieldDatePickerDelegate?
    var minimumDate: Date? = nil {
        didSet {
            picker.minimumDate = minimumDate
        }
    }
    var maximumDate: Date? = nil {
        didSet {
            picker.maximumDate = maximumDate
        }
    }
    var placeHolder: String? {
        didSet {
            textField.placeholder = placeHolder
        }
    }
    var selectionUpdateMode: TextFieldDatePickerSelectionUpdateMode = .onSelect

    private lazy var picker: UIDatePicker = {
        let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.datePickerMode = datePickerMode
        view.preferredDatePickerStyle = .wheels
        view.minimumDate = minimumDate
        view.maximumDate = maximumDate
        view.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        return view
    }()

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = true
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
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.picker(self, didSelectDate: picker.date)
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        textField.text = formatter.string(from: picker.date)
    }
}
