//
//  ItemDetailsController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//
import UIKit

class ItemDetailsController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let cellId = "cellId"
    let addCellId = "addCellId"
    
    var items: ItemImageCell?
    var images = [UIImage]()
    let dispatchGroup = DispatchGroup()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.contentSize.height = 700
        sv.backgroundColor = UIColor.white
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let shareGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleShare))
//        shareGesture.numberOfTapsRequired = 1
        
        view.backgroundColor = .white
        navigationController?.isToolbarHidden = true
        navigationController?.toolbar.isTranslucent = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        navigationItem.title = "New Listing"
        
        navigationController?.toolbar.barTintColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        // Add gesture recognizer to toolbar...
//        self.navigationController?.toolbar.addGestureRecognizer(shareGesture)
//        self.navigationController?.toolbar.addSubview(shareButton)
//        shareButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 10, paddingBottom: 2, paddingRight: 10, width: (view.frame.width), height: 44)
        
        view.addSubview(scrollView)

        setupScrollView()
        
        //        setupHeaderViews()
    }
    
    let shareButton: UILabel = {
        let ab = UILabel()
        //        ab.setTitle("Apply", for: .normal)
        //        ab.setTitleColor(.white, for: .normal)
        ab.text = "Share"
        ab.font = UIFont.boldSystemFont(ofSize: 20)
        ab.textColor = .white
        ab.textAlignment = .center
        ab.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        //        ab.layer.cornerRadius = 7.5
        ab.layer.masksToBounds = true
        return ab
    }()
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    var imageUrlArray = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // count + 1 recognizes the add Photo button...
        let count = images.count + 1
        if count != 0 {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == images.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addCellId, for: indexPath) as! AddImageCell
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemImageCell
            cell.configureImageCell(image: images[indexPath.row])
            //            cell.image = images
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = view.frame.width
        if images.count > 0 {
            return CGSize(width: (width - 25) / 2, height: height)
        } else {
            return CGSize(width: width - 20, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == images.count {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Zooming Image")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.insert(originalImage, at: 0)
            //            imagesCollection.insert(Image(imageName: originalImage), at: 0)
            itemsCollectionView.reloadData()
        } else if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            images.insert(editedImage, at: 0)
            //            imagesCollection.insert(Image(imageName: editedImage), at: 0)
            itemsCollectionView.reloadData()
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let profileImageView: UIImageView = {
        let pv = UIImageView()
        pv.backgroundColor = .red
        pv.contentMode = .scaleAspectFill
        pv.layer.cornerRadius = 45 / 2
        pv.layer.masksToBounds = true
        pv.clipsToBounds = true
        return pv
    }()
    
    let profileNameLabel: UILabel = {
        let pl = UILabel()
        pl.text = "Patrick Cockrill"
        pl.font = UIFont.boldSystemFont(ofSize: 17)
        pl.textColor = .black
        return pl
    }()
    
    let listingLabel: UILabel = {
        let listing = UILabel()
        listing.text = "Listing on Queue"
        listing.font = UIFont.systemFont(ofSize: 14)
        listing.textColor = .darkGray
        return listing
    }()
    
    let maxImageLabel: UILabel = {
        let label = UILabel()
        label.text = "0/5 Images"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let itemTitle: UITextField = {
        let title = UITextField()
        //        title.placeholder = "Title"
        return title
    }()
    
    let priceTitle: UITextField = {
        let title = UITextField()
        //        title.placeholder =
        return title
    }()
    
    let categoryTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let descriptionText: UITextView = {
        let title = UITextView()
        title.font = UIFont.systemFont(ofSize: 17)
        return title
    }()
    
    let itemDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Item details"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let pickUpAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery information"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 31, green: 87, blue: 245)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 8
        button.setTitle("Next", for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.tintColor = .white
        return button
    }()
    
    let optionalLabel: UILabel = {
        let label = UILabel()
        label.text = "Optional"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        
        return label
    }()
    
    var viewController = DeliveryInformationController()
    let switchOnOff = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))

    @objc func handleNext() {
        if (switchStateDidChange(switchOnOff)) {
            let layout = UICollectionViewFlowLayout()
            let controller = DeliveryInformationController(collectionViewLayout: layout)
            
            let navController = UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle = .popover
            self.present(navController, animated: true, completion: nil)
        } else {
            let layout = UICollectionViewFlowLayout()
            let controller = PreviewController(collectionViewLayout: layout)
            
            let navController = UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle = .popover
            self.present(navController, animated: true, completion: nil)
        }
        
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch) -> Bool {
        if (sender.isOn == true){
            return true
        }
        else{
            return false
        }
    }
    
    let categoriesLauncher = CategoriesLauncher()
    
    @objc func handleOpenCategories() {
        categoriesLauncher.showCategories()
    }
    
    private func setupScrollView() {
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        itemsCollectionView.register(ItemImageCell.self, forCellWithReuseIdentifier: cellId)
        itemsCollectionView.register(AddImageCell.self, forCellWithReuseIdentifier: addCellId)
        
        let categoryTouchEvent:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleOpenCategories))
        categoryTouchEvent.numberOfTapsRequired = 1

        let imageView = UIView()
        imageView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = UIColor.lightGray
        let titleView = UIView()
        titleView.backgroundColor = .white
        titleView.clipsToBounds = true
        titleView.layer.borderColor = UIColor.lightGray.cgColor
        titleView.layer.cornerRadius = 7.5
        titleView.layer.borderWidth = 0.5
        
        let priceLabel = UILabel()
        priceLabel.text = "Price"
        priceLabel.font = UIFont.systemFont(ofSize: 17)
        priceLabel.textColor = UIColor.lightGray
        let priceView = UIView()
        priceView.backgroundColor = .white
        priceView.clipsToBounds = true
        priceView.layer.borderColor = UIColor.lightGray.cgColor
        priceView.layer.cornerRadius = 7.5
        priceView.layer.borderWidth = 0.5
        
        let categoryLabel = UILabel()
        categoryLabel.text = "Category"
        categoryLabel.font = UIFont.systemFont(ofSize: 17)
        categoryLabel.textColor = .lightGray
        let categoryView = UIView()
        categoryView.clipsToBounds = true
        categoryView.layer.borderColor = UIColor.lightGray.cgColor
        categoryView.backgroundColor = .white
        categoryView.layer.borderWidth = 0.5
        categoryView.layer.cornerRadius = 7.5
        categoryView.isUserInteractionEnabled = true
        categoryView.addGestureRecognizer(categoryTouchEvent)
        
        let descriptionTitle = UILabel()
        descriptionTitle.text = "Description"
        descriptionTitle.font = UIFont.systemFont(ofSize: 17)
        descriptionTitle.textColor = .lightGray
        let descriptionView = UIView()
        descriptionView.clipsToBounds = true
        descriptionView.backgroundColor = .white
        descriptionView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionView.layer.borderWidth = 0.5
        descriptionView.layer.cornerRadius = 7.5
        
//        let switchOnOff = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
        switchOnOff.addTarget(self, action: #selector(ItemDetailsController.switchStateDidChange(_:)), for: .valueChanged)
        switchOnOff.setOn(true, animated: false)
        self.scrollView.addSubview(switchOnOff)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 225)
        
        imageView.addSubview(itemsCollectionView)
        itemsCollectionView.backgroundColor = .white
        itemsCollectionView.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(itemTitle)
        
        scrollView.addSubview(priceView)
        priceView.addSubview(priceLabel)
        priceView.addSubview(priceTitle)
        
        scrollView.addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        categoryView.addSubview(categoryTitle)
        
        scrollView.addSubview(descriptionView)
        descriptionView.addSubview(descriptionTitle)
        descriptionView.addSubview(descriptionText)
        
        scrollView.addSubview(nextButton)
        
        // Post title views
        titleView.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: (view.frame.width - 20) * 0.66, height: 65)
        titleLabel.anchor(top: titleView.topAnchor, left: titleView.leftAnchor, bottom: itemTitle.topAnchor, right: titleView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        itemTitle.anchor(top: titleLabel.bottomAnchor, left: titleView.leftAnchor, bottom: titleView.bottomAnchor, right: titleView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0 , height: 0)
        //  =========================================================================================
        
        // Post price views
        priceView.anchor(top: titleView.topAnchor, left: titleView.rightAnchor, bottom: titleView.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        priceLabel.anchor(top: priceView.topAnchor, left: priceView.leftAnchor, bottom: priceTitle.topAnchor, right: priceView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        priceTitle.anchor(top: priceLabel.bottomAnchor, left: priceView.leftAnchor, bottom: priceView.bottomAnchor, right: priceView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // =========================================================================================
        
        // Post category views
        categoryView.anchor(top: titleView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 65)
        categoryLabel.anchor(top: categoryView.topAnchor, left: categoryView.leftAnchor, bottom: categoryTitle.topAnchor, right: categoryView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        categoryTitle.anchor(top: categoryLabel.bottomAnchor, left: categoryView.leftAnchor, bottom: categoryView.bottomAnchor, right: categoryView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        // =========================================================================================
        
        // Post description views
        descriptionView.anchor(top: categoryView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 150)
        descriptionTitle.anchor(top: descriptionView.topAnchor, left: descriptionView.leftAnchor, bottom: descriptionText.topAnchor, right: descriptionView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        descriptionText.anchor(top: descriptionTitle.bottomAnchor, left: descriptionView.leftAnchor, bottom: descriptionView.bottomAnchor, right: descriptionView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 0)
        
        //  =========================================================================================
        nextButton.anchor(top: descriptionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 42)
        
        switchOnOff.anchor(top: nextButton.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 60, height: 42)

        //        scrollView.addSubview(stackView)
        //        stackView.anchor(top: descriptionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 225)
        
    }
    
}

