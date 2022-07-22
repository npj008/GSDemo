//
//  APODCell.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 22/07/22.
//

import UIKit

protocol PhotoPostTableViewCellDelegate: AnyObject {
    func selectNewImage(id: String)
    func removeExistingImage(id: String)
    func navigateToImageDetails(path: String)
}

class APODCell: UITableViewCell {
    weak var delegate: PhotoPostTableViewCellDelegate?
    
    var selecteImagethumbnail: UIImage?
    
    var photoPostCellViewModel : APODCellViewModel? {
        didSet {
            setupContent()
        }
    }
    
    let addRemoveButton = UIButton()
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "placeholder")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    lazy var alphaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var photoDate: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textColor = .label
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var detailStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setContentCompressionResistancePriority(.required, for: .vertical)
        stack.addArrangedSubview(photoTitle)
        stack.addArrangedSubview(photoExplaination)
        return stack
    }()
    
    lazy var photoTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.text = "tittltltllt"
        lbl.textColor = .label
        lbl.numberOfLines = 0
        lbl.clipsToBounds = true
        return lbl
    }()
    
    lazy var photoExplaination: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .red
        lbl.textColor = .label
        lbl.text = "explaination"
        lbl.numberOfLines = 0
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
        contentView.layer.cornerRadius = 15.0
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
        
        imgView.addSubview(alphaView)
        alphaView.leadingAnchor.constraint(equalTo: imgView.leadingAnchor).isActive = true
        alphaView.trailingAnchor.constraint(equalTo: imgView.trailingAnchor).isActive = true
        alphaView.bottomAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 0.0).isActive = true
        alphaView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        imgView.addSubview(photoDate)
        photoDate.translatesAutoresizingMaskIntoConstraints = false
        photoDate.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: 20.0).isActive = true
        photoDate.trailingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: -20.0).isActive = true
        photoDate.bottomAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -5.0).isActive = true
        photoDate.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        contentView.addSubview(detailStackView)
        detailStackView.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10.0).isActive = true
        detailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0).isActive = true
        detailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0).isActive = true
        detailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
        
        imgView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
    }
    
    @objc func buttonTapped(sender: UIButton) {
        guard let vm = photoPostCellViewModel else { return }
        //
    }
    
    private func setupContent() {
        photoDate.text = photoPostCellViewModel?.post.title
        photoExplaination.text = photoPostCellViewModel?.post.explanation
        photoDate.text = photoPostCellViewModel?.post.date
        spinner.startAnimating()
        
        photoPostCellViewModel?.fetchCellImage(completion: { [weak self] img, success in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.imgView.image = img
            }
        })
    }
    
    private func getThumbImage(mainPath: URL) -> UIImage? {
        let prefixx = mainPath.absoluteString.replacingOccurrences(of: mainPath.lastPathComponent, with: "thumb_\(mainPath.lastPathComponent)")
        if let url = URL(string: prefixx),
           let image = UIImage(contentsOfFile: url.path) {
            return image
        }
        return nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
