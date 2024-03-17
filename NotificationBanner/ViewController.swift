//
//  ViewController.swift
//  NotificationBanner
//
//  Created by 김현구 on 3/15/24.
//

import UIKit

class ViewController: RxViewController {

    @IBOutlet weak var showBannerTopBtn: UIButton!
    @IBOutlet weak var showBottomBannerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: - show Banner Top Button
        showBannerTopBtn.addRxTap(disposeBag: disposeBag) {
            let style = self.getBannerStyle()
            let title = self.getBannerTitle()
            let banner = NotificationBannerView(title: title, style: style, position: .top)
            banner.show()
        }
        
        // MARK: - show Bottom Banner Button
        showBottomBannerBtn.addRxTap(disposeBag: disposeBag) {
            let style = self.getBannerStyle()
            let title = self.getBannerTitle()
            let banner = NotificationBannerView(title: title, style: style, position: .bottom)
            banner.show()
        }
    }
    
    func getBannerStyle() -> BannerStyle {
        return switch Int.random(in: 0 ... 3) {
        case 1:
            .info
        case 2:
            .success
        case 3:
            .warning
        default:
            .danger
        }
    }
    
    func getBannerTitle() -> String {
        return switch Int.random(in: 0 ... 9) {
        case 1:
            "test"
        case 2:
            "Real-time mobile to cloud data sync makes it easy to build interactive features that keep data up-to-date across multiple devices, users, and the backend."
        case 3:
            "Realm’s live objects mean data updated anywhere is automatically updated everywhere."
        case 4:
            "This Quick Start demonstrates how to use Realm with the Realm Swift SDK. Before you begin, ensure you have Installed the Swift SDK."
        case 5:
            "configuration parameter:"
        case 6:
            "To modify a todo, update its properties in a write transaction block:"
        case 7:
            "If you want to sync Realm data across devices, you can set up an Atlas App Services App and enable Device Sync. For more information on what you can do with App Services, see: App Services - Swift SDK."
        case 8:
            "Once you have a realm with a subscription, this example passes the realm and the user to another function where you can use the realm."
        case 9:
            "Enable anonymous authentication"
        default:
            "What does storing and querying data in Realm look like?"
        }
    }

}
