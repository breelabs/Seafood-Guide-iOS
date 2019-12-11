//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  GridViewController.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import CoreData
import QuartzCore
import UIKit

let reuseIdentifier = "Cell"

class GridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var customButtonHome: UIButton!

    private var recipePhotos: [AnyHashable] = []
    private var labelTitles: [AnyHashable] = []

    var window: UIWindow?
    var services: [AnyHashable] = []
    var recipeImages: [AnyHashable] = []
    @IBOutlet var myCollectionView: UICollectionView!
    var detailNewsViewController: TVCDetailViewController?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    var managedObjectContext: NSManagedObjectContext?

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 30
        let cellSize = collectionView.frame.size.width - padding
        return CGSize(width: cellSize / 2, height: cellSize / 2)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        services = FishCat.getSampleData() ?? []
        // Initialize recipe image array

        recipePhotos = ["fish1.png", "fish2.png", "fish3.png", "fish4.png", "fish5.png", "fish6.png", "allfish.png", "donteat.png"]

        labelTitles = ["Mild Fish", "Flavorful Fish", "Steak Like Fish", "Small Fish", "Shell Fish", "Other", "All Fish", "Dirty Dozen"]

        let backgroundPattern = UIImage(named: "FabricPlaid")

        if let backgroundPattern = backgroundPattern {
            view.backgroundColor = UIColor(patternImage: backgroundPattern)
        }
        if let backgroundPattern = backgroundPattern {
            myCollectionView.backgroundColor = UIColor(patternImage: backgroundPattern)
        }

    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        performSegue(withIdentifier: "detail", sender: self)

        let selectedItem = "\(recipePhotos[indexPath.item])"

        if selectedItem.isEqual("fish1.png") {
            let myValue = "0"

            let defaultPrefsFile = Bundle.main.path(forResource: "defaultPrefs", ofType: "plist")
            let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile ?? "") as Dictionary?
            if let defaultPreferences = defaultPreferences as? [String : Any] {
                UserDefaults.standard.register(defaults: defaultPreferences)
            }

            UserDefaults.standard.setValue(myValue, forKey: "justclicked")
            UserDefaults.standard.synchronize()
        } else if selectedItem.isEqual("fish2.png") {
            let myValue = "1"

            let defaultPrefsFile = Bundle.main.path(forResource: "defaultPrefs", ofType: "plist")
            let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile ?? "") as Dictionary?
            if let defaultPreferences = defaultPreferences as? [String : Any] {
                UserDefaults.standard.register(defaults: defaultPreferences)
            }

            UserDefaults.standard.setValue(myValue, forKey: "justclicked")
            UserDefaults.standard.synchronize()
        } else if selectedItem.isEqual("fish3.png") {
            let myValue = "2"

            let defaultPrefsFile = Bundle.main.path(forResource: "defaultPrefs", ofType: "plist")
            let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile ?? "") as Dictionary?
            if let defaultPreferences = defaultPreferences as? [String : Any] {
                UserDefaults.standard.register(defaults: defaultPreferences)
            }

            UserDefaults.standard.setValue(myValue, forKey: "justclicked")
            UserDefaults.standard.synchronize()
        } else if selectedItem.isEqual("fish4.png") {
            let myValue = "3"

            let defaultPrefsFile = Bundle.main.path(forResource: "defaultPrefs", ofType: "plist")
            let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile ?? "") as Dictionary?
            if let defaultPreferences = defaultPreferences as? [String : Any] {
                UserDefaults.standard.register(defaults: defaultPreferences)
            }

            UserDefaults.standard.setValue(myValue, forKey: "justclicked")
            UserDefaults.standard.synchronize()
        } else if selectedItem.isEqual("fish5.png") {
            let myValue = "4"

            let defaultPrefsFile = Bundle.main.path(forResource: "defaultPrefs", ofType: "plist")
            let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile ?? "") as Dictionary?
            if let defaultPreferences = defaultPreferences as? [String : Any] {
                UserDefaults.standard.register(defaults: defaultPreferences)
            }

            UserDefaults.standard.setValue(myValue, forKey: "justclicked")
            UserDefaults.standard.synchronize()
        } else if selectedItem.isEqual("fish6.png") {
            let myValue = "5"

            let defaultPrefsFile = Bundle.main.path(forResource: "defaultPrefs", ofType: "plist")
            let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile ?? "") as Dictionary?
            if let defaultPreferences = defaultPreferences as? [String : Any] {
                UserDefaults.standard.register(defaults: defaultPreferences)
            }

            UserDefaults.standard.setValue(myValue, forKey: "justclicked")
            UserDefaults.standard.synchronize()
        } else if selectedItem.isEqual("allfish.png") {
            let myValue = "6"

            let defaultPrefsFile = Bundle.main.path(forResource: "defaultPrefs", ofType: "plist")
            let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile ?? "") as Dictionary?
            if let defaultPreferences = defaultPreferences as? [String : Any] {
                UserDefaults.standard.register(defaults: defaultPreferences)
            }

            UserDefaults.standard.setValue(myValue, forKey: "justclicked")
            UserDefaults.standard.synchronize()
        } else if selectedItem.isEqual("donteat.png") {
            let myValue = "7"

            let defaultPrefsFile = Bundle.main.path(forResource: "defaultPrefs", ofType: "plist")
            let defaultPreferences = NSDictionary(contentsOfFile: defaultPrefsFile ?? "") as Dictionary?
            if let defaultPreferences = defaultPreferences as? [String : Any] {
                UserDefaults.standard.register(defaults: defaultPreferences)
            }

            UserDefaults.standard.setValue(myValue, forKey: "justclicked")
            UserDefaults.standard.synchronize()
        }

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipePhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        let recipeImageView = cell.viewWithTag(100) as? UIImageView
        recipeImageView?.image = UIImage(named: recipePhotos[indexPath.row] as? String ?? "")

        let labelView = cell.viewWithTag(50) as? UILabel
        labelView?.text = "\(labelTitles[indexPath.row])"

        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 4

        return cell
    }
}
