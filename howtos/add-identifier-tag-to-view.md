# How to add identifier or tag to view

This is can be useful for debugging purposes.

```swift
NSLayoutConstraint.activate([

let constraint = advanceDetailsTappableTextView.topAnchor.constraint(equalTo: stackView.bottomAnchor);
constraint.identifier = "something"; return constraint }(),

            advanceDetailsTappableTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            advanceDetailsTappableTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            advanceDetailsTappableTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
])
```
To do this on a generic `UIView` set the view's tag

```swift
stackView.tag = 99
```
