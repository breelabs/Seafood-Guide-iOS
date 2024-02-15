//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  TVCDetailViewController.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import MessageUI
import ProgressHUD
import Social
import UIKit

class TVCDetailViewController: UITableViewController, UIWebViewDelegate, MFMailComposeViewControllerDelegate {
    var str = ""

    var item: Seafood?

    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        title = item?.name
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 1
        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell? = nil

        if indexPath.section == 0 {

            if indexPath.row == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "CellType1")
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: "CellType1")
                }
                cell?.textLabel?.text = item?.name
                cell?.selectionStyle = .none
            } else if indexPath.row == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "CellType2")
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: "CellType2")
                }
                cell?.textLabel?.text = item?.region
                cell?.textLabel?.lineBreakMode = .byWordWrapping
                cell?.textLabel?.numberOfLines = 0
                cell?.textLabel?.font = UIFont(name: "Helvetica", size: 17.0)
                cell?.selectionStyle = .none
            } else if indexPath.row == 2 {
                cell = tableView.dequeueReusableCell(withIdentifier: "CellType3")
                if cell == nil {
                    cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellType3")
                }
                cell?.textLabel?.text = item?.desc
                cell?.textLabel?.lineBreakMode = .byWordWrapping
                cell?.textLabel?.numberOfLines = 0
                cell?.textLabel?.font = UIFont(name: "Helvetica", size: 17.0)
                cell?.selectionStyle = .none
            } else if indexPath.row == 3 {
                cell = tableView.dequeueReusableCell(withIdentifier: "CellType4")
                if cell == nil {
                    cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellType4")
                }
                cell?.textLabel?.text = item?.good
                cell?.textLabel?.lineBreakMode = .byWordWrapping
                cell?.textLabel?.numberOfLines = 0
                cell?.textLabel?.font = UIFont(name: "Helvetica", size: 17.0)
                cell?.selectionStyle = .none
            }
        } else if indexPath.section == 1 {

            if indexPath.row == 0 {

                cell = tableView.dequeueReusableCell(withIdentifier: "CellType6")
                if cell == nil {
                    cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellType6")
                }
                cell?.textLabel?.text = "Email to a friend"
            }
        }

        return cell!
    }

// MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        if indexPath.section == 1 {

            if indexPath.row == 0 {

                sendEmail()
            }
        }


    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 && indexPath.row == 2 {

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping

            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]

            let textRect = item?.desc?.boundingRect(with: CGSize(width: 290 - (10 * 2), height: 200000.0), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

            let height = Float(textRect?.size.height ?? 0.0)
            return CGFloat(height + (2 * 2))
        }
        return 44
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Fish Information"
        } else if section == 1 {
            return "Share"
        }

        return nil
    }

    override func viewDidAppear(_ animated: Bool) {
        //[super viewDidAppear:YES];
        navigationItem.hidesBackButton = false
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
            case .cancelled:
                ProgressHUD.failed("Email Not Sent")
            case .saved:
                ProgressHUD.succeed("Email Saved!")
            case .sent:
                ProgressHUD.succeed("Email Sent!")
            case .failed:
                ProgressHUD.failed("Email Not Sent")
            default:
                ProgressHUD.failed("Email Not Sent")
        }
        dismiss(animated: true)
    }

    func sendEmail() {

        str = item?.desc ?? ""
        str = (str as NSString).substring(to: min(1165, str.count))

        let one = item?.name
        let two = item?.region
        let three = item?.good

        let All = "Fish Name: \(one ?? "")\n\nType: \(two ?? "")\n\n\(three ?? "")\n\nDescription:\n\(str)"




        if MFMailComposeViewController.canSendMail() {
            let mailer = MFMailComposeViewController()
            mailer.mailComposeDelegate = self
            mailer.setSubject("Food & Water Watch - Check This Out: \(one ?? "")")
            mailer.setToRecipients([config.getMail()])
            let emailBody = All
            mailer.setMessageBody(emailBody, isHTML: false)
            present(mailer, animated: true)
        } else {

            let alert = UIAlertController(title: "Failure", message: "Your device doesn't support the composer sheet", preferredStyle: .alert)


            let noButton = UIAlertAction(title: "OK", style: .default, handler: { action in
                    //Handle no, thanks button
                    self.presentedViewController?.dismiss(animated: false)
                })

            alert.addAction(noButton)

            present(alert, animated: true)

            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
            //                                                        message:@"Your device doesn't support the composer sheet"
            //                                                       delegate:nil
            //                                              cancelButtonTitle:@"OK"
            //                                              otherButtonTitles:nil];
            //        [alert show];
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
        button.layer.cornerRadius = 4.0 //when radius is 0, the border is a rectangle
        button.layer.borderWidth = 1.0

        return button
    }

    func closeView() {
        //[self dismissModalViewControllerAnimated:YES];
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
