# How to Xcode command line

## Run tests

Create a make file and stick this in it

```swift
test:
	xcodebuild -workspace ShawSelfServe.xcworkspace -scheme ShawSelfServe -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 5s,OS=12.2' test | xcpretty --color

test-find-long-tests:
	xcodebuild -workspace ShawSelfServe.xcworkspace -scheme ShawSelfServe -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 5s,OS=12.2' test | xcpretty --color | grep "0\.1\|0\.2\|0\.3\|0\.4\|0\.5\|0\.6\|0\.7\|0\.8\|0\.9\|1\.\|2\.\|3\.\|4\."
```