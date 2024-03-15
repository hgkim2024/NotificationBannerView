//
//  RxViewController.swift
//  NotificationBanner
//
//  Created by 김현구 on 3/15/24.
//

import RxSwift

class RxViewController: UIViewController {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag = DisposeBag()
    }
}

