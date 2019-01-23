# BAindicator

## Information
Activity Indicator follow Bosch UI Design Guidline

## Requirements
- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 10.1+
- Swift 4.2+

## Installation
```ruby
pod 'BAIndicator', :git => 'https://github.com/kisimita/baindicator.git'
pod install
```
## Usage
Swift 4
```ruby
let baIndicator = BAIndicator(frame: CGRect(x: self.view.frame.size.width/2 - width/2, y: self.view.frame.size.height/2 - height/2, width: width, height: height), speed: .Fast)
self.view.addSubview(baIndicator)
baIndicator.startAmination()
```
## License
BAIndicator is released under the MIT license.
