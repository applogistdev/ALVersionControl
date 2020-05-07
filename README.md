# ALVersionControl

[![CI Status](https://img.shields.io/travis/sonifex/ALVersionControl.svg?style=flat)](https://travis-ci.org/sonifex/ALVersionControl)
[![Version](https://img.shields.io/cocoapods/v/ALVersionControl.svg?style=flat)](https://cocoapods.org/pods/ALVersionControl)
[![License](https://img.shields.io/cocoapods/l/ALVersionControl.svg?style=flat)](https://cocoapods.org/pods/ALVersionControl)
[![Platform](https://img.shields.io/cocoapods/p/ALVersionControl.svg?style=flat)](https://cocoapods.org/pods/ALVersionControl)




ALVersionControl is an application update process controller.   There are 3 types of update status which described below.
AlVersionControl does not provide any api call. You have to make it in own way.


### Version Control API structure

#### Request: 
ALVersionControl has handy request model called **ALVersionControlRequest** which has only 2 variable. You may use it in your api call. You have to store latest versions on your server database for both iOS and Android.

```swift
public  struct  ALVersionControlRequest: Encodable {

    ///  OS Type (1:iOS - 2:Android)
    let os: Int
    ///  App bundle version (e.g. 1.0.2)
    let version: String

    public  init() {
        self.os = 1
        self.version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
``` 
Json
```json
{
    "os": 1,
    "version": "1.0.2"
}
```



#### Response
ALVersionControl has response model called **ALVersionControlResponse** which you have to use in order to us handle controlling process. You may use your own model, but you have to convert it to this model in "versionControllerAPIHandler" method to pass through completion.

```swift
public  enum  ALVersionControlStatus: Int, Codable {

    ///  All good. App is up to date
    case upToDate = 0
    ///  Optional update available
    case optional = 1
    ///  Force update available
    case force = 2
}

public  struct  ALVersionControlResponse: Decodable {
    
    ///  The info message which inform to user there is a new update.
    let message: String?
    ///  The status of new update.
    let status: ALVersionControlStatus?
    ///  The market url which lead the user to update the app
    let url: URL?

    public init(message: String?, status: ALVersionControlStatus?, url: URL?) {
        self.message = message
        self.status = status
        self.url = url
    }
}
```
Json
```json
{
    "message": "Hey! You have a new update.",
    "status": 1,
    "url": "app market url"
}
```

1. **Up to date [0]** : So there is no update. All is good.
2. **Optional Update [1]** : To inform users there is a new update and user may update the app. Once user dismiss the alert, we will not bother again.
3. **Force Update [2]** : User must update the application in order to keep using the app. Hopefully never use it.




## Usage

Setup 
```swift
ALVersionControl.shared.setup(delegate: self)
```

You have to handle applicationDidBecomeActive status. Just calling the appDidBecomeActive method is enough.
```swift
func  applicationDidBecomeActive(_ application: UIApplication) {
    ALVersionControl.shared.appDidBecomeActive()
}
```

## Language Support

Turkish, English, Arabic

*Feel free to add more. Pull requests are welcome :)*


## Installation

### Swift Package Manager

Once you have your Swift package set up, adding `ALVersionControl` as a dependency is as easy as adding it to the dependencies value of your `Package.swift`.

```swift
dependencies: [
.package(url: "https://github.com/applogistdev/ALVersionControl.git", from: "0.2.0")
]
```

### CocoaPods

To integrate `ALVersionControl` into your Xcode project using [CocoaPods](http://cocoapods.org), specify it in your `Podfile`

```ruby
pod 'ALVersionControl'
```

## Author

sonifex, sonerguler93@gmail.com

## License

ALVersionControl is available under the MIT license. See the LICENSE file for more info.
