# Access Control

```swift
// most open
open        class UITableView {}
public      protocol UITableViewDataSource {}
internal    class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private     class SomePrivateClass {}
// most closed
```

- Default is internal
- Open access is least restrictive. Private is most.

```swift
class SomeInternalClass {}              // implicitly internal
let someInternalConstant = 0            // implicitly internal
```

### open & public

Open access and public access enable entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module. You typically use open or public access when specifying the public interface to a framework

#### Diffrence between open & public?

* Public classs / methods can only be subclassed / overridden within the module they are defined.
* Open classes / methods can be subclassed / overriden within any module that imports them
* So open is beyond the module. Public is more restrictive as it's within.

#### internal

* enabled entities within the module to extend / override but not those without. Use internal when defining an apps internal structure.

#### file private

* limits extending / overriding to that file

#### private

* restricts use to that closing declaration and to extensions that are in the same file



Public - anyone can use
Internal - within that module (default)
File-private - within that file
Private - the classes and sub entities



### Links that help

* [Swift Lanaguage Guide - Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)

