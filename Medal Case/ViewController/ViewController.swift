//
//  ViewController.swift
//  Medal Case
//
//  Created by Fang Sun on 2021-11-09.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var archivementsCollectionView: UICollectionView!
    
    var personalRecords:PersonalRecords? = nil
    var virtualRaces:VirtualRaces? = nil
    
    var personalRecordsCompleted:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "ellipsis")
        
        retrieveUserData()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionView()
        DispatchQueue.main.async {
            self.archivementsCollectionView.reloadData()
        }
    }
    
    func setupCollectionView(){
        archivementsCollectionView.delegate = self
        archivementsCollectionView.dataSource = self
        
        self.archivementsCollectionView.register(UINib(nibName: "ArchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "archCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        archivementsCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func retrieveUserData() {
        do {
            if let filePath = Bundle.main.path(forResource: "UserData", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                self.personalRecords = try JSONDecoder().decode(PersonalRecords.self, from: data)
                self.virtualRaces = try JSONDecoder().decode(VirtualRaces.self, from: data)
                
                self.personalRecordsCompleted = self.personalRecords?.items.count ?? 0
                self.archivementsCollectionView.reloadData()
                
            }
        } catch {
            print("error: \(error)")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return self.personalRecords?.items.count ?? 0
        case 1:
            return self.virtualRaces?.items.count ?? 0
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "archCollectionViewCell", for: indexPath ) as! ArchCollectionViewCell
        
        let section = indexPath.section
        
        
        //TODO If I have more time, I will find ways to simplify this part and remove the redundant code. Maybe try to think a way to unite the personal records & virtual races to a generic type. Or having them as the same type, but different flags in the Mock user data, so we can filter them out to two seperate data arrays for different sections.
        
        if section == 0 {
            if let safePersonalRecords = self.personalRecords {
                
                let item = safePersonalRecords.items[indexPath.row]
                
                let value =  item.isCompleted ? ( item.time != "" ? item.time : item.height) : "Not yet"
                
                cell.setData(image: item.image, name: item.name, value: value, isCompleted: item.isCompleted)
                if(!item.isCompleted) {
                    self.personalRecordsCompleted -= 1
                }
            }
        } else if section == 1 {
            if let safeVirtualRaces = self.virtualRaces {
                
                let item = safeVirtualRaces.items[indexPath.row]
                
                let value =  item.isCompleted ? ( item.time != "" ? item.time : item.height) : "Not yet"
                
                cell.setData(image: item.image, name: item.name, value: value, isCompleted: item.isCompleted)
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "archCollectionViewHeader", for: indexPath) as? ArchCollectionViewHeader{
            
            switch(indexPath.section) {
            case 0:
                sectionHeader.setValue(name: "Personal Records", archived: "\(self.personalRecordsCompleted)/\(self.personalRecords!.items.count)")
            case 1:
                sectionHeader.setValue(name: "Virtual Races", archived: nil)
                
            default:
                return UICollectionReusableView()
            }
            
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 60.0, height: 30.0);
    }
}
