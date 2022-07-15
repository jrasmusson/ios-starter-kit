# How to Rails iOS

-[Getting started](https://guides.rubyonrails.org/getting_started.html)

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

## Curl commands

```
curl -X GET http://localhost:3000/posts
curl -X POST -d "post[title]=222" http://localhost:3000/posts
curl -X DELETE http://localhost:3000/posts/5
curl -X PUT -d "post[title]=888" http://localhost:3000/posts/8
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
