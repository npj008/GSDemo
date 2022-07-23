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
    private lazy var lauoutGuide = view.safeAreaLayoutGuide
    
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
        dateSelect.delegate = self
        return dateSelect
    }()
    
    var viewModel: APODViewModelEntity = APODViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = Constants.title
        view.backgroundColor = .systemBackground
        setupUI()
        configureViewModel()
        
        let saveButton = UIBarButtonItem(title: Constants.rightNavButtonTitle,
                                         style: .done,
                                         target: self,
                                         action: #selector(resetCache))
        self.navigationItem.rightBarButtonItem  = saveButton
    }
    
    func configureViewModel() {
        apodView.viewModel = viewModel
        viewModel.refreshUI = { [weak self] in
            self?.apodView.refreshUI()
        }
        
        viewModel.showAlert = { msg in
            NavigationRouter.shared.presentAlertWithTitle(title: "Alert", message: msg ?? "", onDismiss: nil)
        }
        
        viewModel.toggleLoadingStatus = { [weak self] isLoading, loadingMessage in
            DispatchQueue.main.async {
                self?.view.showUniversalLoadingView(isLoading, loadingText: loadingMessage)
            }
        }
        
        viewModel.resetUI = { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.setCurrentMode(mode: .search(date: nil))
                self?.dateSelector.resetUI()
            }
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
        segmentControl.topAnchor.constraint(equalTo: lauoutGuide.topAnchor).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: lauoutGuide.leadingAnchor).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: lauoutGuide.trailingAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    private func setupDateSelector() {
        view.addSubview(dateSelector)
        dateSelector.accessibilityIdentifier = Constants.dateAccessibilityID
        dateSelector.translatesAutoresizingMaskIntoConstraints = false
        dateSelector.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10.0).isActive = true
        dateSelector.leadingAnchor.constraint(equalTo: lauoutGuide.leadingAnchor).isActive = true
        dateSelector.trailingAnchor.constraint(equalTo: lauoutGuide.trailingAnchor).isActive = true
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
        apodView.leadingAnchor.constraint(equalTo: lauoutGuide.leadingAnchor, constant: 10.0).isActive = true
        apodView.bottomAnchor.constraint(equalTo: lauoutGuide.bottomAnchor).isActive = true
        apodView.trailingAnchor.constraint(equalTo: lauoutGuide.trailingAnchor, constant: -10.0).isActive = true
    }
    
    @objc func resetCache(){
        self.view.showUniversalLoadingView(true, loadingText: "Cleaning up storage...")
        viewModel.cleanupCache { [weak self] in
            DispatchQueue.main.async {
                self?.view.showUniversalLoadingView(false)
            }
        }
    }
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
        self.view.endEditing(true)
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            dateViewHeightConstraint?.constant = 50.0
            dateViewBottomConstraint?.constant = 10.0
            viewModel.setCurrentMode(mode: .search(date: viewModel.selectedDate))
            break
        case 1:
            dateViewHeightConstraint?.constant = 0.0
            dateViewBottomConstraint?.constant = 0.0
            viewModel.setCurrentMode(mode: .favorite)
            break
        default:
            break
        }
    }
}

extension APODViewController: DateSelectorViewDelegate {
    func dateDidSelected(date: Date) {
        viewModel.setCurrentMode(mode: .search(date: date))
    }
}
