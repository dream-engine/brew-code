//
//  BeerSegmentHeaderCell.swift
//  BrewCode
//
//  Created by Mohit Kumar Singh on 12/07/23.
//

import UIKit

// MARK: BeerSegmentHeaderCellProtocol
protocol BeerSegmentHeaderCellProtocol: AnyObject {
    func didSelect(filter: String)
}

// MARK: BeerSegmentHeaderCell
class BeerSegmentHeaderCell: TableHeaderFooterView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundBlurView: UIView!
    
    var cellModels: [Any] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupCollectionView()
    }
    
    override func configure(_ item: Any?) {
        if let item = self.item as? BeerSegmentHeaderCellModel {
            self.cellModels = item.cellModels
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: Helper Functions
extension BeerSegmentHeaderCell {
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.collectionView.backgroundColor = .clear
        self.containerView.backgroundColor = .clear
        self.backgroundBlurView.backgroundColor = .clear
        
        self.backgroundBlurView.addBlur(withStyle: .systemUltraThinMaterialDark, andCornerRadius: 0)
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.registerCell(BeerSegmentCollectionCell.self)
    }
}

// MARK: UICollectionViewDelegate
extension BeerSegmentHeaderCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.updateItems(withIndexPath: indexPath)
        
    }
    
    private func updateItems(withIndexPath indexPath: IndexPath) {
        for cellModel in self.cellModels {
            if let cellModel = cellModel as? BeerSegmentCollectionCellModel {
                cellModel.isSelected = false
            }
        }
        
        let cellModel = self.cellModels[indexPath.row] as? BeerSegmentCollectionCellModel
        cellModel?.isSelected = true
        
        self.collectionView.reloadData()
        
        if let delegate = self.delegate as? BeerSegmentHeaderCellProtocol {
            delegate.didSelect(filter: cellModel?.title ?? "")
        }
        
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
}

// MARK: UICollectionViewDataSource
extension BeerSegmentHeaderCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let identifier = self.identifier() else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewCell
        cell.item = self.cellModels[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    private func identifier() -> String? {
        return BeerSegmentCollectionCell.reuseIdentifier
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension BeerSegmentHeaderCell: UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let item = self.cellModels[indexPath.row] as? BeerSegmentCollectionCellModel {
            return CGSize(
                width: item.title.size(
                    withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 40,
                height: 50)
            
        }
        
        return .zero
    }
}
