
# TextFieldDatePicker

A SwiftUI package that provides a TextField with a DatePicker as its input view. The date picker replaces the keyboard as the input view for the TextField.

https://github.com/user-attachments/assets/2fe97c88-ad90-410d-98ad-c26de94529e1

## Requirements

- iOS 13.4+
- macOS 10.13+
- Swift 5.0+
## Installation

### Swift Package Manager

To add TextFieldDatePicker to your Xcode project:

1. In Xcode, open your project and select **File** > **Add Packages**.
2. Paste the repository URL: https://github.com/dan-codes1/TextFieldDatePicker.
3. Choose the package options and add it to your target.

## Usage

Here is a simple example:
```swift
struct ContentView: View {
    @State private var date: Date?

    var body: some View {
        TextFieldDatePicker("Select date", date: $date)
    }
}
```

## Contribution
Contributions are welcome! Please open an issue or submit a pull request if you would like to contribute to the project.

## See Also
[TextFieldPicker](https://github.com/dan-codes1/TextFieldDatePicker) is a similar package but for custom types. Check it out!
