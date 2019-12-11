//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  NewsViewController.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import QuartzCore
import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UINavigationControllerDelegate {
    var objects: [AnyHashable] = []
    var responseData: Data?
    var backButton: UIButton?

    @IBOutlet var newsTbView: UITableView!
    var numArray: [String] = []
    var imageArray: [UIImage] = []
    var titleArray: [String] = []
    var descArray: [String] = []
    var detailNewsViewController: DetailNewsViewController?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        numArray = []
        imageArray = []
        descArray = []
        titleArray = []
        newsTbView.delegate = self
        newsTbView.dataSource = self
        refresh()
    }

    func refresh() {

        let rootXML = RXMLElement(fromXMLFile: "ios-news.xml")

        let rxmlNews = rootXML?.child("news")

        let rxmlIndividualNew = rxmlNews?.children("new")

        for i in 0..<(rxmlIndividualNew?.count ?? 0) {
            var imgUrl: String? = nil
            if let child = (rxmlIndividualNew?[i] as AnyObject).child("imageurl").text {
                imgUrl = "\(child):"
            }
            var num: String? = nil
            if let child: String = (rxmlIndividualNew?[i] as AnyObject).child("linknews").text {
                num = "\(child)"
            }
            let img1 = UIImage(named: imgUrl ?? "")

            let title = (rxmlIndividualNew?[i] as AnyObject).child("titlenews").text ?? ""
            let desc = (rxmlIndividualNew?[i] as AnyObject).child("descnews").text ?? ""

            numArray.append(num ?? "")
            if let img1 = img1 {
                imageArray.append(img1)
            }
            titleArray.append(title)
            descArray.append(desc)
        }

        newsTbView.reloadData()

    }

// MARK: NSURLConnection Delegate Methods
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {

        responseData = Data()
    }

    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        responseData?.append(data)
    }

    func connection(_ connection: NSURLConnection, willCacheResponse cachedResponse: CachedURLResponse) -> CachedURLResponse? {
        return nil
    }

    func connectionDidFinishLoading(_ connection: NSURLConnection) {

        let rootXML = RXMLElement(fromXMLFile: "ios-news.xml")

        let rxmlNews = rootXML?.child("news")

        let rxmlIndividualNew = rxmlNews?.children("new")


        for i in 0..<(rxmlIndividualNew?.count ?? 0) {

            var imgUrl: String? = nil
            if let child:String = (rxmlIndividualNew?[i] as AnyObject).child("imageurl").text {
                imgUrl = "\(child):"
            }

            let img1 = UIImage(named: imgUrl ?? "")

            let title = (rxmlIndividualNew?[i] as AnyObject).child("titlenews").text ?? ""
            let desc = (rxmlIndividualNew?[i] as AnyObject).child("descnews").text ?? ""

            if let img1 = img1 {
                imageArray.append(img1)
            }
            titleArray.append(title)
            descArray.append(desc)
        }



        newsTbView.reloadData()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

// MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }

    static let tableViewCellIdentifier = "CellIndent"

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: NewsViewController.tableViewCellIdentifier) as? TableViewCellNews
        var CellName = ""

        CellName = "TableViewCellNews"

        if cell == nil {

            let c = UIViewController(nibName: CellName, bundle: nil)

            cell = c.view as? TableViewCellNews
        }

        cell?.numberLabel.text = numArray[indexPath.row]
        cell?.newsImageView.image = imageArray[indexPath.row]
        cell?.newsImageView.image = imageArray[indexPath.row]
        cell?.newsImageView.layer.cornerRadius = 5
        cell?.newsImageView.clipsToBounds = true
        cell?.newsImageView.layer.borderColor = UIColor.gray.cgColor
        cell?.newsImageView.layer.borderWidth = 1.2

        cell?.circle.layer.cornerRadius = 15
        cell?.circle.clipsToBounds = true
        cell?.circle.layer.borderColor = UIColor.gray.cgColor
        cell?.circle.layer.borderWidth = 2.0

        cell?.textNewsLabel.text = titleArray[indexPath.row]
        cell?.newsImageView.contentMode = .scaleToFill
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        cell?.newsImageView.alpha = 0
        cell?.textNewsLabel.alpha = 0
        cell?.textNewsLabel.alpha = 0
        UIView.beginAnimations("ResizeAnimation", context: nil)
        UIView.setAnimationDuration(0.5)
        cell?.newsImageView.alpha = 1
        cell?.textNewsLabel.alpha = 1
        cell?.newsImageView.alpha = 1
        UIView.commitAnimations()

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "detailview") as? DetailNewsViewController
        controller?.image = imageArray[indexPath.row]
        controller?.lblTitle = titleArray[indexPath.row]
        controller?.txtProject = descArray[indexPath.row]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    func createButton(withFrame frame: CGRect, andLabel label: String?) -> UIButton? {

        let button = UIButton(frame: frame)

        button.setTitleShadowColor(UIColor.black, for: .normal)
        button.titleLabel?.shadowOffset = CGSize(width: 0, height: -1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        button.setTitle(label, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)

        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4.0
        button.layer.borderWidth = 1.0

        return button
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
