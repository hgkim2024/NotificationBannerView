## Notification Banner 
- Swift 5
- IOS 13.0+
- Xcode 15.1

<br>

## How to use

### Use
```swift
let banner = NotificationBannerView(title: "message", style: .info, position: .top)
banner.show()
```
### Style
```swift
public enum BannerStyle: Int {
    case info
    case success
    case warning
    case error
}
```

### position
```swift
public enum BannerPosition: Int {
    case top
    case bottom
}
```

<br>

## Notification Banner GIF
<img src="https://github.com/hgkim2024/NotificationBannerView/assets/163487894/87bb688d-3864-472b-a7fd-68d7a819fea6" width="231" height="500"></img>

<br>

## 개발 히스토리
> IOS 에서 Toast 를 대체할 수 있는 UI 표기 방식을 찾던 와중 NotificationBanner 라이브러리와 유사한 상하단에 표기하는 메세지 UI 를 보게 되었다. 라이브러리를 프로젝트에 적용하려 했지만, 사용하고 싶었던 Banner 가 한 줄만 지원하였다. 여러 줄 메세지 표기가 가능하길 원했기 때문에 직접 구현하게 되었다.

<br>

## 문제점
> 3줄 까지는 오차없이 Label 높이가 계산된다. 하지만 4줄 이상 넘어가면 Label 이 ... 으로 생략되는 경우가 발생한다. 이는 Label 계산 식에서 여러 줄이 된 경우 공백 width 를 계산하지 않고 있기 때문이다. 현재 프로젝트에는 3줄 표기면 충분하여 작업을 마무리했다.

<br>

## Blog Link
- https://serious-variraptor-8c1.notion.site/Notification-Banner-607561fa61e847529da1cd8cf3de3b1e?pvs=4

<br>

## 참고 문헌
- https://github.com/Daltron/NotificationBanner

<br>
