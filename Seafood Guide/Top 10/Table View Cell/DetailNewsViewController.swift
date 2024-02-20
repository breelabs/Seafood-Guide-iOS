//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  DetailNewsViewController.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import UIKit

@objcMembers
class DetailNewsViewController: UIViewController, UINavigationBarDelegate, UINavigationControllerDelegate {
    var str = ""
    var customButton: UIButton?
    var window: UIWindow?

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var txtView: UITextView!
    var myInt = 0
    var image: UIImage?
    var lblTitle = ""
    var txtProject = ""

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .default
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "Text Color")!]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Text Color")!]
        appearance.backgroundColor = UIColor(named: "Background")

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Text Color")!
        
// MARK: - Button Style

        // R: 76 G: 76 B: 76
        let buttColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)

        let layer = customButton?.layer
        layer?.masksToBounds = true
        layer?.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        layer?.borderWidth = 1.0
        layer?.borderColor = buttColor.cgColor

        let All = lblTitle
        navigationItem.title = All
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imgView.image = image
        txtView.text = txtProject
        imgView.alpha = 1
        txtView.alpha = 1
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imgView.image = nil
        txtView.text = nil
        imgView.alpha = 0
        txtView.alpha = 0
    }

    override func didMove(toParent parent: UIViewController?) {
        if !(parent?.isEqual(self.parent) ?? false) {
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        button.layer.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        button.layer.borderWidth = 1.0

        return button
    }

    func closeView() {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
