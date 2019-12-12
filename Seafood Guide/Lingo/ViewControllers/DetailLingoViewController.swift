//  Converted to Swift 5.1 by Swiftify v5.1.26565 - https://objectivec2swift.com/
//
//  DetailLingoViewController.swift
//  Seafood Guide
//
//  Created by Jon Brown on 9/2/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

import MessageUI
import ProgressHUD
import UIKit

@objcMembers
class DetailLingoViewController: UITableViewController, UIWebViewDelegate, MFMailComposeViewControllerDelegate {
    var str = ""

    var item: Lingo?

    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        title = item?.titlenews
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
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
                cell?.textLabel?.text = item?.titlenews
                cell?.selectionStyle = .none
            } else if indexPath.row == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "CellType2")
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: "CellType2")
                }
                cell?.textLabel?.text = item?.descnews
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
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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

        if indexPath.section == 0 && indexPath.row == 1 {

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping

            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]

            let textRect = item?.descnews?.boundingRect(with: CGSize(width: 290 - (10 * 2), height: 200000.0), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

            let height = Float(textRect?.size.height ?? 0.0)
            return CGFloat(height + (2 * 2))
        }
        return 44
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Lingo Information"
        } else if section == 1 {
            return "Share"
        }

        return nil
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = false
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
            case .cancelled:
                ProgressHUD.showError("Email Not Sent")
            case .saved:
                ProgressHUD.showSuccess("Email Saved!")
            case .sent:
                ProgressHUD.showSuccess("Email Sent!")
            case .failed:
                ProgressHUD.showError("Email Not Sent")
            default:
                ProgressHUD.showError("Email Not Sent")
        }
        dismiss(animated: true)
    }

    func sendEmail() {

        str = item?.descnews ?? ""
        str = (str as NSString).substring(to: min(1165, str.count))

        let one = item?.titlenews
        let two = item?.descnews

        let All = "Fish Name: \(one ?? "")\n\nType: \(two ?? "")\n\n\nDescription:\n\(str)"


        if MFMailComposeViewController.canSendMail() {
            let mailer = MFMailComposeViewController()
            mailer.mailComposeDelegate = self
            mailer.setSubject("Food & Water Watch - Check This Out: \(one ?? "")")
            let toRecipients = [config.getMail()]
            mailer.setToRecipients(toRecipients)
            let emailBody = All
            mailer.setMessageBody(emailBody, isHTML: false)
            present(mailer, animated: true)
        } else {

            let alert = UIAlertController(title: "Failure", message: "Your device doesn't support the composer sheet", preferredStyle: .alert)


            let noButton = UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                    //Handle no, thanks button
                    self.presentedViewController?.dismiss(animated: false)
                })

            alert.addAction(noButton)

            present(alert, animated: true)
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
