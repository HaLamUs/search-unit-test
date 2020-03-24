//
//  ViewController.swift
//  testSearchFunction
//
//  Created by lamha on 10/1/19.
//  Copyright © 2019 zappasoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "")
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         print()
    }
}


