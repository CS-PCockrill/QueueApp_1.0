//
//  DetailedItemController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit
import PullToDismiss

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

class DetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let photoId = "headerId"
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // FIXME: Code to make variables in detailView show current item details
    var appId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
                let app = result?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
        }
    }
    
    var app: Result?
    private var pullToDismiss: PullToDismiss?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .rgb(red: 237, green: 236, blue: 236)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        collectionView.contentInsetAdjustmentBehavior = .never
//        self.navigationController?.isNavigationBarHidden = true
        
        pullToDismiss = PullToDismiss(scrollView: self.collectionView)
        pullToDismiss?.delegate = self
        pullToDismiss?.dismissableHeightPercentage = 0.1
        pullToDismiss?.backgroundEffect = BlurEffect(color: .black, alpha: 1, blurRadius: 30.0, saturationDeltaFactor: 1.0)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ItemHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: photoId)
        collectionView.register(ItemDetailsCell.self, forCellWithReuseIdentifier: cellId)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(handleBack))
        self.navigationItem.leftBarButtonItem?.tintColor = .white

        self.navigationController?.toolbar.barStyle = .blackTranslucent;
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.title = "TEST"
    }
    
    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150
        if offset > 2 {
            offset = 2
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationItem.leftBarButtonItem?.tintColor = .black
            self.navigationController?.navigationItem.title = self.app?.trackName
        } else if offset == 0 {
            self.navigationItem.leftBarButtonItem?.tintColor = .white
        } else {
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: offset)
            self.navigationController?.navigationItem.title = self.app?.trackName
        }
    }
    
    var headerView: ItemHeader?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: photoId, for: indexPath) as? ItemHeader
        headerView?.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        
        return headerView!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemDetailsCell
        
        cell.nameLabel.text = app?.trackName
        cell.descriptionLabel.text = app?.releaseNotes
        cell.priceLabel.text = app?.formattedPrice
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // calculate the necessary size for our cells
        let dummyCell = ItemDetailsCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        dummyCell.nameLabel.text = app?.trackName
        dummyCell.priceLabel.text = app?.formattedPrice
        dummyCell.descriptionLabel.text = app?.releaseNotes
        dummyCell.layoutIfNeeded()
        
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 400))
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
}

class ItemHeader: UICollectionReusableView {
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "toyota2019"))
        view.contentMode = .scaleAspectFill
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Custom code for layout
        self.backgroundColor = .red
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    var animator: UIViewPropertyAnimator!
    
    fileprivate func setupVisualEffectBlur() {
        // Treat this as the end state of our animation
        

//        animator.fractionComplete = 0.5
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
