# DispatchGroup

Use `DispatchGroup` when you want a group of network calls to complete before proceeding. You can either `wait` for the tasks to complete.

```swift
func doLongTasksAndWait () {
    print("starting long running tasks")
    let group = DispatchGroup()          //create a group for a bunch of tasks we are about to do
    for i in 0...3 {                     //launch a bunch of tasks (eg a bunch of webservice calls that all need to be finished before proceeding to the next ViewController)
        group.enter()                    //let the group know that something is being added
        DispatchQueue.global().async {   //run tasks on a background thread
            sleep(arc4random() % 4)      //do some long task eg webservice or database lookup (here we are just sleeping for a random amount of time for demonstration purposes)
            print("long task \(i) done!")
            group.leave()                //let group know that the task is finished
        }
    }
    group.wait()                         //will block whatever thread we are on here until all the above tasks have finished (so maybe dont use this function on your main thread)
    print("all tasks done!")
}
```

Or be notified.

```swift
group.notify(queue: DispatchQueue.main) { //the queue: parameter is which queue this block will run on, if you need to do UI updates, use the main queue
    print("all tasks done!")              //this will execute when all tasks have left the group
}
```

Sample output.

```
starting long running tasks
long task 0 done!
long task 3 done!
long task 1 done!
long task 2 done!
all tasks done!
```



### Links that help

- [Simple example](https://riptutorial.com/ios/example/28278/dispatch-group)
- [Good video](https://www.youtube.com/watch?v=OanfpW0H_ok&ab_channel=maxcodes)