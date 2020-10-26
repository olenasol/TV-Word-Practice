//
//  MovieController.swift
//  TV Word Practice
//
//  Created by macbook on 18.10.2020.
//  Copyright © 2020 CS50. All rights reserved.
//

import UIKit
import AVFoundation
 
struct WordUI{
    var isOpened: Bool
    let word: Word
}

var words: [WordUI] = []

class MovieController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imgSprite: UIImageView!
    @IBOutlet var tableViewWords: UITableView!
    
    var movie: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        words = movie.words.map({ (word) -> WordUI in
            return WordUI(isOpened: false, word: word)
        })
        tableViewWords.delegate = self
        tableViewWords.dataSource = self
        nameLabel.text = movie.name
        imgSprite.load(url: URL(string: movie.poster)!)
    
    }
}

extension MovieController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let synthesizer = AVSpeechSynthesizer()
        //let utterance = AVSpeechUtterance(string: movie.words[indexPath.row].word )
    
        //synthesizer.speak(utterance)
        
        if words[indexPath.section].isOpened == true {
            words[indexPath.section].isOpened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            words[indexPath.section].isOpened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
}

extension MovieController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
            cell.textLabel?.text = words[indexPath.section].word.word
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
            cell.textLabel?.text = words[indexPath.section].word.translation
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if words[section].isOpened {
            return 2
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return words.count
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
