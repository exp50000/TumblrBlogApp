//
//  VideoPostCell.swift
//  JKO-Homework
//
//  Created by Ric. on 2020/5/7.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit
import WebKit

class VideoPostCell: UITableViewCell {

    @IBOutlet weak var blogerView: BlogerView!
    
    @IBOutlet weak var webContainerView: UIView!
    
    @IBOutlet weak var captionTextView: UITextView!
    
    @IBOutlet weak var watchFullVideoLabel: UILabel!
    
    var webView: WKWebView!
    
    var viewModel: VideoPostCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupWKWebView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        webView.frame = CGRect(origin: CGPoint(x: -3, y: -5), size: webContainerView.bounds.size)
    }
}

extension VideoPostCell: PostCellConfigurable {
    
    func configure(viewModel: PostCellViewModel) {
        guard let viewModel = viewModel as? VideoPostCellViewModel else {
            return
        }
        
        self.viewModel = viewModel
        
        blogerView.setupView(name: viewModel.name, avatar: viewModel.avatar)
        
        captionTextView.attributedText = viewModel.caption
        let html = viewModel.video
        webView.loadHTMLString(html, baseURL: nil)
        
        let icon: NSAttributedString = {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "icon_film")
            attachment.bounds = CGRect(x: 0.0, y: -2.0, width: 14.0, height: 14.0)
            return NSAttributedString(attachment: attachment)
        }()
        
        let string = NSAttributedString(string: "  觀看完整影片 ",
                                        attributes: [.foregroundColor: UIColor.white])
        
        let attributedText: NSMutableAttributedString = {
            let result = NSMutableAttributedString(string: " ")
            result.append(icon)
            result.append(string)
            return result
        }()
        
        watchFullVideoLabel.attributedText = attributedText
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
        webContainerView.sendSubviewToBack(webView)
        
        webView.frame = CGRect(origin: CGPoint(x: -3, y: -5), size: webContainerView.bounds.size)
    }
}

extension VideoPostCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}

extension VideoPostCell: WKNavigationDelegate {
    
    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
}

extension VideoPostCell: WKScriptMessageHandler {
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
