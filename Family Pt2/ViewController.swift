//
//  ViewController.swift
//  Family Pt2
//
//  Created by Everett Brothers on 10/16/23.
//

import UIKit

class ViewController: UITableViewController {

    var members: [FamMember] = []
    var edit = false
    var member: FamMember?
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMember))
        title = "Family Members"
    }
    
    @IBAction func unwindToTable(segue: UIStoryboardSegue) {
        if let vc = segue.source as? AddViewController {
            if edit {
                members.remove(at: i)
                members.insert(vc.member!, at: i)
            } else {
                members.insert(vc.member!, at: 0)
            }
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if edit {
            if let vc = segue.destination as? AddViewController {
                vc.member = self.member
            }
        }
    }
    
    @objc func addMember() {
        performSegue(withIdentifier: "toAdd", sender: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        edit = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        edit = true
        member = members[indexPath.row]
        i = indexPath.row
        performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let data = members[indexPath.row].imageData {
            let original = UIImage(data: data)
            
            let renderRect = CGRect(origin: .zero, size: CGSize(width: 90, height: 90))
            let renderer = UIGraphicsImageRenderer(size: renderRect.size)
            
            let rounded = renderer.image { ctx in
                ctx.cgContext.addEllipse(in: renderRect)
                ctx.cgContext.clip()
                
                original?.draw(in: renderRect)
            }
            
            cell.imageView?.image = rounded
        }
        
        cell.textLabel?.text = members[indexPath.row].name
        
        return cell
    }
    
}

