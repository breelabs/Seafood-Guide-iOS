//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  LingoTableViewController.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/1/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import UIKit
import CoreData

class LingoTableViewController: UITableViewController, UINavigationBarDelegate, UINavigationControllerDelegate {
    var uppercaseFirstLetterOfName = ""
    var predicateKey = ""

    var window: UIWindow?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    lazy var managedObjectContext: NSManagedObjectContext? = {
        return (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
    }()
    
    var sectionIndexTitles: [AnyHashable] = []

    init(lingoSize size: String?) {
        super.init(style: .plain)
    }

    func setupFetchedResultsController() {

        let entityName = "Lingo" // Put your entity name here

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        request.sortDescriptors = [NSSortDescriptor.init(key: "titlenews", ascending: true)]

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

    static let tableViewCellIdentifier = "lingocells"

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: LingoTableViewController.tableViewCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: LingoTableViewController.tableViewCellIdentifier)
        }
        cell?.accessoryType = .disclosureIndicator

        let lingo = fetchedResultsController?.object(at: indexPath) as? Lingo

        cell?.textLabel?.text = lingo?.titlenews

        return cell!

    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return UILocalizedIndexedCollation.current().sectionIndexTitles
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }

    convenience override init(style: UITableView.Style) {
        self.init(lingoSize: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(named: "Text Color")!
        navigationItem.backBarButtonItem?.title = "Back"
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

// MARK: - Table view sends data to detail view
    override func tableView(_ aTableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailViewController = DetailLingoViewController.init(style: .grouped)
        detailViewController.tableView.backgroundColor = UIColor(named: "Background")
        
        var sumSections = 0
        for i in 0..<indexPath.section {
            let rowsInSection = tableView.numberOfRows(inSection: i)
            sumSections += rowsInSection
        }
        let currentRow = sumSections + indexPath.row


        let allLingo = fetchedResultsController?.fetchedObjects?[currentRow] as? Lingo
        detailViewController.item = allLingo

        navigationController?.pushViewController(detailViewController, animated: true)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesBackButton = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
