# OpenCage data API Swift client library, "Convert coordinates to and from places"

**OpenCageSwift** is a small Swift library to connect to the [OpenCage](https://opencagedata.com/) server and retrieve the forward and reverse geocoding data.
          
**OpenCageSwift** caters for JSON and some support for GeoJSON responses.        
          
                                                                    
### Usage

**OpenCageSwift** is made easy to use with **SwiftUI**. 
It can be used with the following OS: 

- iOS 17.0+
- iPadOS 17.0+
- macOS 14.0+
- Mac Catalyst 17.0+
- tvOS 17.0+
- visionOS 1.0+
- watchOS 10.0+

#### Examples

[OpenCage](https://opencagedata.com/) data can be accessed through the use of a **OCProviderJson**, with simple functions.

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

#### SwiftUI with data model

Using the @Observable data model **OCDataModelJson**


```swift
struct ContentView: View {
    let dataModel = OCDataModelJson(apiKey: "YOUR-KEY")

    var body: some View {
        VStack {
            if dataModel.isLoading {
                ProgressView()
            }
            Map {
                ForEach(dataModel.response.results) { result in
                    if let coord = result.geometry?.asCoordinate() {
                        Marker(result.formatted ?? "", systemImage: "globe", coordinate: coord)
                    }
                }
            }
            .mapStyle(.standard)
            .mapControlVisibility(.automatic)
        }
        .task {
            dataModel.isLoading = true
            await dataModel.forwardGeocode(address: "Sydney, Australia", options: OCOptions())
            dataModel.isLoading = false
        }
    }
  
}
```


### Options

Options available:

-   see [OpenCage API](https://opencagedata.com/api#optional-params) for all the options available.

### Installation

Include the files in the **./Sources/OpenCageSwift** folder into your project or preferably use **Swift Package Manager**.

#### Swift Package Manager (SPM)

Create a Package.swift file for your project and add a dependency to:

```swift
dependencies: [
  .package(url: "https://github.com/workingDog/OpenCageSwift.git", branch: "main")
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

