# Swift [OpenCage](https://opencagedata.com/) data API client library, "Convert coordinates to and from places".

**OpenCageSwift** is a small Swift library to connect to the [OpenCage](https://opencagedata.com/) and retrieve the forward and reverse geocoding data. Made easy to use with **SwiftUI**. 

**OpenCageSwift** only caters for JSON responses from the API.
   
                                                                        
                                                                        
### Usage

OpenCage data is accessed through the use of a **OCProvider**, with simple functions, for example:

```swift
let ocProvider = OCProviderJson(apiKey: "your key")
@State private var response: OCResponse = OCResponse()
...

Alternatively;

let ocProvider = OCProviderJson(apiKey: "your key", urlString: "https://api.opencagedata.com/geocode/v1")
                                                                        

// using a binding
ocProvider.reverseGeocode(lat: latitude, lon: longitude, response: $response, options: OCOptions())
...


// or using the async style, eg with `.task {...}`
if let results = await ocProvider.reverseGeocode(lat: latitude, lon: longitude, options: OCOptions()) {
    ....
}

// or using the callback style, eg with `.onAppear {...}`
ocProvider.reverseGeocode(lat: latitude, lon: longitude, options: OCOptions()) { response in
       if let theResponse = response {
           ....
       }
}
```

See the following for example uses:

-   [*OpenCageSwiftExample*](https://github.com/workingDog/OpenCageSwiftExample)


### Options

Options available:

-   see [OpenCage API](https://opencagedata.com/api#optional-params) for all the options available.

### Installation

Include the files in the **./Sources/OpenCageSwift** folder into your project or preferably use **Swift Package Manager**.

#### Swift Package Manager (SPM)

Create a Package.swift file for your project and add a dependency to:

```swift
dependencies: [
  .package(url: "https://github.com/workingDog/OpenCageSwift.git", from: "1.0.0")
]
```

#### Using Xcode

    Select your project > Swift Packages > Add Package Dependency...
    https://github.com/workingDog/OpenCageSwift.git

Then in your code:

```swift
import OpenCageSwift
```
    
### References

-    [OpenCage Data API](https://opencagedata.com/api)


### Requirement

Requires a valid OpenCage key, see:

-    [OpenCage Quick Start](https://opencagedata.com/api#quickstart)

### License

MIT

