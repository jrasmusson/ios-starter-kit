# Map, Filter, Reduce

## Map

### How to map instead of for loop

Instead of 

            var users = [User]()

            for userJson in usersJsonArray! {
                let user = User(json: userJson)

                users.append(user)
            }

Go

	    let users = usersJsonArray!.map { User(json: $0) }


Map takes each element in the collection, and lets you do something to it in the brackets. Think of it as taking the for loop, scrunching the brackets onto one line, and letting you do your magic there.
