# How to curl alamofire

```swift
let request = Alamofire.request("\(url)", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in

}

print("Request: \(request.debugDescription)")
```

Will print out a full curl command containing all the parameters and everything else.

```swift
curl -v \
	-H "Accept-Language: en;q=1.0" \
```