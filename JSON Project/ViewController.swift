//
//  ViewController.swift
//  Project 7
//
//  Created by Ruben Sissing on 22/08/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit

final class ViewController: UITableViewController {

	var petitions = [[String: String]]()

	override func viewDidLoad() {
		super.viewDidLoad()

		let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"

		if let url = URL(string: urlString) {
			if let data = try? String(contentsOf: url) {
				let json = JSON(parseJSON: data)

				if json["metadata"]["responseInfo"]["status"].intValue == 200 {
					self.parse(json: json)
				}
			}
		}
	}

	private func parse(json: JSON) {
		for result in json["results"].arrayValue {
			let title = result["title"].stringValue
			let body = result["body"].stringValue
			let sigs = result["signatureCount"].stringValue
			let object = ["title": title, "body": body, "sigs": sigs]
			self.petitions.append(object)
		}

		self.tableView.reloadData()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.petitions.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let petition = self.petitions[indexPath.row]
		cell.textLabel?.text = petition["title"]
		cell.detailTextLabel?.text = petition["body"]
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let viewController = DetailViewController()
		viewController.detailItem = petitions[indexPath.row]
		self.navigationController?.pushViewController(viewController, animated: true)
	}

}
