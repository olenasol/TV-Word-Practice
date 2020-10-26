//
//  ViewController.swift
//  TV Word Practice
//
//  Created by macbook on 18.10.2020.
//  Copyright © 2020 CS50. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var movies: [Movie] = []
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTitleCell", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].name
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let jsonPath: String = Bundle.main.path(forResource: "movies", ofType: "json"), let jsonData: Data = NSData(contentsOfFile: jsonPath) as? Data {
          do {
            let movieList = try JSONDecoder().decode([Movie].self, from: jsonData)
            movies = movieList
            tableView.reloadData()
          } catch {
              print("Error while deserialization of jsonData")
          }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieSegue" {
            if let destination = segue.destination as? MovieController {
                destination.movie = movies[tableView.indexPathForSelectedRow!.row]
            }
        }
    }


}

