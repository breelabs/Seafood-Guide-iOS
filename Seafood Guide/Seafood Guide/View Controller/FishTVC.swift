//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  FishTVC.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import UIKit
import  CoreData

//#import "CoreDataTableViewController.h" // so we can fetch
//#import "Seafood.h"

class FishTVC: CoreDataTableViewController {
    var predicateKey = ""
    var uppercaseFirstLetterOfName = ""

    var window: UIWindow?

    lazy var managedObjectContext: NSManagedObjectContext? = {
        return (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    }()

    init(fishSize size: String?) {
        super.init(style: UITableView.Style.plain)
    }

    func prefersStatusBarHidden() -> Bool {
        return false
    }

    func setupFetchedResultsController() {

        let entityName = "Seafood" // Put your entity name here
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let defaults = UserDefaults.standard
        let integerFromPrefs = defaults.integer(forKey: "justclicked")
        predicateKey = String(format: "%li", UInt(integerFromPrefs))

        if integerFromPrefs == 0 {
            title = "Mild Fish"
        } else if integerFromPrefs == 1 {
            title = "Thicker & Flavorful"
        } else if integerFromPrefs == 2 {
            title = "Steak Like"
        } else if integerFromPrefs == 3 {
            title = "Small Fish"
        } else if integerFromPrefs == 4 {
            title = "Shellfish"
        } else if integerFromPrefs == 5 {
            title = "Other"
        } else if integerFromPrefs == 6 {
            title = "All Fish"
        } else if integerFromPrefs == 7 {
            title = "Dirty Dozen"
        }

        if predicateKey != "" {

            let pred = NSPredicate(format: "fishtype like[c] %@", predicateKey)
            request.predicate = pred
        }

        request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        if let managedObjectContext = managedObjectContext {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: "uppercaseFirstLetterOfName", cacheName: nil)
        }



        do {
            try fetchedResultsController?.performFetch()
        } catch {
        }

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        weak var sectionInfo = fetchedResultsController?.sections?[section]
        return sectionInfo?.name
    }

    override func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        weak var sectionInfo = fetchedResultsController?.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()


    }

    static let tableViewCellIdentifier = "FishCell"

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: FishTVC.tableViewCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: FishTVC.tableViewCellIdentifier)
        }

        cell?.accessoryType = .disclosureIndicator

        let seafood = fetchedResultsController?.object(at: indexPath) as? Seafood

        cell?.textLabel?.text = seafood?.name


        return cell!

    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return UILocalizedIndexedCollation.current().sectionIndexTitles
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }

    convenience override init(style: UITableView.Style) {
        self.init(fishSize: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.title = "Back"
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

// MARK: - Table view sends data to detail view
    // Core data to detail view
    override func tableView(_ aTableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailViewController = TVCDetailViewController.init(style: .plain)

        var sumSections = 0
        for i in 0..<indexPath.section {
            let rowsInSection = tableView.numberOfRows(inSection: i)
            sumSections += rowsInSection
        }
        let currentRow = sumSections + indexPath.row

        let allSeafood = fetchedResultsController?.fetchedObjects?[currentRow] as? Seafood
        detailViewController.item = allSeafood

        navigationController?.pushViewController(detailViewController, animated: true)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = false
    }
}

//#import "CoreDataTableViewController.h"
