//
//  DetailViewController.swift
//  Project 7
//
//  Created by Ruben Sissing on 22/08/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

	var webView: WKWebView!
	var detailItem: [String: String]!

	override func loadView() {
		self.webView = WKWebView()
		self.view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		guard detailItem != nil else {
			return
		}

		if let body = detailItem["body"] {
			let html = """
				<html>
					<head>
						<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
						<style> body { font-size: 150%; } </style>
					</head>
					<body>
						\(body)
					</body>
				</html>
			"""
			self.webView.loadHTMLString(html, baseURL: nil)
		}
	}

}
