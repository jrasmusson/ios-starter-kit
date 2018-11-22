# Generics

## Example

This example shows how to define a generic that takes any `Codable` as a type and then decode it's when parsing JSON `decoder.decode(T.self)`.

```swift
struct Service {

    static let sharedInstance = Service()

    func fetchUser(completion: @escaping (User?, Error?) -> () ) {

        Alamofire.request("https://yyy", method: .get, encoding: JSONEncoding.default, headers: headers).responseData { response in

            self.handle(response: response, completion: completion)
        }
    }

    func fetchCreditCardToken(completion: @escaping (CreditCardToken?, Error?) -> () ) {

        Alamofire.request("https://xxx", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in

            self.handle(response: response, completion: completion)
        }
    }
    
        func handle<T: Codable>(response: DataResponse<Data>, completion: @escaping (T?, Error?) -> ()) {
        switch response.result {
        case .success:

            guard let jsonData = response.result.value else {
                completion(nil, ServiceError.noData)
                return
            }

            let decoder = JSONDecoder()
            do {
                let tweets = try decoder.decode(T.self, from: jsonData)
                completion(tweets, nil)
            } catch {
                completion(nil, ServiceError.parsingJSON)
            }

        case .failure(let error):
            completion(nil, error)
        }
    }
    
    
}
```

