//
//  ViewController.swift
//  Chat UI
//
//  Created by Renish Dadhaniya iMac on 06/02/18.
//  Copyright © 2018 GlobeSync Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var aTableView: UITableView!
    
    @IBOutlet weak var textVI: UITextView!
    @IBOutlet weak var txtVIHightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sentBtn: UIButton!
    
    let senderColor : UIColor = UIColor(red: 64/255, green: 201/255, blue: 64/255, alpha: 0.4)
    let receiverColor : UIColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    
    var chatMessageAry = [String]()
    var txtVIDefheight : CGFloat = 0.0
    
    var txtVIMaxScrollArea : Int = Int(((UIScreen.main.bounds.size.height) * 50) / 100)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIScreen.main.bounds.size.width == 320 {
            
            self.txtVIMaxScrollArea = Int(((UIScreen.main.bounds.size.height) * 40) / 100)
            
        }else if UIScreen.main.bounds.size.width == 375 {
            
            self.txtVIMaxScrollArea = Int(((UIScreen.main.bounds.size.height) * 45) / 100)
            
        }else{
            
            self.txtVIMaxScrollArea = Int(((UIScreen.main.bounds.size.height) * 50) / 100)
            
        }
        
        self.txtVIDefheight = self.txtVIHightConstraint.constant
        
        self.textVI.delegate = self
        self.textVI.layer.masksToBounds = true
        self.textVI.clipsToBounds = true
        self.textVI.layer.cornerRadius = 10.0
        self.textVI.layer.borderWidth = 1.0
        self.textVI.layer.borderColor = UIColor.lightGray.cgColor
        
        //Touch Out Side onto the screen and KeyBoard Go Away
        let KeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(self.dismissKeyboard))
        view.addGestureRecognizer(KeyboardTap)
        
        
        self.iSSentButtonEnable(iSEnable: false)
        
        self.aTableView.tableFooterView = UIView()
        self.aTableView.tableFooterView?.backgroundColor = .white
        self.aTableView.backgroundColor = .white
        self.aTableView.reloadData()
        
    }
    
    
    @IBAction func sentButtonAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        let trimmedChatMsg = self.textVI.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if trimmedChatMsg.count > 0{
            
            self.chatMessageAry.append(self.textVI.text)
            self.textVI.text = ""
            self.txtVIHightConstraint.constant = self.txtVIDefheight
            self.iSSentButtonEnable(iSEnable: false)
            
        }
        
        self.aTableView.reloadData()
        
        let lastIndepath = IndexPath(row: 0, section:((self.chatMessageAry.count)-1) )
        self.aTableView.scrollToRow(at: lastIndepath, at: .top, animated: false)
        
    }
    
    
    //---- Table view ----
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.chatMessageAry.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 5))
        footerView.backgroundColor = .white
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MessageTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        
        if indexPath.section % 2 == 0 {
            
            cell.txtLBL.textColor = .white
            cell.txtLBL.textAlignment = .right

            cell.msgBoxTrailingConstraint.constant = 25
            cell.msgBoxLeadingConstraint.constant = (UIScreen.main.bounds.size.width * 40)/100
            
            cell.imageTrailingConstraint.constant = 10
            cell.imageLeadingConstraint.constant = (UIScreen.main.bounds.size.width * 40)/100
  
            cell.bubbleImg.tintColor = UIColor(named: "chat_bubble_color_sent")
            cell.bubbleImg.image = UIImage(named:"chat_bubble_sent")?
                .resizableImage(withCapInsets:
                    UIEdgeInsetsMake(17, 21, 17, 21),
                                resizingMode: .stretch)
                .withRenderingMode(.alwaysTemplate)
            
        } else {
            
            cell.txtLBL.textAlignment = .left
            cell.txtLBL.textColor = .black
  
            cell.msgBoxTrailingConstraint.constant = (UIScreen.main.bounds.size.width * 40)/100
            cell.msgBoxLeadingConstraint.constant = 25
            
            cell.imageTrailingConstraint.constant = (UIScreen.main.bounds.size.width * 40)/100
            cell.imageLeadingConstraint.constant = 10
            
            cell.bubbleImg.tintColor = UIColor(named: "chat_bubble_color_received")
            cell.bubbleImg.image = UIImage(named:"chat_bubble_received")?
                .resizableImage(withCapInsets:
                    UIEdgeInsetsMake(17, 21, 17, 21),
                                resizingMode: .stretch)
                .withRenderingMode(.alwaysTemplate)
        }
        
        
        let chatMsg = self.chatMessageAry[indexPath.section]
        let trimmedChatMsg = chatMsg.trimmingCharacters(in: .whitespacesAndNewlines)
        cell.txtLBL.text = trimmedChatMsg
        
        return cell
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        let sizeThatFitsTextView : CGSize = textView.sizeThatFits(textView.frame.size)
        
        if  (sizeThatFitsTextView.height > self.txtVIDefheight) && (sizeThatFitsTextView.height < (CGFloat(self.txtVIMaxScrollArea))) {
            
            self.txtVIHightConstraint.constant = sizeThatFitsTextView.height
            
            if sizeThatFitsTextView.height > 150 {
                self.textVI.layer.cornerRadius = 20.0
            }else{
                self.textVI.layer.cornerRadius = 15.0
            }
            
        }else {
            
            self.textVI.layer.cornerRadius = 10.0
            
        }
        
        let trimmedChatMsg = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Sent Enable Disable
        if trimmedChatMsg.count > 0{
            
            self.iSSentButtonEnable(iSEnable: true)
            
        }else{
            
            self.iSSentButtonEnable(iSEnable: false)
            
        }
        
        return true
        
    }
    
    
    func iSSentButtonEnable(iSEnable : Bool){
        
        self.sentBtn.isEnabled = iSEnable
        
        if iSEnable {
            self.sentBtn.alpha = 1.0
        }else{
            self.sentBtn.alpha = 0.7
        }
        
    }
    
    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}



