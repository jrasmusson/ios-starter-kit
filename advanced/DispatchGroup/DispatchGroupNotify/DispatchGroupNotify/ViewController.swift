//
//  ViewController.swift
//  DispatchGroupNotify
//
//  Created by jrasmusson on 2021-08-02.
//

import UIKit

struct Game: Codable {
    var id: String
    var name: String
}

class ViewController: UIViewController {
    var games: [Game] = []
    var tableView = UITableView()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        view = tableView
        
        fetchGame("1")
        fetchGame("2")
        fetchGame("3")
        
        group.notify(queue: .main) {
            print("Complete")
            self.tableView.reloadData()
        }
    }
    
    func fetchGame(_ id: String) {
        print("foo - Enter")
        group.enter()
        
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/game/\(id)")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard err == nil, let data = data else { return }
            do {
                let game = try JSONDecoder().decode(Game.self, from: data)
                self.games.append(game)
                print("foo - Leave")
                self.group.leave()
                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData() // incremental
//                }
                
            } catch let err {
                print(err)
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}
