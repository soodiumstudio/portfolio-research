# portfolio-research

**남들은 뭘 만들었나 찾아보기**

관심 분야에 어떤 서비스가 이미 있는지 조사해서, 시장 요약·비교표·비어 있는 자리 세 개로 정리합니다.

## 설치

터미널에 아래 한 줄을 입력하세요.

```bash
git clone https://github.com/soodiumstudio/portfolio-research.git ~/.claude/skills/portfolio-research
```

Claude Code를 껐다 켜면 바로 쓸 수 있습니다.

> ⚠️ `/plugin install` 은 쓰지 않습니다. 환경에 따라 `/plugin` 자체가 없습니다.
> 스킬은 `~/.claude/skills/` 에 폴더로 넣으면 그대로 인식됩니다.

## 업데이트

```bash
cd ~/.claude/skills/portfolio-research && git pull
```

## 사용

Claude Code 입력창에 (터미널 아님):

    /portfolio-research

필요한 것이 있으면 먼저 물어봅니다. 준비물 없이 그냥 실행해도 됩니다.

## 함께 쓰면 좋은 것 (선택)

깊이 있는 조사를 하려면 [insane-research](https://github.com/fivetaku/insane-research)를 함께 설치하세요.
여러 에이전트가 교차 검증까지 해 줍니다.

터미널에서:

```bash
git clone https://github.com/fivetaku/insane-research.git /tmp/ir && \
cp -R /tmp/ir/skills/insane-research-main ~/.claude/skills/ && \
cp -R /tmp/ir/skills/insane-research-query ~/.claude/skills/
```

> ⚠️ 이 저장소는 원래 플러그인 형태라 내부 경로가 `${CLAUDE_PLUGIN_ROOT}` 로 되어 있습니다.
> `/plugin` 을 못 쓰는 환경에서는 그 경로를 실제 설치 위치로 바꿔야 동작합니다.

설치돼 있으면 이 스킬이 **조사 설계서(query.json)를 만들어 자동으로 넘깁니다.**
그냥 주제만 던지는 게 아니라, 기간·언어·출처 등급·제외 항목까지 지정해서 넘깁니다.

| 지정하는 값 | 막는 사고 |
|---|---|
| 기간을 최근 3년으로 | 오래된 전망치가 현재 수치처럼 섞이는 것 |
| 언어에 `ko` 추가 | 기본값이 영어라 국내 통계를 못 찾는 것 |
| 출처 등급 B 이상 | 블로그·커뮤니티 글이 근거로 올라오는 것 |
| 정부 통계 사이트 우선 | 출처 품질이 뒤섞이는 것 |

설치돼 있지 않으면 설치 방법을 안내하고, 원하시면 웹 검색만으로 진행합니다(간단 모드).

