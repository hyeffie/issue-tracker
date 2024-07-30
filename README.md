# 이슈 트래커 iOS 앱

<p align="center"><img src="https://github.com/codesquad-members-2023-team2/issue-tracker/assets/112251635/880c5e2d-b561-40a3-b1c9-a17734757ec4" width="300" height="300"/>

## **🍄‍🟫 개요**

- Github의 이슈 관리 기능을 모티브로 한 이슈 관리 앱
- 4주간의 웹 백앤드, 웹 프론트엔드, 모바일 iOS 협업 프로젝트
- 이슈 및 마일스톤 CRUD 및 이슈 레이블 관리 기능 구현

### iOS 프로젝트

- [iOS 프로젝트 디렉터리](https://github.com/hyeffie/issue-tracker/tree/hyeffie/main/ios/IssueTracker)

### 팀 프로젝트 링크

- [이슈 트래커 팀 프로젝트 레포](https://github.com/codesquad-members-2023-team2/issue-tracker)
- [이슈 트래커의 기능 데모 보러가기](https://github.com/codesquad-members-2023-team2/issue-tracker/wiki/%EA%B8%B0%EB%8A%A5-%EB%8D%B0%EB%AA%A8)
- [이슈 트래커 팀 위키 구경하기](https://github.com/codesquad-members-2023-team2/issue-tracker/wiki)

## **🍄‍🟫 기능 데모**

| 이슈 목록 | 이슈 필터 적용 | 이슈 검색 |
| --- | --- | --- |
| ![01_이슈-목록](https://github.com/user-attachments/assets/c60f0ebd-3489-4515-a1f5-fc540008e714) | ![02_이슈-필터-적용](https://github.com/user-attachments/assets/584aed96-a54a-4b31-8907-7ffc14a963dc) | ![03_이슈-검색](https://github.com/user-attachments/assets/733db82f-4317-4fcb-a704-6f55940ca30d) |

| 이슈 추가 | 이슈 편집 | 이슈 삭제 |
| --- | --- | --- |
| ![04_이슈-추가](https://github.com/user-attachments/assets/dfa95587-50a1-4756-aec3-5a547bdd66f6) | ![05_이슈-편집](https://github.com/user-attachments/assets/a4d960a0-4f45-471c-a55c-ce4dd047aa9c) | ![06_이슈-삭제](https://github.com/user-attachments/assets/c87659fb-cf0f-4134-89de-f214ba33a42b) |

| 레이블 목록 | 레이블 추가, 편집 | 마일스톤 |
| --- | --- | --- |
| ![07_레이블-목록](https://github.com/user-attachments/assets/e31a9b4a-a404-4a9e-a87e-cf32f95cf22a) | ![08_레이블-추가-편집](https://github.com/user-attachments/assets/7333e19b-6211-4402-bb37-acb509b0a6fd) | ![09_마일스톤](https://github.com/user-attachments/assets/b0edda2b-505c-4a7b-a1f8-253d2290fd22) |

## **🍄‍🟫 사용 기술**

- UIKit (Storyboard + xib)
- URLSession
- UICollectionViewDiffableDataSource
- UICollectionViewCompositionalLayout

## **🍄‍🟫** 프로젝트 구조

### 폴더 구조

```
IssueTracker
├── IssueTracker
│ ├── Application # 앱의 엔트리 포인트 및 설정 관련 코드
│ ├── Base.lproj # 기본 지역화 파일
│ ├── Extension # 앱에서 사용하는 확장 기능
│ ├── Model # 데이터 모델 정의
│ ├── Network # 네트워크 통신 관련 코드
│ ├── Resource # 리소스 파일 (이미지, 문자열 등)
│ ├── Scene # 각 화면별 뷰 및 뷰 컨트롤러
│ ├── Service # 비즈니스 로직 및 서비스 레이어
│ ├── Supporting Files # 기타 지원 파일 (Info.plist 등)
│ └── Utility # 유틸리티 및 헬퍼 클래스
└── IssueTracker.xcodeproj # Xcode 프로젝트 파일
```

### 도메인 설계

- 이슈, 라벨, 마일스톤 등 다양한 도메인 모델을 정의하여 각 기능을 모듈화.
- 각 모델 객체가 직접 네트워크 요청을 보내고 데이터를 처리하는 방식에서 네트워크 요청을 전담하는 객체를 별도로 두어 모델 객체와 네트워크 레이어를 분리하는 방식으로 리팩토링

### 이벤트 흐름

- UI에서 발생한 이벤트가 모델 객체를 통해 네트워크 레이어로 전달되고, 응답이 도착하면 다시 UI에 반영되는 구조.
- 비동기 네트워크 요청이 완료될 때까지 UI는 사용자에게 로딩 상태를 표시하며, 응답이 도착하면 UI 업데이트를 트리거하는 방식.

## 🍄‍🟫 주요 문제 해결 경험

### 비동기 네트워크 요청과 응답 처리

- 문제와 원인
    - 초기 설계에서는 각 모델 객체가 직접 네트워크 요청을 보내는 방식으로 구현, 이로 인해 코드 중복과 응답 처리의 복잡성이 증가.
- 대안 비교와 도입
    - 네트워크 요청을 전담하는 `NetworkManager` 클래스를 도입하여 코드 중복을 제거하고, 네트워크 레이어와 모델 객체의 역할을 분리.
- 평가
    - 리팩토링 이후 코드의 가독성과 유지보수성이 크게 향상되었으며, 네트워크 요청의 재사용성과 테스트 용이성도 증가.

### Diffable Data Source를 사용한 UITableView 업데이트

- 대안 비교와 도입
    - 기존의 `UICollectionView` 업데이트 방식은 데이터 변경 시마다 전체 리로드를 하여 성능 저하와 사용자 경험 저하를 초래.
    - `UICollectionViewDiffableDataSource`를 도입하여 데이터 변경 시 필요한 부분만 업데이트하도록 개선.
- 평가
    - `DiffableDataSource` 도입 이후, 테이블 뷰 업데이트 성능이 크게 향상되었고, 데이터 일관성 유지 및 애니메이션 적용이 용이해짐.

## 🍄‍🟫 협업 경험

### 클라이언트 요구사항에 따른 API 설계 협업

이 프로젝트는 iOS와 웹 프론트엔드(React) 클라이언트가 모두 존재하는 복잡한 구조였습니다. 각 클라이언트의 요구사항이 달랐기 때문에, API 설계 단계에서 많은 논의와 협업이 필요했습니다.

- 문제와 원인
    - API 회의에서 각 클라이언트 팀은 같은 API 에 대해 다른 요구사항을 제시.
    - iOS 팀은 페이징을 통해 사용자가 긴 목록을 스크롤할 때 성능을 유지하기를 원함.
    - 웹 팀은 한 번에 모든 데이터를 받아와 효율적인 클라이언트 사이드 렌더링하길 원함.
    - 동일한 데이터에 대한 서로 다른 요구사항은 백엔드 API 설계 시 혼란을 초래할 수 있었음.
- 대안 비교와 토론
    - 하나의 API 엔드포인트에서 모든 데이터를 제공하고 클라이언트에서 필요한 방식으로 처리.
    - 각 클라이언트의 요구에 맞춘 별도의 엔드포인트를 제공.
    - 서버에서 클라이언트의 요청 헤더를 기반으로 조건부 응답을 제공.
- 최종 결정
    - 우리는 클라이언트의 요청에 따라 다른 응답을 제공하는 조건부 응답 방식 채택
    - 하나의 API 엔드포인트로 다양한 클라이언트의 요구 충족 가능
    - iOS는 페이징을 위해 페이지 번호와 페이지 크기를 요청에 포함, 웹 클라이언트는 전체 데이터를 요청
- 평가와 결과
    - 서로 다른 요구사항을 가진 클라이언트를 효과적으로 지원할 수 있는 유연한 API를 설계할 수 있었음.
    - iOS와 웹 프론트엔드 팀, 백엔드 간의 적극적인 소통과 협업을 통해 문제를 해결하고 최적의 해결책 찾음.
