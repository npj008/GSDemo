//
//  PhotoViewController.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 24/07/22.
//

import Foundation
import UIKit

// MARK: - PhotoViewController

class PhotoViewController: BaseViewController {

    struct Constants {
        static let title = "Photo View"
    }
    
    private lazy var lauoutGuide = view.safeAreaLayoutGuide
    var viewModel: PhotoViewModelEntity = PhotoViewModel()
    lazy var zoomGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomImage(sender:)))
    
    var currentPost: PictureDetails? {
        didSet {
            viewModel.pictureDetails = currentPost
        }
    }
    
    // MARK: - UI Elemets
    
    lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(systemName: "play")
        btn.setBackgroundImage(img, for: .normal)
        btn.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        btn.tintColor = .white
        btn.isHidden = true
        return btn
    }()
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = GlobalConstants.placeholderImage
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = Constants.title
        view.backgroundColor = .systemBackground
        
        let saveButton = UIBarButtonItem(title: "Close",
                                         style: .done,
                                         target: self,
                                         action: #selector(resetCache))
        self.navigationItem.rightBarButtonItem  = saveButton
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        setupUI()
        configureViewModel()
    }
   
    func configureViewModel() {
        viewModel.toggleLoadingStatus = { [weak self] isLoading, loadingMessage in
            DispatchQueue.main.async {
                self?.view.showUniversalLoadingView(isLoading, loadingText: loadingMessage)
            }
        }
        
        viewModel.refreshUI = { [weak self] in
            DispatchQueue.main.async {
                self?.imgView.image = self?.viewModel.currentImage
            }
        }
        
        viewModel.loadPhotoView()
    }
    
    private func setupUI() {
        setupImageView()
    }
    
    private func setupImageView() {
        view.addSubview(imgView)
        imgView.accessibilityIdentifier = "img_full_screen"
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: lauoutGuide.topAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo: lauoutGuide.leadingAnchor, constant: 10.0).isActive = true
        imgView.trailingAnchor.constraint(equalTo: lauoutGuide.trailingAnchor, constant: -10.0).isActive = true
        imgView.bottomAnchor.constraint(equalTo: lauoutGuide.bottomAnchor).isActive = true
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(zoomGesture)
    }
    
    // MARK: - UI Action Methods
    
    @objc func closeTapped(sender: UIButton) {
        viewModel.closePhotoView()
    }
    
    @objc func resetCache(){
        viewModel.closePhotoView()
    }
    
    @objc func zoomImage(sender: UIPinchGestureRecognizer) {
        guard sender.view != nil else { return }
        
        if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)) {
            guard scale.a > 1.0 else { return }
            guard scale.d > 1.0 else { return }
            sender.view?.transform = scale
            sender.scale = 1.0
        }
    }
}
