//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by David Inyangson on 9/15/19.
//  Copyright © 2019 David Inyangson. All rights reserved.
//

import UIKit;
import WebKit;

class ViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate {

  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var locationField: UITextField!
  @IBOutlet weak var backButton: UIBarButtonItem!
  @IBOutlet weak var forwardButton: UIBarButtonItem!
  @IBOutlet weak var actionButton: UIBarButtonItem!
  @IBOutlet weak var refreshButton: UIBarButtonItem!
  @IBOutlet weak var stopButton: UIBarButtonItem!


  @IBAction func goTapped(_ sender:Any) {
    let url = URL(string: "https://" + locationField!.text!)!
    webView.load(URLRequest(url:url))
  }
  
  @IBAction func refreshTapped(_ sender: Any) {
    webView.reload()
  }
  
  @IBAction func backTapped(_ sender: Any) {
    if webView.canGoBack {
      webView.goBack()
    }
  }
  
  @IBAction func forwardTapped(_ sender: Any) {
    if webView.canGoForward {
      webView.goForward()
    }
  }
  
  @IBAction func stopTapped(_ sender: Any) {
    webView.stopLoading()
  }
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
    locationField.text = ""
  }
  
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let urlString = String("https://" + locationField!.text!)
    let url = URL(string: "https://" + locationField!.text!)!
    locationField.text = urlString
    webView.load(URLRequest(url: url))
    locationField.resignFirstResponder()
    return true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let urlString: String = "https://www.google.com"
    let url:URL = URL(string: urlString)!
    let urlRequest:URLRequest = URLRequest(url:url)
    locationField.text = urlString
    webView.load(urlRequest)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self
    self.locationField.delegate = self


    // Do any additional setup after loading the view.
  }
  
  @IBAction func shareButtonTapped(_ sender: Any) {
    let urlString:String = locationField.text!
    let url:URL = URL(string: urlString)!
    
    let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
    navigationController?.present(activityViewController, animated: true)
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    backButton.isEnabled = webView.canGoBack
    // [Add Code for Forward Button, its similar!]
    forwardButton.isEnabled = webView.canGoForward
    
    locationField.text = webView.url?.absoluteString
  }


}

