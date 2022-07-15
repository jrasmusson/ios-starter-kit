# How to Rails iOS


## Rails

```swift
> rails new posts
> rails g scaffold Post title:string
> rake db:migrate
> rails server
```

## Turn off CSRF verification

```swift
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end
```

## iOS

## Enable localhost calls

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/localhost-plist.png" alt="drawing" width="409"/>

## Make network calls

Call like this

```swift
Alamofire.request("http://localhost:3000/devices.json", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in

            if let json = response.result.value {
                print("fetchAll: \(json)")
            }

}
```        

### Links that help

* [Rails authentication token](https://www.joshqn.com/consuming-a-rails-api-using-alamofire/)
* [Turn off CSRF Verification](https://teamtreehouse.com/library/build-a-rails-api/coding-the-api/rails-api-csrf-verification)
