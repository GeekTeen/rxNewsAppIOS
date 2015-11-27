//
//  FBViewController.swift
//  rxNewsApp
//
//  Created by HuJian on 15/11/21.
//  Copyright © 2015年 Shakugan. All rights reserved.
//

import UIKit

class FBViewController: UIViewController {
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var commit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        commit.addTarget(self, action: "feedback", forControlEvents: UIControlEvents.TouchUpInside)
        content.layer.borderWidth = 1
        content.layer.cornerRadius = 5
        content.clipsToBounds = true
        content.text="请输入内容"
        content.layer.borderColor = UIColor.lightGrayColor().CGColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func feedback(){
        if let _ = content.text {
            if let _ = nickname.text{
                let PARAM = ["content":content.text!,"nickname":nickname.text!]
                let AFMANAGER = AFHTTPRequestOperationManager()
                let url = "http://user.ecjtu.net/api/v1/feedback"
                let POST = AFMANAGER.POST(url, parameters: PARAM, success: { (AFHTTPRequestOperation, resp:AnyObject) -> Void in
                    print(resp)
                    }, failure: { (AFHTTPRequestOperation, error:NSError) -> Void in
                        print(error)
                })
                POST!.responseSerializer = AFHTTPResponseSerializer()
                POST!.start()
                MozTopAlertView.showWithType(MozAlertTypeSuccess, text: "感谢您的支持", parentView: self.view.viewWithTag(1))
            }
        }
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        content.resignFirstResponder()
        nickname.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView){
        content.text=""
    }


}