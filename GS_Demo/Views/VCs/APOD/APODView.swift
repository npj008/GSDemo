//
//  APODView.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 22/07/22.
//

import UIKit

class APODView: UIView {
    var viewModel: APODViewModelEntity
        
    lazy var tableView: UITableView = {
        let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.bounces = false
        tbl.showsVerticalScrollIndicator = false
        return tbl
    }()
    
    private let photoCellIdentifier = String.init(describing: "PhotoPostTableViewCell")
    
    init(viewModel: APODViewModelEntity) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .yellow
        configureTableView()
    }
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.tableView.scrollsToTop = true
            self.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        addSubview(tableView)
        tableView.accessibilityIdentifier = "table_picture"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(APODCell.self,
                           forCellReuseIdentifier: photoCellIdentifier)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension APODView : UITableViewDataSource,
                     UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.totalCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pictureDetails = viewModel.getCellViewModel(at: indexPath)
        
        switch pictureDetails.type {
        case .photoCell, .videoCell :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: photoCellIdentifier,
                                                           for: indexPath) as? APODCell else {
                fatalError("Cell not exists")
            }
            cell.photoPostCellViewModel = pictureDetails
            cell.selectionStyle = .none
            cell.delegate = self
            cell.playVideo = { [weak self] videoURL in
                self?.viewModel.playVideo(url: videoURL)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension APODView: FavoritablePictureProtocol {
    func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void)) {
        viewModel.toggleFavorite(isFavorite: isFavorite, postDetail: postDetail) { success in
            completion(success)
        }
    }
}
