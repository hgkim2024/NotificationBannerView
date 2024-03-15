//
//  NotificationBannerView.swift
//  NotificationBanner
//
//  Created by 김현구 on 3/15/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture

// MARK: - BannerStackEvent
class BannerStackEvent {
    let size: CGSize
    
    init(size: CGSize) {
        self.size = size
    }
}

// MARK: - BannerViewEvent
class BannerViewEvent {
    static let instance = BannerViewEvent()
    
    let bannerStackEvent = PublishSubject<BannerStackEvent>()
}


// MARK: - BannerStyle
public enum BannerStyle: Int {
    case danger
    case info
    case success
    case warning
    
    var color: UIColor {
        switch self {
            case .danger:
                return UIColor(red:0.90, green:0.31, blue:0.26, alpha:1.00)
            case .info:
                return UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00)
            case .success:
                return UIColor(red:0.22, green:0.80, blue:0.46, alpha:1.00)
            case .warning:
                return UIColor(red:1.00, green:0.66, blue:0.16, alpha:1.00)
        }
    }
}

// MARK: - BannerPosition
public enum BannerPosition: Int {
    case top
    case bottom
}

// MARK: - NotificationBannerView
class NotificationBannerView: UIView {
    let title = UILabel()
    let bottomSeparator = UIView()
    
    var position: BannerPosition = .top
    private var isDismiss = false
    private var height: CGFloat = 0
    private let disposeBag = DisposeBag()
    
    let topMargin: CGFloat = 6
    let leftMargin: CGFloat = 30
    let animationTime: CGFloat = 0.3
    let dissmisTime: CGFloat = 2.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, style: BannerStyle = .info, position: BannerPosition = .top) {
        super.init(frame: CGRect())
        self.title.text = title
        self.backgroundColor = style.color
        self.position = position
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpUI() {
        guard let vw = keyWindow,
              let maxWidth = maxWidth,
              let maxHeight = maxHeight else { return }
        
        let safeHeight = position == .top ? safeTopHeight : safeBottomHeight
        let titleWidth = maxWidth - (2 * leftMargin)
        let titleheight = title.getHeight(width: titleWidth)
        
        height = safeHeight + titleheight + (2 * topMargin)
        
        vw.addSubview(self)
        addSubview(title)
        addSubview(bottomSeparator)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.numberOfLines = 0
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: title.font.pointSize)
        title.frame =
        CGRect(
            x: leftMargin,
            y: position == .top ? safeHeight + topMargin - height : topMargin + height,
            width: maxWidth - (2 * leftMargin),
            height: titleheight
        )
        
        translatesAutoresizingMaskIntoConstraints = false
        frame =
        CGRect(
            x: 0,
            y: position == .top ? -height : maxHeight,
            width: maxWidth,
            height: height
        )
        
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparator.backgroundColor = .white
        bottomSeparator.isHidden = true
        bottomSeparator.frame =
        CGRect(
            x: 0,
            y: position == .top ? 0 : height,
            width: maxWidth,
            height: 1
        )
    }
    
    func registerEvent() {
        BannerViewEvent.instance.bannerStackEvent.addEvent(disposeBag: disposeBag) { bannerStackEvent in
            let height = self.position == .top ? bannerStackEvent.size.height : -bannerStackEvent.size.height
            UIView.animate(withDuration: self.animationTime, animations: {
                self.setFrameY(height: height)
            })
        }
        
        self.rx.gesture(.swipe(direction: .up))
            .when(.recognized)
            .subscribe { event in
                self.dismiss()
            }
            .disposed(by: disposeBag)
    }
    
    func show() {
        let size = CGSize(width: frame.width, height: title.frame.height + (2 * topMargin))
        BannerViewEvent.instance.bannerStackEvent.onNext(BannerStackEvent(size: size))
        UIView.animate(withDuration: animationTime, animations: {
            let height = self.position == .top ? self.height : -self.height
            self.setFrameY(height: height)
            self.title.setFrameY(height: height)
            self.bottomSeparator.setFrameY(height: height)
            self.registerEvent()
        }) { (completed) in
            self.bottomSeparator.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + self.dissmisTime) {
                self.dismiss()
            }
        }
    }
    
    func dismiss() {
        if (isDismiss) {
            return
        }
        
        isDismiss = true
        bottomSeparator.isHidden = true
        UIView.animate(withDuration: animationTime, animations: {
            let height = self.position == .top ? self.height : -self.height
            self.setFrameY(height: -height)
            self.title.setFrameY(height: -height)
        }) { (completed) in
            self.removeFromSuperview()
            self.title.removeFromSuperview()
            self.bottomSeparator.removeFromSuperview()
        }
    }

}
