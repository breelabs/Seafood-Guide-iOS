//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  AboutTableViewController.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import UIKit
import CoreData

class AboutTableViewController: UITableViewController, UINavigationBarDelegate, UINavigationControllerDelegate {
    var uppercaseFirstLetterOfName = ""
    var predicateKey = ""

    var window: UIWindow?
    var fetchedResultsController: NSFetchedResultsController<About>?
    var fetchedResultsController1: NSFetchedResultsController<About>?
    var fetchedResultsController2: NSFetchedResultsController<About>?

    lazy var managedObjectContext: NSManagedObjectContext? = {
        return (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    }()
    var detailAboutViewController: DetailAboutViewController?

    func setupFetchedResultsController() {
        let entityName = "About" // Put your entity name here

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        let predicate = NSPredicate(format: "linknews = '3'")
        request.predicate = predicate

        request.sortDescriptors = [NSSortDescriptor.init(key: "linknews", ascending: true)]

        if let managedObjectContext = managedObjectContext {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<About>
        }


        do {
            try fetchedResultsController?.performFetch()
        } catch {
        }




    }

    func setupFetchedResultsController1() {
        let entityName1 = "About" // Put your entity name here

        let request1 = NSFetchRequest<NSFetchRequestResult>(entityName: entityName1)

        let predicate1 = NSPredicate(format: "linknews = '1'")
        request1.predicate = predicate1

        request1.sortDescriptors = [NSSortDescriptor.init(key: "linknews", ascending: true)]

        if let managedObjectContext = managedObjectContext {
            fetchedResultsController1 = NSFetchedResultsController(fetchRequest: request1, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<About>
        }


        do {
            try fetchedResultsController1?.performFetch()
        } catch {
        }




    }

    func setupFetchedResultsController2() {
        let entityName2 = "About" // Put your entity name here

        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName: entityName2)

        let predicate2 = NSPredicate(format: "linknews = '2'")
        request2.predicate = predicate2

        request2.sortDescriptors = [NSSortDescriptor.init(key: "linknews", ascending: true)]

        if let managedObjectContext = managedObjectContext {
            fetchedResultsController2 = NSFetchedResultsController(fetchRequest: request2, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<About>
        }


        do {
            try fetchedResultsController2?.performFetch()
        } catch {
        }




    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitleInfo = ["About the Seafood Guide", "What You Can Do", "Labeling"]
        return sectionTitleInfo[section]
    }

    override func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 4
        }
        let fetchedObjects = fetchedResultsController?.fetchedObjects
        return fetchedObjects?.count ?? 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchedResultsController()
        setupFetchedResultsController1()
        setupFetchedResultsController2()

    }

    static let tableViewCellIdentifier = "aboutcell"

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: AboutTableViewController.tableViewCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: AboutTableViewController.tableViewCellIdentifier)
        }
        cell?.accessoryType = .disclosureIndicator
        let fetchedObjects = fetchedResultsController?.fetchedObjects
        let fetchedObjects1 = fetchedResultsController1?.fetchedObjects
        let fetchedObjects2 = fetchedResultsController2?.fetchedObjects
        
        if indexPath.section == 0 {
            cell?.textLabel?.text = fetchedObjects1?[indexPath.row].titlenews ?? ""
        } else if indexPath.section == 1 {
            cell?.textLabel?.text = fetchedObjects2?[indexPath.row].titlenews ?? ""
        } else if indexPath.section == 2 {
            cell?.textLabel?.text = fetchedObjects?[indexPath.row].titlenews ?? ""
        }
        
        return cell!
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.title = "Back"
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

// MARK: - Table view sends data to detail view
    override func tableView(_ aTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailAboutViewController.init(style: .grouped)
        detailViewController.tableView.backgroundColor = UIColor(named: "Background")

        if indexPath.section == 0 {
            let allAbout = fetchedResultsController1?.fetchedObjects?[indexPath.row]
            detailViewController.item = allAbout
        } else if indexPath.section == 1 {
            let allAbout1 = fetchedResultsController2?.fetchedObjects?[indexPath.row]
            detailViewController.item = allAbout1
        } else if indexPath.section == 2 {
            let allAbout2 = fetchedResultsController?.fetchedObjects?[indexPath.row]
            detailViewController.item = allAbout2
        }

        navigationController?.pushViewController(detailViewController, animated: true)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = false
    }
}

//#import "CoreDataTableViewController.h"
