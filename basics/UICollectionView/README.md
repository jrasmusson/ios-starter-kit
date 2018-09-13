# UICollectionViews

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UICollectionView/images/demo.png" alt="drawing" width="400"/>

```swift
//
//  ViewController.swift
//  Youtube
//
//  Created by Jonathan Rasmusson Work Pro on 2018-09-13.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)

        cell.backgroundColor = .red
        return cell
    }
}
```




