# Single Touch Simulator

When you are giving demos or you need to record an animated gif, it can help if you set this flag on your iOS simulator to show a large circle everytime your touch.

Open a terminal and type:

```bash
defaults write com.apple.iphonesimulator ShowSingleTouches -bool YES
```

Note: You may need to restart Xcode and the iOS simuator before your will see this change take effect.

![Design Cell](https://github.com/jrasmusson/ios-starter-kit/blob/master/tips/SingleTouchSimulator/images/demo.gif)
