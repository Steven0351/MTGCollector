//
//  ViewController.swift
//  MTGCollector
//
//  Created by Steven Sherry on 12/12/16.
//  Copyright © 2016 Affinity for Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var cards : [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
        cards = try context.fetch(Card.fetchRequest())
        tableView.reloadData()
        } catch {
        }
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
            return cards.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            let card = cards[indexPath.row]
            cell.textLabel?.text = card.name
            cell.imageView?.image = UIImage(data: card.image as! Data)
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        performSegue(withIdentifier: "cardSegue", sender: card)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! CardViewController
        nextVC.card = sender as? Card
    }
}

        



