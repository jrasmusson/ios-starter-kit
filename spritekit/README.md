# SpriteKit

## New Project

Delete GameScene.sks / Action.sks

```swift
import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

class GameScene: SKScene {
        
    let redBox = SKSpriteNode(color: .systemRed, size: CGSize(width: 400, height: 800))
    
    override func didMove(to view: SKView) {
        addChild(redBox)        
        redBox.position = CGPoint(x: frame.midX, y: frame.midY)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { 
}
```

## Position

### Upperright

```swift
import SpriteKit

class GameScene: SKScene {
        
    let redBox = SKSpriteNode(color: .systemRed, size: CGSize(width: 400, height: 800))
    let ship = SKSpriteNode(imageNamed: "ship")
    
    override func didMove(to view: SKView) {
        addChild(redBox)
        redBox.addChild(ship)
        
        redBox.position = CGPoint(x: frame.midX, y: frame.midY)
        ship.size = CGSize(width: 100, height: 100)
        
        // ship starts off in middle of screen
        
        // upper right
        let upperRightX = CGFloat(400 - 100)/2 // (redWidth - shipWidth)/2
        let upperRightY = CGFloat(800 - 100)/2 // (redHeight - shipHeight)/2
        let upperRightPoint = CGPoint(x: 150, y: 350)
        ship.position = upperRightPoint
    }
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // move to lower right
//        let lowerLeftX = CGFloat(400 - 100)/2
//        let lowerLeftY = CGFloat(800 - 100)/2
//        ship.run(SKAction.move(to: CGPoint(x: -lowerLeftX, y: -lowerLeftY), duration: 1))
//
//        ship.run(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1))

        // action with completion handlers (reset position)
//        ship.run(SKAction.move(to: CGPoint(x: 150, y: 350), duration: 1)) {
//            self.ship.run(SKAction.move(to: CGPoint(x: -150, y: -350), duration: 1))
//        }
        
        // infinite loop
//        ship.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 2)))
        
        // remove action from Node

        // this is a handy way to prevent actions from piling up, and clearing them (one at a time - start/stop)
//        if !ship.hasActions() {
//            ship.run(SKAction.group([
//                SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 2),
//                SKAction.scale(by: 0.9, duration: 2.0)
//            ]))
//            ship.run(SKAction.sequence([
//                SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 2),
//                SKAction.scale(by: 0.9, duration: 2.0)
//            ]))
//
//        } else {
//            ship.removeAllActions()
//        }

        // key on creation - if action there remove it, else add it
//        if let _ = ship.action(forKey: "rotation") {
//            ship.removeAction(forKey: "rotation")
//        } else {
//            ship.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 2)), withKey: "rotation")
//        }
        
    }
```

## Physics

```swift
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // edge based
        ship.physicsBody = SKPhysicsBody(circleOfRadius: ship.size.width/2) // volume based
        
        // so these two lines here give our scene an edge which prevents space ship from falling through
        
        physicsWorld.gravity = CGVector(dx: -1.0, dy: -2.0) // set gravity for world
        
        ship.physicsBody!.allowsRotation = false
        ship.physicsBody!.restitution = 1.0
```

## Animation

Assert Catalogue > New Sprite Atlas

```swift
import SpriteKit
import GameplayKit

class GameScene: SKScene {
        
    let dog = SKSpriteNode(imageNamed: "Run0")
    var dogFrames = [SKTexture]()
    
    override func didMove(to view: SKView) {
        addChild(dog)
        dog.position = CGPoint(x: frame.midX, y: frame.midY)

        let textureAtlas = SKTextureAtlas(named: "Dog")
        for index in 0..<textureAtlas.textureNames.count {
            let name = "Run" + String(index)
            dogFrames.append(textureAtlas.textureNamed(name))
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dog.run(SKAction.repeatForever(SKAction.animate(with: dogFrames, timePerFrame: 0.1)))
    }
}
```

## Update Loop

This gets run x60/s.

```swift
    // Update loop
    
    override func update(_ currentTime: TimeInterval) {
        print(1)
    }
    
    override func didEvaluateActions() {
        print(2) // physics gets added
    }
    
    override func didSimulatePhysics() {
        print(3)
    }
    
    override func didApplyConstraints() {
        print(4)
    }
    
    override func didFinishUpdate() {
        print(5)
    }
```

## SpriteKit Scene / SKTileMapNode

### SpitKitScene
New file > SpriteKitScene
Library '+' near upper right
Drag out Tile Map node
Atrributes Inspector
Tile size 64x64
Map Size 12x21
Can't edit map until you add tiles

### SpriteKit Tile Set
New file > SpriteKit Tile Set
Empty Tile Set
Tiles come from Asset Catalogue - add tile there
Back to MyTileSet > + sign upper right > Drag image to tile
Rename Concrete > Block
Click on Scene > Show Attributes Inspector > Tile Sets = Concrete
Double click map > Now you can start adding tiles


# How to

## How to start/stop animation 

```swift
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if dog.hasActions() {
            dog.removeAllActions()
        } else {
            dog.run(SKAction.repeatForever(SKAction.animate(with: dogFrames, timePerFrame: 0.1)))
        }
    }
```

## How to load GameScene vs SKScene

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "MyTileMapScene") {
//                let scene = GameScene(size: view.bounds.size)
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                
                view.ignoresSiblingOrder = true
                view.showsFPS = true
                view.showsNodeCount = true
            }
        }
    }
```







