//
//  ViewController.swift
//  MessageHandlersExample
//
//  Created by 장효원 on 2021/12/17.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //반드시 추가해줘야함
        let handlerList: [String] = ["selected_item", "test", "test2"]

        let preferences = WKPreferences()
        let config = WKWebViewConfiguration()
        let processPool = WKProcessPool()
        
        config.allowsInlineMediaPlayback = true;
        config.processPool = processPool
        preferences.javaScriptEnabled = true
        config.preferences = preferences
        config.mediaPlaybackRequiresUserAction = false
        config.allowsInlineMediaPlayback = true
        
        //하이브리드 처리
        let contentController = WKUserContentController()
        for event in handlerList {
            contentController.add(self, name: event)
        }
    
        config.userContentController = contentController

        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: config)
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView.uiDelegate = self
        
        let urlRequest:URLRequest = URLRequest(url: URL(string: "http://janghyo.com")!)
        webView.load(urlRequest)
        
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(webView)
    }

}

extension ViewController: WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate{
    
    //메세지핸들러에서 받아오는 부분
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
            case "selected_item" :
                print("\(message.body)")
                break;
            case "test2" :
                print("\(message.body)")
                break;
            default :
                print("\(message.body)")
                break;
        }
    }
    
}
