# Vapor

Here is how you setup Vapor

```swift
brew install vapor/tap/vapor
vapor new Hello
cd Hello
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
vapor xcode
```

## Trouble Shooing

### App Transport Security has blocked a cleartext HTTP (http://)

You need to allow unsecure requests from your application making the request to Vapor server. Add the following to your info.plist file.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/vapor.unsecure-plist.png" alt="drawing" width="409"/>






