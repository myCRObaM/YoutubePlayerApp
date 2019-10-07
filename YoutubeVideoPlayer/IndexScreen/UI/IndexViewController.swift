//
//  ViewController.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import UIKit
import RxSwift

class IndexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.videoData?.resultsPerPage ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
    let customView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var vSpinner : UIView?
    
    //MARK: Variables
    let viewModel: IndexViewModel
    let disposeBag = DisposeBag()
    
    //MARK: Init
    init(viewModel: IndexViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
    }
    //MARK: UI setup
    func setupUI(){
        view.addSubview(customView)
        customView.delegate = self
        customView.dataSource = self
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    //MARK: Setup View Model
    func setupViewModel(){
        let input = IndexViewModel.Input(getDataSubject: PublishSubject())
        
        let output = viewModel.transform(input: input)
        
        for disposable in output.disposables {
            disposable.disposed(by: disposeBag)
        }
        
        spinnerControl(subject: output.spinnerSubject).disposed(by: disposeBag)
        input.getDataSubject.onNext(true)
        
    }
    func spinnerControl(subject: PublishSubject<Bool>) -> Disposable{
        return subject
        .observeOn(MainScheduler.instance)
        .subscribeOn(viewModel.dependencies.scheduler)
        .subscribe(onNext: {[unowned self]  bool in
            switch bool{
            case true:
                self.showSpinner(onView: self.view)
            case false:
                self.removeSpinner()
            }
            })
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }


}

