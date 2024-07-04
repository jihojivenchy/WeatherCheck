//
//  ErrorAlertViewController.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/4/24.
//

import UIKit
import SnapKit
import RxSwift

final class ErrorAlertViewController: BaseViewController {
    // MARK: - UI
    private let backgroundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .darkSky
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .sky
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializer
    init(configuration: ErrorAlertConfiguration) {
        super.init()
        
        titleLabel.text = configuration.title
        descriptionLabel.text = configuration.description
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(alertTapped)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 특정 액션이 필요하면 구현할 수 있습니다.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    // MARK: - Configuration
    override func configureAttributes() {
        view.backgroundColor = WCColor.backgroundBlur
    }
    
    // MARK: - Layouts
    override func configureLayouts() {
        view.addSubview(backgroundContainer)
        backgroundContainer.addSubview(titleLabel)
        backgroundContainer.addSubview(descriptionLabel)
        
        backgroundContainer.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
    }
    
    // MARK: - Methods
    @objc private func alertTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        
        // 특정 액션이 필요하면 구현할 수 있습니다.
        if backgroundContainer.frame.contains(location) {
            dismiss(animated: true)
        }
    }
}
