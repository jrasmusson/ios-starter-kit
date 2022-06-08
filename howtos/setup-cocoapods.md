# How to setup / install cocopods

## Update

```bash
> pod install --repo-update
```

## Setup

```bash
> sudo gem install cocoapods
> cd <project>
> pod init
> vi Podfile
> pod install

```
Close project.
Reopen with workspace file.
Use.


## Command line search

How to search for pod from command line (better than web)

```bash
> pod repo update
> pod search firebase
- pod  'AppDynamicsAgent', '~> 2020.3.0'
> pod install
```

   > Note: If you pod isnt found and it comes from custom repos run `pod repo update`.

### Links

- [Cocoa Pods Getting Started](https://guides.cocoapods.org/using/getting-started.html#getting-started)
