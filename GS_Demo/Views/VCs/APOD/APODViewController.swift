//
//  APODViewController.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import UIKit

class APODViewController: BaseViewController {

    struct Constants {
        static let title = "APOD"
        static let rightNavButtonTitle = "Reset Cache"
        static let segmentAccessibilityID = "segment"
        static let dateAccessibilityID = "view_date"
        static let apodViewAccessibilityID = "view_apod"
    }
    
    private lazy var apodView = APODView(viewModel: self.viewModel)
    
    private var dateViewHeightConstraint: NSLayoutConstraint?
    private var dateViewBottomConstraint: NSLayoutConstraint?

    lazy var segmentControl: UISegmentedControl = {
       let segment = UISegmentedControl(items: ["Search", "Favorite"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    lazy var dateSelector: DateSelectorView = {
       let dateSelect = DateSelectorView()
        dateSelect.translatesAutoresizingMaskIntoConstraints = false
        return dateSelect
    }()
    
    var viewModel: APODViewModelEntity = APODViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = Constants.title
        setupUI()
        configureViewModel()
        
        let saveButton = UIBarButtonItem(title: Constants.rightNavButtonTitle,
                                         style: .done,
                                         target: self,
                                         action: #selector(saveResponse))
        self.navigationItem.rightBarButtonItem  = saveButton
    }
    
    func configureViewModel() {
        apodView.viewModel = viewModel
        viewModel.refreshUI = { [weak self] in
            self?.apodView.refreshUI()
        }
        viewModel.initialise()
    }
    
    private func setupUI() {
        setupSegment()
        setupDateSelector()
        setupAPODView()
    }
    
    private func setupSegment() {
        view.addSubview(segmentControl)
        segmentControl.accessibilityIdentifier = Constants.segmentAccessibilityID
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    private func setupDateSelector() {
        view.addSubview(dateSelector)
        dateSelector.accessibilityIdentifier = Constants.dateAccessibilityID
        dateSelector.translatesAutoresizingMaskIntoConstraints = false
        dateSelector.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10.0).isActive = true
        dateSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dateSelector.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dateViewHeightConstraint = dateSelector.heightAnchor.constraint(equalToConstant: 50.0)
        dateViewHeightConstraint?.isActive = true
    }
    
    private func setupAPODView() {
//        apodView = APODView(viewModel: viewModel)
        view.addSubview(apodView)
        apodView.accessibilityIdentifier = Constants.apodViewAccessibilityID
        apodView.translatesAutoresizingMaskIntoConstraints = false
        dateViewBottomConstraint = apodView.topAnchor.constraint(equalTo: dateSelector.bottomAnchor, constant: 10.0)
        dateViewBottomConstraint?.isActive = true
        apodView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        apodView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        apodView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc func saveResponse(){
        //
    }
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
        self.view.endEditing(true)
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            dateViewHeightConstraint?.constant = 50.0
            dateViewBottomConstraint?.constant = 10.0
            break // Uno
        case 1:
            dateViewHeightConstraint?.constant = 0.0
            dateViewBottomConstraint?.constant = 0.0
            break // Dos
        default:
            break
        }
    }
}
