#!/usr/bin/env bash
# portfolio-research 가 쓰는 조사 엔진(insane-research)을 설치합니다.
# 원본: https://github.com/fivetaku/insane-research  (MIT)
#
# insane-research 는 원래 플러그인 형태라 내부 경로가 ${CLAUDE_PLUGIN_ROOT} 로 되어 있습니다.
# /plugin 을 쓸 수 없는 환경에서는 그대로 두면 경로가 전부 깨지므로,
# 이 스크립트가 실제 설치 위치로 바꿔 줍니다.

set -euo pipefail
SKILLS="${HOME}/.claude/skills"
MAIN="${SKILLS}/insane-research-main"
QUERY="${SKILLS}/insane-research-query"
REPO="https://github.com/fivetaku/insane-research.git"

say() { printf '%s\n' "$1"; }

command -v git >/dev/null 2>&1 || {
  say "❌ git 이 없습니다. https://git-scm.com 에서 설치한 뒤 다시 실행해 주세요."; exit 1; }

if [ -f "${MAIN}/SKILL.md" ] && ! grep -q 'CLAUDE_PLUGIN_ROOT' "${MAIN}/SKILL.md" 2>/dev/null; then
  say "✅ 조사 엔진이 이미 설치되어 있습니다. 다시 설치하려면 아래 폴더를 지우고 실행하세요."
  say "   ${MAIN}"
  exit 0
fi

TMP="$(mktemp -d)"
trap 'rm -rf "${TMP}"' EXIT

say "⏳ 조사 엔진을 내려받는 중…"
git clone -q --depth 1 "${REPO}" "${TMP}/src" || {
  say "❌ 내려받기에 실패했습니다. 인터넷 연결을 확인해 주세요."; exit 1; }

[ -d "${TMP}/src/skills/insane-research-main" ] || {
  say "❌ 내려받은 파일 구조가 예상과 다릅니다. 원본 저장소가 바뀐 것 같습니다."; exit 1; }

mkdir -p "${SKILLS}"
rm -rf "${MAIN}" "${QUERY}"
cp -R "${TMP}/src/skills/insane-research-main"  "${MAIN}"
cp -R "${TMP}/src/skills/insane-research-query" "${QUERY}"
[ -d "${TMP}/src/setup" ] && cp -R "${TMP}/src/setup" "${MAIN}/setup"
[ -f "${TMP}/src/LICENSE" ] && cp "${TMP}/src/LICENSE" "${MAIN}/LICENSE"

say "⏳ 경로를 이 컴퓨터에 맞게 바꾸는 중…"
for f in "${MAIN}/SKILL.md" "${QUERY}/SKILL.md"; do
  [ -f "$f" ] || continue
  perl -pi -e "s|\\\$\\{CLAUDE_PLUGIN_ROOT\\}/skills/insane-research-query|${QUERY}|g" "$f"
  perl -pi -e "s|\\\$\\{CLAUDE_PLUGIN_ROOT\\}/skills/insane-research-main|${MAIN}|g"  "$f"
  perl -pi -e "s|\\\$\\{CLAUDE_PLUGIN_ROOT\\}/setup|${MAIN}/setup|g"                  "$f"
  perl -pi -e "s|\\\$\\{CLAUDE_PLUGIN_ROOT\\}|${MAIN}|g"                              "$f"
done

# grep 은 매치가 없으면 exit 1 을 내므로 반드시 || true 로 감싼다 (set -e 에 걸려 죽는다)
LEFT=$( { grep -c 'CLAUDE_PLUGIN_ROOT' "${MAIN}/SKILL.md" "${QUERY}/SKILL.md" 2>/dev/null || true; } | awk -F: '{s+=$2} END{print s+0}')
BAD=0
PATHS=$( { grep -ho "${SKILLS}/insane-research[^ \`\"')]*" "${MAIN}/SKILL.md" "${QUERY}/SKILL.md" 2>/dev/null || true; } | sort -u)
while IFS= read -r p; do
  [ -n "$p" ] || continue
  p="${p%[.,)]}"
  [ -e "$p" ] || { say "   ⚠️ 못 찾은 경로: $p"; BAD=$((BAD+1)); }
done <<< "$PATHS"

say ""
if [ "${LEFT}" -eq 0 ] && [ "${BAD}" -eq 0 ]; then
  say "✅ 설치 완료했습니다."
  say ""
  say "   Claude Code 를 껐다 켜신 다음 /portfolio-research 를 실행하세요."
  say "   이제 훨씬 깊이 있게 조사합니다."
else
  say "⚠️ 설치는 됐지만 확인이 필요합니다. (남은 경로 ${LEFT}개, 못 찾은 경로 ${BAD}개)"
  say "   그대로 써도 대부분 동작하지만, 이상하면 이 메시지를 알려 주세요."
fi
