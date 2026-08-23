# portfolio-research — 남들은 뭘 만들었나 찾아보기

내가 만들고 싶은 분야에 **어떤 서비스가 이미 있는지** 찾아 드립니다. 시장 숫자, 비슷한 서비스 비교표, 아직 아무도 안 한 자리 세 개가 나옵니다.

---

## 설치

### 🍎 맥 · 리눅스 — 터미널에 붙여넣기

```bash
git clone https://github.com/soodiumstudio/portfolio-research.git ~/.claude/skills/portfolio-research
```

```bash
bash ~/.claude/skills/portfolio-research/install-research-engine.sh
```

### 🪟 윈도우 — PowerShell 에 붙여넣기

> **PowerShell** 을 여세요. 시작 메뉴에서 "PowerShell" 을 검색하면 나옵니다.
> **cmd 창은 안 됩니다.** cmd 에서는 `~` 가 폴더 이름으로 잘못 인식됩니다.

```powershell
git clone https://github.com/soodiumstudio/portfolio-research.git "$env:USERPROFILE\.claude\skills\portfolio-research"
```

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\skills\portfolio-research\install-research-engine.ps1"
```

### 둘 다 끝나면

**Claude Code를 완전히 껐다 켜세요.** 그래야 스킬이 잡힙니다.

> 두 번째 줄을 건너뛰어도 스킬은 돌아갑니다. 대신 웹 검색만 써서 **조사가 얕아집니다.**
> 여러 조사원이 나눠 찾고 서로 검증하는 건 엔진이 있어야 합니다.

> 💡 `/plugin install` 은 쓰지 않습니다. 환경에 따라 그 명령이 아예 없습니다.
> 스킬은 스킬 폴더에 넣으면 그대로 인식됩니다.

## 쓰는 법

Claude Code 입력창에 (터미널 아니고, **채팅창**입니다):

    /portfolio-research

주제를 함께 적으셔도 되고, 그냥 실행하셔도 됩니다.

## 실행하면 이렇게 진행됩니다

1. **준비물을 먼저 알려드립니다.** 무엇이 필요한지 보고 "준비됐어요"를 누르면 시작합니다.
   컴퓨터 상태가 사람마다 달라서, 준비가 안 된 채로 시작하면 중간에 멈춥니다.
2. **필요한 건 선택지로 물어봅니다.** 길게 설명하실 필요 없습니다. 고르기만 하세요.
   모르겠으면 **"잘 모르겠어요"를 고르시면 됩니다.** 제가 정하고 알려드립니다.
3. **진행률이 계속 보입니다.** `▓▓▓▓░░░░░░ 40%` 처럼요. 얼마나 남았는지 알 수 있습니다.
4. **결과는 볼 수 있는 웹 페이지로 나옵니다.** 링크를 눌러서 보시면 됩니다.
   그대로 캡처해서 포트폴리오에 넣으셔도 됩니다.

## 무엇이 나오나요

- **한 장 요약** — 알게 된 것 세 가지와 그게 무슨 뜻인지
- **비교표** — 비슷한 서비스 네다섯 개를 나란히
- **비어 있는 자리 세 개** — 다음에 무엇을 만들지 정할 재료

## 조사 엔진에 대해

이 스킬은 [insane-research](https://github.com/fivetaku/insane-research)(MIT)를 조사 엔진으로 씁니다.
설치 스크립트가 그걸 받아서 이 컴퓨터에 맞게 경로를 고쳐 넣습니다.

스킬은 그냥 "조사해줘"라고 넘기지 않습니다. **조사 설계서를 만들어서** 넘깁니다 —
찾을 기간, 한국어 자료 포함, 출처 등급 하한, 정부 통계 사이트 우선, 제외할 것까지 지정해서요.
이 지정이 없으면 영어 자료만 뒤지거나 개인 블로그를 근거로 물어옵니다.

## 이건 못 합니다

- 사용자 인터뷰 — 사람을 직접 만나야 알 수 있습니다
- 앱을 실제로 써 본 느낌 — 직접 깔아서 써 보셔야 합니다

## 자주 막히는 곳

| 이럴 때 | 이렇게 하세요 |
|---|---|
| `/portfolio-research` 이 안 보여요 | Claude Code를 완전히 껐다 켜세요 |
| 지난주 결과가 안 보여요 | 폴더를 잘못 여셨습니다. 매주 같은 폴더를 여세요 |
| 뭘 답해야 할지 모르겠어요 | **"잘 모르겠어요"를 고르세요.** 그게 정상입니다 |
| 중간에 멈춘 것 같아요 | 진행률 막대를 보세요. 조사·채점 구간은 몇 분 걸립니다 |
| 윈도우인데 명령이 안 먹어요 | **PowerShell** 을 쓰세요. cmd 창에서는 `~` 가 안 됩니다 |
| 조사 엔진 설치가 실패해요 | git 이 없을 수 있습니다. 맥은 `xcode-select --install`, 윈도우는 [git-scm.com](https://git-scm.com/download/win) |

## 업데이트

```bash
cd ~/.claude/skills/portfolio-research && git pull
```
윈도우는
```powershell
cd "$env:USERPROFILE\.claude\skills\portfolio-research"; git pull
```
