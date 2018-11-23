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

### Exporting

Putting your existing instance of vapor under source control is a bit weird because it comes already setup in an instance of git. Worse than that however is the project doesn't like version controlling project files. You need to regenerate these yourself.

To export your instance of vapor and to put it in version control somewhere else do the following.

Goto the directory where you setup and run vapor.

Export it from git to a temp dir

`git checkout-index -a -f --prefix=/Users/jrasmusson/Downloads/temp/`

Goto that git directory and run the following commands

```bash
vapor build
vapor run
vapor xcode
```

You will now have a running setup instance of your vapor project with xcode. Feel free to version control everything from there.







