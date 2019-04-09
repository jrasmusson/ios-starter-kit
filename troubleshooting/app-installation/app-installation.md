# App Installation

Sometimes Xcode just doesn't want to behave and when you go to install your appliction on a physical device, you get cryptic error messages like this.

![Could not write to device](https://github.com/jrasmusson/ios-starter-kit/blob/master/troubleshooting/app-installation/images/could-not-write-to-device.png)

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/troubleshooting/app-installation/images/provisioning-profile-not-found.png" alt="demo" width="400px"/>

![Unknown error](https://github.com/jrasmusson/ios-starter-kit/blob/master/troubleshooting/app-installation/images/unknown-error.png)

Here are some trouble shooting things to try when you are having app installation challenges.

- delete app from device
- full clean (Shift + Command + K)
- reboot phone
- reboot computer
- [clear derived data](https://agilewarrior.wordpress.com/2017/02/23/how-to-quickly-clear-derived-data/)
- [check device logs](https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/howto-devicelogs.md)
- [delete provisioning profiles](https://github.com/jrasmusson/ios-starter-kit/blob/master/tips/howto-delete-provisioning-profiles.md)
- check and ensure that you haven't let *Charles* manual wifi turned on


## How to speed up build

You can speed up your build by compiling only for the current architecture and setting clang and swift optimization levels to none.

```swift
post_install do |installer|

  installer.pods_project.build_configurations.each do |config|

    # make compile fast...
    if config.name.include?("Mock-API")
      config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
    end

  end

end
```
