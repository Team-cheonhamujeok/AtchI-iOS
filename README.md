# 💟 AtchI-iOS
<p align='center'><bold>안녕하세요, 치매 예방 및 AI 진단 솔루션 ✨엣치✨입니다</bold></p>

> 엣치는 웨어러블 기기(애플워치)에서 수집한 사용자의 활동 패턴을 AI로 분석해 치매 확률을 계산하고 치매 초기에 병원에 방문할 수 있도록 도와주는 치매 예방 애플리케이션입니다.
<img width="1584" alt="image" src="https://github.com/Team-cheonhamujeok/AtchI-iOS/assets/71880682/00281a40-cb69-4ef6-8062-f2f261acc5e2">

## 🌲 메뉴 트리
![image](https://github.com/Team-cheonhamujeok/AtchI-iOS/assets/71880682/41a38f40-e844-43bf-aef6-4e5c32363fe5)

## 🏛️ 아키텍처
![image](https://github.com/Team-cheonhamujeok/AtchI-iOS/assets/71880682/3e250365-8aa2-4578-bd49-41a4de5096c4)

### Main App
> 사용자와 직접적으로 상호작용하는 앱 타겟입니다.
- Presentation
  - `View`: SwiftUI로 구성된 화면입니다.
  - `ViewModel`: View의 상태를 관리하고 사용자 입력에 따른 Service를 호출합니다.
- `Service`: 네트워킹 및 계산 등 비즈니스 로직 가진 컴포넌트입니다.
- `Helper`: 권한 인증 프로세스, 날짜 계산, 그 외 iOS 네이티브 API(Push Notification, Haptic)사용을 도와주는 컴포넌트입니다.

### HealthKit
> 헬스킷 관련 로직을 따로 분리했습니다. (추후 패키지화)
- `Provider`: HKStore와 HKQuery를 이용해 건강 정보를 가져오는 로직을 추상화합니다.
- `Service`: Provider를 이용해 가져온 건강정보를 가공해 앱 내에서 사용할 수 있는 형태로 반환합니다.

## 📁 폴더링
```
.
├── AtchI
│   ├── Info.plist
│   ├── AppDelegate.swift
│   ├── AtchIApp.swift
│   ├── Resource
│   ├── HealthKit
│   │   ├── Error
│   │   ├── Provider
│   │   └── Service
│   ├── Helper
│   ├── Presentation
│   │   └── Feature..
│   │       ├── View
│   │       └── ViewModel
│   ├── Service
│   │   └── Domain..
│   │       ├── Model
│   │       ├── Error
│   │       ├── Mock
│   │       └── API
│   └── Util
│       ├── Constant
│       ├── Extension
│       ├── PropertyWrapper
│       ├── Structure
│       └── UI
├── AtchIServiceTests
│   ├── Target
│   └── Mock
├── AtchIViewModelTests
│   ├── Target
│   └── Mock
├── README.md
└── Secrets.xcconfig
```
- `Presentation`: 기능별로 View와 ViewModel을 포함합니다.
- `Service`: 도메인별로 Model(DTO), Error, Mock, API(MoyaClient)를 포함합니다.
- `Util`: 앱 전역적을 사용되는 구조체, 열거형, Extension 등을 포함합니다.
- `Resource`: .plist파일과 .rtf 파일을 포함합니다.
- `Tests`: 각 타겟 클래스에 대한 Tests파일을 하나씩 생성합니다. Mock은 테스트 타겟 루트 하단 폴더에서 관리합니다.

## 📘 라이브러리
라이브러리명 | 용도 | 깃허브
---|---|---
SwiftUI | UI | -
Combine | 리액티브 프로그래밍 | -
CombineMoya | 네트워킹 | https://github.com/Moya/Moya
MarkdownUI | 마크다운 뷰 | https://github.com/gonzalezreal/swift-markdown-ui
Factory | 컨테이너형 DI | https://github.com/hmlongco/Factory

## 👥 팀
**강민규** | **김가은** | **김민제** | **이도연** | **이봄이**
:---:|:---:|:---:|:---:|:---:|
<img width="196" alt="image" src="https://github.com/Team-cheonhamujeok/AtchI-iOS/assets/71880682/887d1c39-7ef6-4c2a-9001-bf969dbf4c6e"> | <img width="172" alt="image" src="https://github.com/Team-cheonhamujeok/AtchI-iOS/assets/71880682/dee9970a-a559-41c3-ac03-209fa1d04522"> | <img width="210" alt="image" src="https://github.com/Team-cheonhamujeok/AtchI-iOS/assets/71880682/6d0690d9-cfe5-4400-9da5-1cbc00524d72"> | <img width="171" alt="image" src="https://github.com/Team-cheonhamujeok/AtchI-iOS/assets/71880682/31ed75e2-7a5f-4c91-b389-93b88054651d"> | <img width="211" alt="image" src="https://github.com/Team-cheonhamujeok/AtchI-iOS/assets/71880682/c81670af-8453-45bf-9aa6-6225dba6bdbe">
iOS | BACKEND | AI | iOS | iOS
[@KoreaMango](https://github.com/devxsby) | [@13wjdgk](https://github.com/13wjdgk) | [@minjjait](https://github.com/minjjait) | [@dodo849](https://github.com/dodo849) | [@spring](https://github.com/leeyi1203) |

---
##### 🔗 BackEnd Repository: https://github.com/Team-cheonhamujeok/AtchI_Backend



