//
//  ExpendingCollectionVC.swift
//  ExpendingCellOnCollectionView
//
//  Created by Appinventiv Technologies on 04/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class ExpendingCollectionVC: UIViewController {
//================= Outlet's ==================
    @IBOutlet weak var collectionView: UICollectionView!
    //----------------- Variable's ----------------
    let  dataInSectionHeader = ["BiCycle's","Bike's","Car's"]
    let biCycleArray = ["Atlas","Avon","Hero","TrekBicycle"]
    let bikeArray = ["CRF","F3","Fazer","Glamour","Street Triple","z1"]
    let carArray = ["Ford","Swift","Vitara"]
    var expandedSections : NSMutableSet = []
    var clickOnButton = false
//----------------- ViewDidLoad ---------------
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
//----------------- Button Action,s ------------------
    @IBAction func buttonOnHeader(_ sender: UIButton) {
        print("section Tapped")
        let section = sender.tag
        print(section)
        let shouldExpand = !expandedSections.contains(section)
        if (shouldExpand) {
           
            expandedSections.remove(section)
            expandedSections.add(section)
        } else {
            expandedSections.remove(section)
        }
        self.collectionView.reloadSections([section])
        
    }
//----------- Gird Button On cell header -----------
    
    @IBAction func girdButton(_ sender: UIButton) {
        if clickOnButton == false{
            clickOnButton = true
        }else{
            clickOnButton = false
        }
        collectionView.reloadData()
    }
    

}
//============== Extension of class ===============
extension ExpendingCollectionVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
//    ----------------------- Method's of collectionview ----------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataInSectionHeader.count
    }
    
//    --------------------- For section on header -----------------
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      guard  let obOfHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderClass", for: indexPath) as? HeaderClass else{fatalError()}
        obOfHeader.buttonOnHeader.tag = indexPath.section
        obOfHeader.girdButton.tag = indexPath.section
        obOfHeader.headerLabel.text = dataInSectionHeader[indexPath.section]
        return obOfHeader
    }
//    -------------------- For number of cell's --------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch section {
            case 0:
                return biCycleArray.count
            case 1:
                return bikeArray.count
            default:
                return carArray.count
            }
        } else {
            return 0
        }
    }
//   ----------------------- Cell for Row's -------------------
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellData", for: indexPath) as? CellData else{
            fatalError()
        }
        switch indexPath.section {
        case 0:
            cell.imageInCell.image = UIImage(named: biCycleArray[indexPath.row])
            cell.imageNameLabel.text = biCycleArray[indexPath.row]
        case 1:
            cell.imageInCell.image = UIImage(named: bikeArray[indexPath.row])
            cell.imageNameLabel.text = bikeArray[indexPath.row]
        default:
            cell.imageInCell.image = UIImage(named: carArray[indexPath.row])
            cell.imageNameLabel.text = carArray[indexPath.row]
        }
        return cell
    }
//    ---------------- Set height and width while clicking on grid button -------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard  let obOfHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderClass", for: indexPath) as? HeaderClass else{fatalError()}
        if self.clickOnButton == false{
//            obOfHeader.girdButton.setTitle("Table", for: .normal)
            return CGSize(width: 200, height: 170)
        }else{
            let cellWidth = UIScreen.main.bounds.size.width
            return CGSize(width: cellWidth, height: 100)
//            obOfHeader.girdButton.setTitle("Grid", for: .normal)

        }
        
    }
    
}
//================== Class for CollectionCell ================
class CellData: UICollectionViewCell {
//    ------------ Outlet's ------------
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    
    
}
//================== Class for cell header =================
class HeaderClass: UICollectionReusableView {
    @IBOutlet weak var buttonOnHeader: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var girdButton: UIButton!
    
}

























