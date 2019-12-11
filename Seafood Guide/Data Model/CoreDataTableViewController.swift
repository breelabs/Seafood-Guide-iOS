//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  CoreDataTableViewController.swift
//
//  Created for Stanford CS193p Fall 2011.
//  Copyright 2011 Stanford University. All rights reserved.
//
// This class mostly just copies the code from NSFetchedResultsController's documentation page
//   into a subclass of UITableViewController.
//
// Just subclass this and set the fetchedResultsController.
// The only UITableViewDataSource method you'll HAVE to implement is tableView:cellForRowAtIndexPath:.
// And you can use the NSFetchedResultsController method objectAtIndexPath: to do it.
//
// Remember that once you create an NSFetchedResultsController, you CANNOT modify its @propertys.
// If you want new fetch parameters (predicate, sorting, etc.),
//  create a NEW NSFetchedResultsController and set this class's fetchedResultsController @property again.
//

//
//  CoreDataTableViewController.swift
//
//  Created for Stanford CS193p Fall 2011.
//  Copyright 2011 Stanford University. All rights reserved.
//

import CoreData
import UIKit

class CoreDataTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    // The controller (this class fetches nothing if this is not set).

    private var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        get {
            return _fetchedResultsController
        }
        set(newfrc) {
            let oldfrc = _fetchedResultsController
            if newfrc != oldfrc {
                _fetchedResultsController = newfrc
                newfrc?.delegate = self
                if (title == nil || (title == oldfrc?.fetchRequest.entity?.name)) && (navigationController == nil || navigationItem.title == nil) {
                    title = newfrc?.fetchRequest.entity?.name
                }
                if newfrc != nil {
                    if debug {
                        print("[\(NSStringFromClass(CoreDataTableViewController.self)) \(NSStringFromSelector(#function))] \(oldfrc != nil ? "updated" : "set")")
                    }
                    performFetch()
                } else {
                    if debug {
                        print("[\(NSStringFromClass(CoreDataTableViewController.self)) \(NSStringFromSelector(#function))] reset to nil")
                    }
                    tableView.reloadData()
                }
            }
        }
    }

    // Causes the fetchedResultsController to refetch the data.
    // You almost certainly never need to call this.
    // The NSFetchedResultsController class observes the context
    //  (so if the objects in the context change, you do not need to call performFetch
    //   since the NSFetchedResultsController will notice and update the table automatically).
    // This will also automatically be called if you change the fetchedResultsController @property.
    func performFetch() {
        if fetchedResultsController != nil {
            if fetchedResultsController?.fetchRequest.predicate != nil {
                if debug {
                    if let entityName = fetchedResultsController?.fetchRequest.entityName, let predicate = fetchedResultsController?.fetchRequest.predicate {
                        print("[\(NSStringFromClass(CoreDataTableViewController.self)) \(NSStringFromSelector(#function))] fetching \(entityName) with predicate: \(predicate)")
                    }
                }
            } else {
                if debug {
                    if let entityName = fetchedResultsController?.fetchRequest.entityName {
                        print("[\(NSStringFromClass(CoreDataTableViewController.self)) \(NSStringFromSelector(#function))] fetching all \(entityName) (i.e., no predicate)")
                    }
                }
            }
            var error: Error?
            do {
                try fetchedResultsController?.performFetch()
            } catch (let _error) {
                error = _error
            }
            if error != nil {
                print("[\(NSStringFromClass(CoreDataTableViewController.self)) \(NSStringFromSelector(#function))] \(error?.localizedDescription ?? "") (\((error as NSError?)?.localizedFailureReason ?? ""))")
            }
        } else {
            if debug {
                print("[\(NSStringFromClass(CoreDataTableViewController.self)) \(NSStringFromSelector(#function))] no NSFetchedResultsController (yet?)")
            }
        }
        tableView.reloadData()
    }

    // Turn this on before making any changes in the managed object context that
    //  are a one-for-one result of the user manipulating rows directly in the table view.
    // Such changes cause the context to report them (after a brief delay),
    //  and normally our fetchedResultsController would then try to update the table,
    //  but that is unnecessary because the changes were made in the table already (by the user)
    //  so the fetchedResultsController has nothing to do and needs to ignore those reports.
    // Turn this back off after the user has finished the change.
    // Note that the effect of setting this to NO actually gets delayed slightly
    //  so as to ignore previously-posted, but not-yet-processed context-changed notifications,
    //  therefore it is fine to set this to YES at the beginning of, e.g., tableView:moveRowAtIndexPath:toIndexPath:,
    //  and then set it back to NO at the end of your implementation of that method.
    // It is not necessary (in fact, not desirable) to set this during row deletion or insertion
    //  (but definitely for row moves).

    private var _suspendAutomaticTrackingOfChangesInManagedObjectContext = false
    var suspendAutomaticTrackingOfChangesInManagedObjectContext: Bool {
        get {
            return _suspendAutomaticTrackingOfChangesInManagedObjectContext
        }
        set(suspend) {
            if suspend {
                _suspendAutomaticTrackingOfChangesInManagedObjectContext = true
            } else {
                perform(#selector(endSuspensionOfUpdatesDueToContextChanges), with: nil, afterDelay: 0)
            }
        }
    }
    // Set to YES to get some debugging output in the console.
    var debug = false
    private var beganUpdates = false

// MARK: - Properties

// MARK: - Fetching

// MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedResultsController?.sections?[section].name
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultsController?.section(forSectionIndexTitle: title, at: index) ?? 0
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController?.sectionIndexTitles
    }

// MARK: - NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if !suspendAutomaticTrackingOfChangesInManagedObjectContext {
            tableView.beginUpdates()
            beganUpdates = true
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        if !suspendAutomaticTrackingOfChangesInManagedObjectContext {
            switch type {
                case .insert:
                    tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
                case .delete:
                    tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
                case .move:
                    print("A table item was moved")
                case .update:
                    print("A table item was updated")
                @unknown default:
                    break
            }
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if !suspendAutomaticTrackingOfChangesInManagedObjectContext {
            switch type {
                case .insert:
                    tableView.insertRows(at: [newIndexPath].compactMap { $0 }, with: .fade)
                case .delete:
                    tableView.deleteRows(at: [indexPath].compactMap { $0 }, with: .fade)
                case .update:
                    tableView.reloadRows(at: [indexPath].compactMap { $0 }, with: .fade)
                case .move:
                    tableView.deleteRows(at: [indexPath].compactMap { $0 }, with: .fade)
                    tableView.insertRows(at: [newIndexPath].compactMap { $0 }, with: .fade)
                @unknown default:
                    break
            }
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if beganUpdates {
            tableView.endUpdates()
        }
    }

    @objc func endSuspensionOfUpdatesDueToContextChanges() {
        suspendAutomaticTrackingOfChangesInManagedObjectContext = false
    }
}
