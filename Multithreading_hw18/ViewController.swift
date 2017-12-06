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
    
    let arraysImages = [["https://wallpaperbrowse.com/media/images/maxresdefault_9As8F3D.jpg",
                        "https://wallpaperbrowse.com/media/images/pexels-photo-46710.jpeg",
                        "https://wallpaperbrowse.com/media/images/babyanimal_open.ngsversion.1429194155981_SuGiZb5.jpg",
                        "https://wallpaperbrowse.com/media/images/maxresdefault_9As8F3D.jpg"],
                        
                        ["https://wallpaperbrowse.com/media/images/maxresdefault_9As8F3D.jpg",
                         "https://wallpaperbrowse.com/media/images/pexels-photo-46710.jpeg",
                         "https://wallpaperbrowse.com/media/images/RT-week-in-pictures-cricket-jef-170104_22x15_1600.jpg",
                         "https://wallpaperbrowse.com/media/images/ss-160812-twip-02_3380f5e9d30b766138155f8c3f11f9a8.nbcnews-fp-1200-800.jpg"],
                        
                        ["https://wallpaperbrowse.com/media/images/maxresdefault_9As8F3D.jpg",
                         "https://wallpaperbrowse.com/media/images/pexels-photo-46710.jpeg",
                         "https://wallpaperbrowse.com/media/images/81.jpg",
                         "https://wallpaperbrowse.com/media/images/CuDLNqmWEAEJzGe.jpg"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
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
        
        
    }
}

