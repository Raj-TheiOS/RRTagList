//
//  ViewController.swift
//  RRTagList
//
//  Created by Raj Rathod on 26/10/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tagTf: UITextField!
    
    private var selectedTags = [String]()
    private var tags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tagTf.delegate = self

        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView.collectionViewLayout = layout
    }
}

extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell",
                                                            for: indexPath) as? TagCollectionViewCell else {
            return TagCollectionViewCell()
        }
        cell.tagLabel.text = tags[indexPath.row]
        cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 50
        
        cell.deleteButton.row = indexPath.row
        cell.deleteButton.section = indexPath.section
        cell.deleteButton.addTarget(self, action:#selector(deleteTapped(_:)), for: .touchUpInside)
        
        if selectedTags.contains(tags[indexPath.row]) {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .none
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell, let text = cell.tagLabel.text else {return}
        
        if selectedTags.contains(text) {
            selectedTags = selectedTags.filter{$0 != text}
        } else {
            selectedTags.append(text)
        }
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: 30)
    }
}

extension ViewController {
    @objc func deleteTapped(_ sender: CustomButton) {
        let indexPath = IndexPath(row: sender.row, section: sender.section)
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell, let text = cell.tagLabel.text else {return}
        selectedTags = selectedTags.filter{$0 != text}
        tags.remove(at: indexPath.row)
        collectionView.reloadData()
    }
}
extension ViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isValid() {
            if self.tags.contains(textField.text ?? "") {
                print("Tag Already exists...")
            } else {
                self.tags.append(textField.text ?? "")
            }
            self.collectionView.reloadData()
            let section = 0
            let item = collectionView.numberOfItems(inSection: section) - 1
            let lastIndexPath = IndexPath(item: item, section: section)
            collectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: true)
            self.tagTf.text = ""
        }
        return true
    }
    // MARK:- Validating input fields
    func isValid() -> Bool {
        if tagTf.text?.isEmpty ?? false {
            print("empty tag")
            return false
        }
        return true
    }
}

