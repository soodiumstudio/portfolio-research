# portfolio-research

**남들은 뭘 만들었나 찾아보기**

관심 분야에 어떤 서비스가 이미 있는지 조사해서, 시장 요약·비교표·비어 있는 자리 세 개로 정리합니다.

## 설치

> ⚠️ 아래 명령은 **Claude Code 입력창**에 입력하세요. 터미널(zsh)에 붙여넣으면
> `zsh: no such file or directory: /plugin` 오류가 납니다. 슬래시 명령은 셸 명령이 아닙니다.

```
/plugin marketplace add https://github.com/soodiumstudio/portfolio-research.git
```

```
/plugin install portfolio-research
```

## 사용

```
/portfolio-research
```

필요한 것이 있으면 먼저 물어봅니다. 준비물 없이 그냥 실행해도 됩니다.

## 함께 쓰면 좋은 것 (선택)

깊이 있는 조사를 하려면 [insane-research](https://github.com/fivetaku/insane-research)를 함께 설치하세요.
여러 에이전트가 교차 검증까지 해 줍니다.

```
/plugin marketplace add https://github.com/fivetaku/gptaku_plugins.git
```

```
/plugin install insane-research
```

설치돼 있으면 이 스킬이 **조사 설계서(query.json)를 만들어 자동으로 넘깁니다.**
그냥 주제만 던지는 게 아니라, 기간·언어·출처 등급·제외 항목까지 지정해서 넘깁니다.

| 지정하는 값 | 막는 사고 |
|---|---|
| 기간을 최근 3년으로 | 오래된 전망치가 현재 수치처럼 섞이는 것 |
| 언어에 `ko` 추가 | 기본값이 영어라 국내 통계를 못 찾는 것 |
| 출처 등급 B 이상 | 블로그·커뮤니티 글이 근거로 올라오는 것 |
| 정부 통계 사이트 우선 | 출처 품질이 뒤섞이는 것 |

설치돼 있지 않으면 설치 방법을 안내하고, 원하시면 웹 검색만으로 진행합니다(간단 모드).
