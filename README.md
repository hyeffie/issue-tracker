<p align="center"><img src="https://github.com/codesquad-members-2023-team2/issue-tracker/assets/112251635/880c5e2d-b561-40a3-b1c9-a17734757ec4" width="300" height="300"/>

<p align="center"><a href="https://github.com/codesquad-members-2023-team2/issue-tracker/wiki"><img src="https://img.shields.io/badge/Issue%20tracker-Wiki-007396?style=flat-square&logo=Wikipedia&logoColor=white"/><a/>
  
## 💡 소개
 
코드스쿼드 그룹 프로젝트, 이슈 트래커입니다. 이슈 트래커는 Github의 이슈 관리 기능을 모티브로 하고 있으며, Github 로그인을 지원하며, 이슈 작성, 댓글 기능으로 프로젝트의 이슈를 관리할 수 있습니다. 또한, 마일스톤, 라벨, 이슈 필터 기능을 이용하여 이슈를 쉽게 관리할 수 있습니다.

[이슈 트래커의 자세한 기능 구경하기](https://github.com/codesquad-members-2023-team2/issue-tracker/wiki/%EA%B8%B0%EB%8A%A5-%EB%8D%B0%EB%AA%A8)
  

## 👪 멤버 소개

| ![제이든](https://ca.slack-edge.com/T74H5245A-U04G7GJ0P2L-bacfbaf4a8b0-512) | ![릴리](https://ca.slack-edge.com/T74H5245A-U04G792TR7S-523e48733e32-512) | ![루크](https://ca.slack-edge.com/T74H5245A-U04FWAZSZED-3482eadd3837-512) | ![포로](https://ca.slack-edge.com/T74H5245A-U04GE6HKBTJ-08f3100ac358-512) | ![우드](https://ca.slack-edge.com/T74H5245A-U04GHTGGCE4-339eb09b8d0d-512) | ![에피](https://ca.slack-edge.com/T74H5245A-U04FL9VKFDJ-b8cf1a0a5454-512) |
| :-----------------------------------------------------------: | :------------------------------------------------------------: | :----------------------------------------------------------------: | :-----------------------------------------------------------: | :-----------------------------------------------------------: | :-----------------------------------------------------------: |
|        [**제이든(FE)**](https://github.com/JaydenLee1116)         |           [**릴리(FE)**](https://github.com/ahnlook)           |         [**루크(BE)**](https://github.com/acceptor-gyu)         |        [**포로(BE)**](https://github.com/Gwonwoo-Nam)         |        [**우드(iOS)**](https://github.com/dpfdlalfm)         |        [**에피(iOS)**](https://github.com/hyeffie)         |

## 🧾 기술 스택

### 공통

![Git](https://img.shields.io/badge/-Git-F05032?style=flat&logo=Git&logoColor=white)
![GitHub](https://img.shields.io/badge/-GitHub-181717?style=flat&logo=GitHub&logoColor=white)

### Infrastructure & CI/CD

<img src="https://img.shields.io/badge/AWS%20EC2-FA7343?style=flat&logo=amazonec2&logoColor=white"/> <img src="https://img.shields.io/badge/AWS%20RDS-red?style=flat&logo=amazonrds&logoColor=white"/> <img src="https://img.shields.io/badge/AWS%20S3-569A31?style=flat&logo=amazons3&logoColor=white"/> 
![nginx](https://img.shields.io/badge/nginx-009639?style=flat&logo=nginx&logoColor=white)
![Github Actions](https://img.shields.io/badge/Github%20Actions-2088FF?style=flat&logo=GithubActions&logoColor=white)
![AWS Codedeploy](https://img.shields.io/badge/AWS%20Codedeploy-yellowgreen?style=flat)

### Back-End

<img src="https://img.shields.io/badge/Java-007396?style=flat&logo=java&logoColor=white"/> <img src="https://img.shields.io/badge/Gradle-02303A?style=flat&logo=Gradle&logoColor=white"/> <img src="https://img.shields.io/badge/SpringBoot-6DB33F?style=flat&logo=SpringBoot&logoColor=white"/> <img src="https://img.shields.io/badge/Spring%20Data%20JDBC-03EF62?style=flat"/> <img src="https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=MySQL&logoColor=white"/> <img src="https://img.shields.io/badge/Spring%20Data%20JDBC-03EF62?style=flat"/> 
![OAuth 2.0](https://img.shields.io/badge/OAuth-EB5424?style=flat) ![IntelliJ IDEA](https://img.shields.io/badge/-IntelliJ%20IDEA-FF3850?style=flat&logo=IntelliJ%20IDEA&logoColor=white)


### Front-End

<img src="https://img.shields.io/badge/Typescript-3178C6?style=flat&logo=TypeScript&logoColor=white"/> <img src="https://img.shields.io/badge/React-61DAFB?style=flat&logo=React&logoColor=white"/> <img src="https://img.shields.io/badge/-Tailwind-38B2AC?style=flat&logo=Tailwind%20CSS&logoColor=white"/> <img src="https://img.shields.io/badge/-Storybook-FF4785?style=flat&logo=Storybook&logoColor=white"/> ![VSC](https://img.shields.io/badge/-Visual%20Studio%20Code-007ACC?style=flat&logo=Visual%20Studio%20Code&logoColor=white) ![WebStorm](https://img.shields.io/badge/-WebStorm-00A3E0?style=flat&logo=WebStorm&logoColor=white)



### iOS

![Xcode](https://img.shields.io/badge/-Xcode-1575F9?style=flat&logo=Xcode&logoColor=white)
![Swift](https://img.shields.io/badge/-Swift-FA7343?style=flat&logo=Swift&logoColor=white)
![UIKit](https://img.shields.io/badge/-UIKit-00599C?style=flat&logo=UIKit&logoColor=white)
![Combine](https://img.shields.io/badge/-Combine-FF7B17?style=flat&logo=Swift&logoColor=white)

## ⚙️ Infrastructure & CI/CD pipeline

![image](https://github.com/codesquad-members-2023-team2/issue-tracker/assets/112251635/1338ee2a-b734-4e68-b511-2e2b66aaece3)


## 🤲 협업 전략

### 브랜치 구조

- `release-front` : 프론트 배포 branch
- `release` : 백엔드 배포 branch
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
