# Defining Asynchronous Functions

Asynchronous functions are special kinds of functions that can be suspended partway through execution.

Normal functions run to completion, throw an error, or never return. Asychronous functions still do one of those things, but can be paused in the middle while waiting for something.

To indicate function is asynchronous, you write the `async` keyword in its declaration after its parameters, similar to how you use `throws`. If function returns, you write `async` before return arrow.

```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... some asynchronous networking code ...
    return result
}
```

If function is asynchronous and throws, write `async` before `throws`.

When calling an asynchronous method, execution suspends until that method returns. You write `await` in from of the call to mark the possible suspension point. Like `try` in a throwing function.

Inside an asynchronous method, the flow of execution is suspended *only* when you call another asynchronous method - suspension is never implicit or preemptive - which means every possible suspension point is marked with `await`.

For example, the code below fetches the names of all the pictures in a gallery and then shows the first picture:

```swift
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
```

Because list and download could take a long time, making them both asynchronous by writing `async` before the return arrow lets the rest of the app's code keep running while this code waits for the picture to be ready.

> NOTE
> 
> The Task.sleep(until:clock:) method is useful when writing simple code to learn how concurrency works. This method does nothing, but waits at least the given number of nanoseconds before it returns. Here’s a version of the listPhotos(inGallery:) function that uses sleep(until:clock:) to simulate waiting for a network operation:

```swift
func listPhotos(inGallery name: String) async throws -> [String]  {
    try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
    return ["IMG001", "IMG99", "IMG0404"]
}
```

## Calling Asynchronous Functions in Parallel

Calling an asynchronous function with `await` runs only one piece of code at a time. While the asynchronous code is running, the caller waits for that code to finish before moving on to run the next line of code.

For exampe, to fetch the first three photos from a gallery, you could await three calls like this:

```swift
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

This approach has an important drawback: Although the download is asynchronous and lets other work happen while it progresses, only one call runs at a time. Each photo downloads completely before the next one starts.

However, there's no need to wait for these operations to complete - each photo can download independently, or even as the same time.

To call an asynchronous function and let it run in parallel with code around it, write `async` in from of `let` when you define a constant, and then write `await` each time you use the constant:

```swift
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

# Tasks and Task Groups

A *task* is a unit of work that can be run aysnchronously as part of your program. All asynchronous code runs as part of some task. The `async-let` syntax described previously creates a child task for you. You can also create a task group and add child tasks to that group, which gives you more control over priority and cancellation, and lets you create a dynamic number of tasks.

Tasks are arranges in a hierarchy. Each task in a tack group has the same parent task, and each tack can have hild tasks. Because of the xplicit relationship between tasks and task groups, this approach is called *structured concurrency*. Although you take on some of the responsibility for correctivess, the explicit parent -child relationships between taskss lets Swift handle some behaviors like propograting cancellation for you, and lets Swift detect some errors at complile time.

```swift
await withTaskGroup(of: Data.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.addTask { await downloadPhoto(named: name) }
    }
}
```

For more information see [TaskGroup](https://developer.apple.com/documentation/swift/taskgroup).

## Actors

Tasks are isolated from each other, but sometimes you need to share information between them. This is where Actors come in.

Like classes, actors are reference types. Unlike classes, actors allow only one task to access their mutable state at a time, which makes it safe for code in multiple tasks to inceract with the same instance of an actor.

For example here's an actor the records temperatures:

```swift
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
```

Because `max` is a part of the actor, you need to write `await` before accessing:

```swift
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)
```

If you try this, you will get a complile time error:

```swift
print(logger.max)  // Error
```

# Sendable Types

Simple data types can be shared between tasks and actors, because it can simply be copied. But some kinds of data can't - because it contains mutable state.

A type that can be shared from one concurrency domain to another is known as a *sendable* type. Classes tha contain mutalbe properties, don't serialize access to those properties can produce unpredicable and incorrect results when passed between different tasks.

To address this we have `Sendable`. Sendable doesn't have any code requirements, but it does have semantic requirements that Swift enforces. In general, there are three ways for a type to be sendable:

- The type is a value type, and it's mutable state is made up of other sendable data
- The type has no mutalbe state
- The type is a class marked with `@MainActor` that serializes access to its properties on a particular thread or queue.

Some types are always sendable, like simple structs.

```swift
struct TemperatureReading: Sendable {
    var measurement: Int
}
```

Here the conformance to `Sendable` is implied and the protocol isn't even needed:

```swift
struct TemperatureReading {
    var measurement: Int
}
```


### Links that help

- [Swift Docs](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
