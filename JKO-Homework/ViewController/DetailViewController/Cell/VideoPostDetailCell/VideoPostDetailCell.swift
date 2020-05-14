//
//  VideoPostDetailCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/14.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import WebKit

class VideoPostDetailCell: UITableViewCell {

    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var webContainerView: UIView!
    
    @IBOutlet weak var captionTextView: UITextView!
    
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var shortUrlView: ShortUrlView!
    
    var webView: WKWebView!
    
    var needReload: (() -> Void)?
    
    var viewModel: VideoPostDetailCellViewModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupWKWebView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        webView.frame = CGRect(origin: CGPoint(x: -3, y: -5), size: webContainerView.bounds.size)
    }
    
}

extension VideoPostDetailCell: PostDetailCellConfigurable {
    
    func configure(viewModel: PostDetailCellViewModel) {
        guard let viewModel = viewModel as? VideoPostDetailCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        captionTextView.attributedText = viewModel.caption
        captionTextView.isHidden = viewModel.caption.string.isEmpty
        
        let html = viewModel.video
        webView.loadHTMLString(html, baseURL: nil)
        
        shortUrlView.setupView(url: viewModel.shortUrl, date: viewModel.postDate)
    }
    
    func setupWKWebView() {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = .audio
        
        webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        webView.scrollView.isScrollEnabled = false
        webContainerView.addSubview(webView)
        
        webView.frame = CGRect(origin: CGPoint(x: -3, y: -5), size: webContainerView.bounds.size)
    }
}

extension VideoPostDetailCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}

extension VideoPostDetailCell: WKNavigationDelegate {
    
    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState") { complete, error in
            if complete != nil {
                webView.evaluateJavaScript("document.body.offsetHeight") { height, error in
                    let videoHeight = (height as? CGFloat) ?? 0
                    let videoWidth = CGFloat(self.viewModel?.videoWidth ?? 0)
                    let ratio = videoHeight > 0 ? videoWidth / videoHeight : 0
                    
                    let height = UIScreen.main.bounds.width / ratio
                    webView.frame.size.height = height
                    self.webViewHeight.constant = height
                    
                    self.needReload?()
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
}

extension VideoPostDetailCell: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        var scriptContent = "var meta = document.createElement('meta');"
        scriptContent += "meta.name='viewport';"
        scriptContent += "meta.content='width=device-width';"
        scriptContent += "document.getElementsByTagName('head')[0].appendChild(meta);"
        webView.evaluateJavaScript(scriptContent)
    }
}
