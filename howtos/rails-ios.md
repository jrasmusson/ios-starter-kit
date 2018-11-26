# How to Rails iOS

Install Rails
Build Rails App

```swift
rails new app
git checkout-index -a -f --prefix=/Users/jrasmusson/Downloads/temp/

// Copy into real directory

rails g scaffold Device status:string
rake db:migrate
```

Turn off CSRF verification

```swift
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end
```

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
