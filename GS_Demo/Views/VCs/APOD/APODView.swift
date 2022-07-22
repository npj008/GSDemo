//
//  APODView.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 22/07/22.
//

import UIKit

class APODView: UIView {
    var viewModel: APODViewModelEntity
    
    fileprivate let tableview = UITableView()
    
    private let photoCellIdentifier = String.init(describing: "PhotoPostTableViewCell")
    
    init(viewModel: APODViewModelEntity) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .yellow
        configureTableView()
    }
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        addSubview(tableview)
        tableview.accessibilityIdentifier = "table_picture"
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 350.0
        tableview.register(APODCell.self,
                           forCellReuseIdentifier: photoCellIdentifier)

        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
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
        case .photoCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: photoCellIdentifier,
                                                           for: indexPath) as? APODCell else {
                fatalError("Cell not exists")
            }
            cell.photoPostCellViewModel = pictureDetails
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}
