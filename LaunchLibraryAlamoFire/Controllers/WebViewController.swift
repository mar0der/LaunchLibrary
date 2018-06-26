//
//  ViewController.swift
//  LaunchLibraryAlamoFire
//
//  Created by petar on 6/18/18.
//  Copyright © 2018 petar. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    public var receivedURL:String = ""
    public var searchString:String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let backupUrl = URL(string: "https://www.google.com/")
        let myURL = URL(string:receivedURL)
        let myRequest = URLRequest(url: myURL ?? backupUrl!)
        webView.load(myRequest)
    }
    
}



