# issue-tracker

## 멤버 소개

| ![제이든](https://ca.slack-edge.com/T74H5245A-U04G7GJ0P2L-bacfbaf4a8b0-512) | ![릴리](https://ca.slack-edge.com/T74H5245A-U04G792TR7S-523e48733e32-512) | ![루크](https://ca.slack-edge.com/T74H5245A-U04FWAZSZED-3482eadd3837-512) | ![포로](https://ca.slack-edge.com/T74H5245A-U04GE6HKBTJ-g131e58ccdf3-512) | ![우드](https://ca.slack-edge.com/T74H5245A-U04GHTGGCE4-339eb09b8d0d-512) | ![에피](https://ca.slack-edge.com/T74H5245A-U04FL9VKFDJ-b8cf1a0a5454-512) |
| :-----------------------------------------------------------: | :------------------------------------------------------------: | :----------------------------------------------------------------: | :-----------------------------------------------------------: | :-----------------------------------------------------------: | :-----------------------------------------------------------: |
|        [**제이든(FE)**](https://github.com/JaydenLee1116)         |           [**릴리(FE)**](https://github.com/ahnlook)           |         [**루크(BE)**](https://github.com/acceptor-gyu)         |        [**포로(BE)**](https://github.com/Gwonwoo-Nam)         |        [**우드(iOS)**](https://github.com/dpfdlalfm)         |        [**에피(iOS)**](https://github.com/hyeffie)         |

## 협업 전략

### 브랜치 구조

- `main` : 배포 branch
- `dev` : 개발 branch
  - `fe` : 프론트엔드 branch
    - `{issue-no}-feature1`
    - `{issue-no}-feature2`
  - `be` : 백엔드 branch
  - `ios` : iOS branch

### 그라운드룰

#### 1. 스크럼 시간

- 시간: 10:00 - 10:30
- 주제
  - 어제 했던 일
  - 오늘 할 일
  - 컨디션(10점 만점)
- 스크럼 마스터 - 제이든

#### 2. 회고

- 시간: (금) 16:30 ~ 18:00
- 주제
  - 클래스 별 진행사항

### 커밋 템플릿

```
type (#issue-number): Subject

body

// 예시
// feat #3: 메인 페이지 토글 기능 추가
// (한 줄 띄기)
// - 토글 버튼 클릭 시, 팝업창 on/off
```

- `feat` : 새로운 기능 추가
- `design`: css 등 사용자 UI 디자인 변경
- `fix` : 버그 수정
- `docs` : 문서 수정
- `test` : 테스트 코드 추가
- `refactor` : 코드 리팩토링
- `style` : 코드 의미에 영향을 주지 않는 변경사항
- `chore` : 빌드 부분 혹은 패키지 매니저 수정사항

### 이슈 템플릿

- Git-issue 사용
- 제목 양식
```
[FE] 프로젝트 초기 설정
```
- 클래스 별 라벨 부착

### 위키

- 작성 예정
