//
//  archCollectionViewHeader.swift
//  Medal Case
//
//  Created by Fang Sun on 2021-11-14.
//

import UIKit

class ArchCollectionViewHeader: UICollectionReusableView {
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var archivedCount: UILabel!
    
    
    func setValue(name:String, archived:String?) {
        self.headerName.text = name
        self.archivedCount.text = archived ?? ""
    }
}
