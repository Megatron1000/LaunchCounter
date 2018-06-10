# LaunchCounter

[![CI Status](https://img.shields.io/travis/megatron1000/LaunchCounter.svg?style=flat)](https://travis-ci.org/megatron1000/LaunchCounter)
[![Version](https://img.shields.io/cocoapods/v/LaunchCounter.svg?style=flat)](https://cocoapods.org/pods/LaunchCounter)
[![License](https://img.shields.io/cocoapods/l/LaunchCounter.svg?style=flat)](https://cocoapods.org/pods/LaunchCounter)
[![Platform](https://img.shields.io/cocoapods/p/LaunchCounter.svg?style=flat)](https://cocoapods.org/pods/LaunchCounter)

## Description 

A very simple mechanism for tracking the number of times your app has been launched. Useful for running certain activities the very first time the app is launched, for example.

## Example

In your app delegate

```    
let launchCounter = LaunchCounter()

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    // Record that the app was launched
    launchCounter.trackLaunch()

    if launchCounter.isFirstLaunch {
        // Do something only on first launch 
    }

    return true
}
```

launchCounter = LaunchCounter(userDefaults: userDefaults)


To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

LaunchCounter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LaunchCounter'
```

## Author

megatron1000, mark@bridgetech.io

## License

LaunchCounter is available under the MIT license. See the LICENSE file for more info.
