//
//  SearchViewController.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    // MARK: - UI
    private let dragHandleBar: UIView = {
        let view = UIView()
        view.backgroundColor = WCColor.gray08
        view.clipsToBounds = true
        view.layer.cornerRadius = 2.5
        
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.leftView?.tintColor = .black
        searchBar.tintColor = .black
        searchBar.barTintColor = .white
        searchBar.placeholder = "도시 이름을 입력해주세요."
        searchBar.layer.cornerRadius = 9
        searchBar.clipsToBounds = true
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .clear
            textfield.textColor = .black
        }
        return searchBar
    }()
    
    private lazy var cityListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(CityCell.self)
        tableView.rowHeight = 65
        tableView.separatorColor = .white
        tableView.separatorInset = .zero
        return tableView
    }()
    
    // MARK: - Properties
    private let viewModel: SearchViewModel
    
    private typealias DataSource = UITableViewDiffableDataSource<SearchViewModel.Section, City>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<SearchViewModel.Section, City>
    private var dataSource: DataSource?
    
    // MARK: - Init
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - LifeCycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Configuration
    override func configureAttributes() {
        enableKeyboardHiding()
        view.backgroundColor = WCColor.darkSkyColor
        configureDataSource()
    }
    
    // MARK: - Layouts
    override func configureLayouts() {
        view.addSubview(dragHandleBar)
        view.addSubview(searchBar)
        view.addSubview(cityListTableView)
        
        dragHandleBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(25)
            make.height.equalTo(5)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(dragHandleBar.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(40)
        }
        
        cityListTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Binding
    override func bind() {
        let input = SearchViewModel.Input(
            searchTextChanged: searchBar.rx.text.orEmpty
                .debounce(RxTimeInterval.milliseconds(10), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
        )
        
        let output = viewModel.transform(input: input)
        
        output.cityList
            .drive(onNext: { [weak self] cityList in
                guard let self else { return }
                self.applySectionSnapshot(with: cityList)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - DiffableDataSource
extension SearchViewController {
    private func configureDataSource() {
        dataSource = DataSource(
            tableView: cityListTableView
        ) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(CityCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.configure(city: item)
            return cell
        }
    }
   
    private func applySectionSnapshot(with cityList: [City]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(cityList)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
