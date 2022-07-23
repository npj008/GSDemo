//
//  APODCell.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 22/07/22.
//

import UIKit

protocol FavoritablePictureProtocol: AnyObject {
    func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void))
}

enum LikeState: Int {
    case liked = 100
    case normal = 200
}

class APODCell: UITableViewCell {
    weak var delegate: FavoritablePictureProtocol?
    
    var selecteImagethumbnail: UIImage?
    
    var photoPostCellViewModel : APODCellViewModel? {
        didSet {
            setupContent()
        }
    }
    
    var playVideo: ((URL) -> ())?
    private let likeFilledImage = UIImage(named: "like")
    private let likeEmptyImage = UIImage(named: "unlike")
    private let loadingImage = UIImage(named: "loading")
    private let placeholder = UIImage(named: "placeholder")
    
    lazy var likeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 200
        btn.setImage(likeEmptyImage, for: .normal)
        btn.tintColor = .systemRed
        btn.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var playVideoButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(systemName: "play")
        btn.setBackgroundImage(img, for: .normal)
        btn.addTarget(self, action: #selector(playVideoTapped), for: .touchUpInside)
        btn.tintColor = .label
        btn.isHidden = true
        return btn
    }()
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = placeholder
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    lazy var alphaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground.withAlphaComponent(0.9)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var photoDate: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textColor = .label
        lbl.font = .preferredFont(forTextStyle: .title1)
        lbl.numberOfLines = 1
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var detailStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 5.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setContentCompressionResistancePriority(.required, for: .vertical)
        stack.addArrangedSubview(photoTitle)
        stack.addArrangedSubview(photoExplaination)
        return stack
    }()
    
    lazy var photoTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .white
        lbl.textColor = .label
        lbl.text = photoPostCellViewModel?.post.title
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .preferredFont(forTextStyle: .title3)
        lbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0).isActive = true
        lbl.clipsToBounds = true
        return lbl
    }()
    
    lazy var photoExplaination: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .systemGray.withAlphaComponent(0.1)
        lbl.textColor = .label
        lbl.text = "explaination"
        lbl.numberOfLines = 0
        lbl.text = photoPostCellViewModel?.post.explanation
        lbl.font = .preferredFont(forTextStyle: .body)
        lbl.setContentCompressionResistancePriority(.required, for: .vertical)
        lbl.layer.cornerRadius = 5.0
        lbl.clipsToBounds = true
        return lbl
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView()
        act.translatesAutoresizingMaskIntoConstraints = false
        act.color = .label
        act.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        return act
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        setupUI()
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {

        contentView.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0).isActive = true
        imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        let width = UIScreen.main.bounds.width
        imgView.heightAnchor.constraint(equalToConstant: width).isActive = true
        
        imgView.addSubview(alphaView)
        alphaView.leadingAnchor.constraint(equalTo: imgView.leadingAnchor).isActive = true
        alphaView.trailingAnchor.constraint(equalTo: imgView.trailingAnchor).isActive = true
        alphaView.topAnchor.constraint(equalTo: imgView.topAnchor, constant: 0.0).isActive = true
        alphaView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        imgView.isUserInteractionEnabled = true
        
        imgView.addSubview(photoDate)
        photoDate.translatesAutoresizingMaskIntoConstraints = false
        photoDate.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: 10.0).isActive = true
        photoDate.trailingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: -50.0).isActive = true
        photoDate.topAnchor.constraint(equalTo: alphaView.topAnchor, constant: 0.0).isActive = true
        photoDate.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        contentView.addSubview(detailStackView)
        detailStackView.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10.0).isActive = true
        detailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        detailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        detailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
        
        imgView.addSubview(likeButton)
        likeButton.trailingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: -10.0).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: alphaView.centerYAnchor).isActive = true
        
        contentView.addSubview(playVideoButton)
        playVideoButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        playVideoButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        playVideoButton.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
        playVideoButton.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true

        imgView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
    }
    
    @objc func likeTapped(sender: UIButton) {
        guard let vm = photoPostCellViewModel else {
            return
        }
        
        let isFavorite = sender.tag == 100
        sender.setImage(loadingImage, for: .normal)
        delegate?.toggleFavorite(isFavorite: !isFavorite,
                                 postDetail: vm.post) { [weak self] success in
            if !success {
                //
            } else {
                self?.updateButtonState(sender: sender)
            }
        }
    }
    
    @objc func playVideoTapped(sender: UIButton) {
        guard let vm = photoPostCellViewModel, vm.type == .videoCell ,
        let urlString = vm.post.url,
        let videoUrl = URL(string: urlString) else {
            return
        }
        playVideo?(videoUrl)
    }
    
    private func updateButtonState(sender: UIButton) {
        DispatchQueue.main.async { [weak self] in
            let state = LikeState(rawValue: sender.tag)
            switch state {
            case .liked:
                self?.setButton(isFavorite: false)
            case .normal:
                self?.setButton(isFavorite: true)
            default:
                break
            }
        }
    }
    
    private func setupContent() {
        photoDate.text = photoPostCellViewModel?.post.date
        photoExplaination.text = photoPostCellViewModel?.post.explanation
        photoTitle.text = photoPostCellViewModel?.post.title
        
        self.imgView.alpha = 0.2
        if photoPostCellViewModel?.type == .photoCell {
            spinner.startAnimating()
            playVideoButton.isHidden = true
            photoPostCellViewModel?.fetchCellImage(completion: { [weak self] img, success in
                DispatchQueue.main.async {
                    self?.imgView.alpha = 1.0
                    self?.spinner.stopAnimating()
                    self?.imgView.image = img
                }
            })
        } else {
            imgView.image = placeholder
            playVideoButton.isHidden = false
        }
        
        if photoPostCellViewModel?.getCurrentFavoriteStatus() ?? false {
            self.setButton(isFavorite: true)
        } else {
            self.setButton(isFavorite: false)
        }
    }
    
    private func setButton(isFavorite: Bool) {
        if isFavorite {
            likeButton.tag = 100
            likeButton.setImage(self.likeFilledImage, for: .normal)

        } else {
            likeButton.tag = 200
            likeButton.setImage(self.likeEmptyImage, for: .normal)
        }
    }
}
