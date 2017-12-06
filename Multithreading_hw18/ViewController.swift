//
//  ViewController.swift
//  Multithreading_hw18
//
//  Created by Sergey Intern  on 12/5/17.
//  Copyright © 2017 Sergey Intern . All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    enum TypeItem: Int {
        case firstItem, secondItem, thirdItem
    }
    
    @IBOutlet private weak var ibStackView: UIStackView!
    
    @IBOutlet private var ibImageCollections: [UIImageView]!
    @IBOutlet var ibActivityIndicatorCollections: [UIActivityIndicatorView]!
    
    private let arraysImages = [["https://wallpaperbrowse.com/media/images/maxresdefault_9As8F3D.jpg",
                                 "https://wallpaperbrowse.com/media/images/pexels-photo-46710.jpeg",
                                 "https://wallpaperbrowse.com/media/images/babyanimal_open.ngsversion.1429194155981_SuGiZb5.jpg",
                                 "https://wallpaperbrowse.com/media/images/maxresdefault_9As8F3D.jpg"],
                                
                                ["https://wallpaperbrowse.com/media/images/14-love-pictures.preview.jpg",
                                 "https://wallpaperbrowse.com/media/images/pictures-8.jpg",
                                 "https://wallpaperbrowse.com/media/images/RT-week-in-pictures-cricket-jef-170104_22x15_1600.jpg",
                                 "https://wallpaperbrowse.com/media/images/ss-160812-twip-02_3380f5e9d30b766138155f8c3f11f9a8.nbcnews-fp-1200-800.jpg"],
                                
                                ["https://wallpaperbrowse.com/media/images/h5_1998.440.jpg",
                                 "https://wallpaperbrowse.com/media/images/5838e35952fa8d7f3ac98d4178b05667.jpg",
                                 "https://wallpaperbrowse.com/media/images/81.jpg",
                                 "https://wallpaperbrowse.com/media/images/CuDLNqmWEAEJzGe.jpg"]]
    
    var indexPressed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        loadAllImages()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    // MARK: - Private methods
    private func getImageBy(item: TypeItem) -> UIImageView {
       return ibImageCollections[item.rawValue]
    }
    
    private func getActivityIndicatorBy(item: TypeItem) -> UIActivityIndicatorView {
        return ibActivityIndicatorCollections[item.rawValue]
    }
    
    private func getArrayImagesBy(item: TypeItem) -> [String] {
        return arraysImages[item.rawValue]
    }
    
    private func loadImageFor(item: TypeItem) {
        let ibImage = getImageBy(item: item)
        ibImage.image = nil
        let arrayUrlString = getArrayImagesBy(item: item)

        guard indexPressed >= 0, indexPressed < arrayUrlString.count else { return }
        
         let urlString = arrayUrlString[indexPressed]
        
        guard let urlImage = URL(string: urlString) else { return }
        getActivityIndicatorBy(item: item).startAnimating()
        DispatchQueue.global().async { [weak self] in
            guard let dataImage = try? Data(contentsOf: urlImage) else {
                self?.stopActivityIndicatorFor(item: item)
                return
            }
            let image = UIImage(data: dataImage)
            
            DispatchQueue.main.async {
                ibImage.image = image
                self?.stopActivityIndicatorFor(item: item)
            }
        }
    }
    
    private func loadAllImages() {
        loadImageFor(item: .firstItem)
        loadImageFor(item: .secondItem)
        loadImageFor(item: .thirdItem)
    }
    
    private func stopActivityIndicatorFor(item: TypeItem) {
        DispatchQueue.main.async {[weak self] in
            self?.getActivityIndicatorBy(item: item).stopAnimating()
        }
    }
    
    // MARK: - UIDeviceOrientationDidChange
    @objc private func rotated() {
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            ibStackView.axis = .vertical
        } else if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            ibStackView.axis = .horizontal
        }
    }

    // MARK: - Actions
    @IBAction func refrechAction(_ sender: Any) {
        indexPressed = (indexPressed + 1) % 4
        loadAllImages()
    }
}

