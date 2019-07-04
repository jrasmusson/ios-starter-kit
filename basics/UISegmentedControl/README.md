# UISegmentedControl

## Example

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UISegmentedControl/images/example.png" alt="drawing" width="400"/>

```swift
let employeeTypeSegmentedControl: UISegmentedControl = {
    let types = ["Executive", "Senior Management", "Staff"]
    let sc = UISegmentedControl(items: types)
    sc.translatesAutoresizingMaskIntoConstraints = false
    sc.selectedSegmentIndex = 0
    sc.tintColor = UIColor.darkBlue

    return sc
}()
```

Usage

```swift
guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else { return }

```
