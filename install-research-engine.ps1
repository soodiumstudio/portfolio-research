# portfolio-research 가 쓰는 조사 엔진(insane-research)을 설치합니다. — Windows용
# 원본: https://github.com/fivetaku/insane-research  (MIT)
#
# 쓰는 법: PowerShell 을 열고 아래 한 줄을 붙여넣으세요.
#   powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\skills\portfolio-research\install-research-engine.ps1"

$ErrorActionPreference = "Stop"

$Skills = Join-Path $env:USERPROFILE ".claude\skills"
$Main   = Join-Path $Skills "insane-research-main"
$Query  = Join-Path $Skills "insane-research-query"
$Repo   = "https://github.com/fivetaku/insane-research.git"

# 스킬 본문에 심을 경로는 슬래시(/)로 쓴다. PowerShell·Git Bash·파이썬 모두에서 통한다.
$MainFwd  = $Main  -replace '\\','/'
$QueryFwd = $Query -replace '\\','/'

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Host "[X] git 이 없습니다. https://git-scm.com/download/win 에서 설치한 뒤 다시 실행해 주세요."
  exit 1
}

if ((Test-Path (Join-Path $Main "SKILL.md")) -and
    -not (Select-String -Path (Join-Path $Main "SKILL.md") -Pattern 'CLAUDE_PLUGIN_ROOT' -Quiet)) {
  Write-Host "[OK] 조사 엔진이 이미 설치되어 있습니다."
  Write-Host "     다시 설치하려면 이 폴더를 지우고 실행하세요: $Main"
  exit 0
}

$Tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("ir-" + [System.Guid]::NewGuid().ToString("N").Substring(0,8))
New-Item -ItemType Directory -Path $Tmp -Force | Out-Null

try {
  Write-Host "[..] 조사 엔진을 내려받는 중..."
  git clone -q --depth 1 $Repo (Join-Path $Tmp "src") 2>$null
  if ($LASTEXITCODE -ne 0) { Write-Host "[X] 내려받기에 실패했습니다. 인터넷 연결을 확인해 주세요."; exit 1 }

  $SrcMain = Join-Path $Tmp "src\skills\insane-research-main"
  if (-not (Test-Path $SrcMain)) {
    Write-Host "[X] 내려받은 파일 구조가 예상과 다릅니다. 원본 저장소가 바뀐 것 같습니다."; exit 1
  }

  New-Item -ItemType Directory -Path $Skills -Force | Out-Null
  if (Test-Path $Main)  { Remove-Item $Main  -Recurse -Force }
  if (Test-Path $Query) { Remove-Item $Query -Recurse -Force }
  Copy-Item $SrcMain $Main -Recurse
  Copy-Item (Join-Path $Tmp "src\skills\insane-research-query") $Query -Recurse
  $SrcSetup = Join-Path $Tmp "src\setup"
  if (Test-Path $SrcSetup) { Copy-Item $SrcSetup (Join-Path $Main "setup") -Recurse }
  $SrcLic = Join-Path $Tmp "src\LICENSE"
  if (Test-Path $SrcLic) { Copy-Item $SrcLic (Join-Path $Main "LICENSE") }

  Write-Host "[..] 경로를 이 컴퓨터에 맞게 바꾸는 중..."
  foreach ($f in @((Join-Path $Main "SKILL.md"), (Join-Path $Query "SKILL.md"))) {
    if (-not (Test-Path $f)) { continue }
    $t = Get-Content $f -Raw -Encoding UTF8
    $t = $t -replace [regex]::Escape('${CLAUDE_PLUGIN_ROOT}/skills/insane-research-query'), $QueryFwd
    $t = $t -replace [regex]::Escape('${CLAUDE_PLUGIN_ROOT}/skills/insane-research-main'),  $MainFwd
    $t = $t -replace [regex]::Escape('${CLAUDE_PLUGIN_ROOT}/setup'),                        "$MainFwd/setup"
    $t = $t -replace [regex]::Escape('${CLAUDE_PLUGIN_ROOT}'),                              $MainFwd
    Set-Content -Path $f -Value $t -Encoding UTF8 -NoNewline
  }

  $left = 0
  foreach ($f in @((Join-Path $Main "SKILL.md"), (Join-Path $Query "SKILL.md"))) {
    if (Test-Path $f) {
      $left += (Select-String -Path $f -Pattern 'CLAUDE_PLUGIN_ROOT' -AllMatches |
                Measure-Object).Count
    }
  }

  Write-Host ""
  if ($left -eq 0) {
    Write-Host "[OK] 설치 완료했습니다."
    Write-Host ""
    Write-Host "     Claude Code 를 껐다 켜신 다음 /portfolio-research 를 실행하세요."
    Write-Host "     이제 훨씬 깊이 있게 조사합니다."
  } else {
    Write-Host "[!] 설치는 됐지만 확인이 필요합니다. (남은 경로 $left 개)"
    Write-Host "    그대로 써도 대부분 동작하지만, 이상하면 이 메시지를 알려 주세요."
  }
}
finally {
  if (Test-Path $Tmp) { Remove-Item $Tmp -Recurse -Force -ErrorAction SilentlyContinue }
}
