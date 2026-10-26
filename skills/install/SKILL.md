---
name: install
description: 현재 git 레포에 대용량 파일(5MB 초과) 커밋을 막는 pre-commit 훅을 설치
disable-model-invocation: true
---

# install — 대용량 파일 커밋 방지 훅 설치

현재 작업 중인 git 레포의 `.git/hooks/pre-commit`에 훅을 설치한다.

1. 이 스킬 폴더의 `install.sh`를 현재 레포에서 실행한다: `sh "<이 스킬의 base directory>/install.sh"`
2. 출력을 그대로 사용자에게 보여 준다.
3. 다른 pre-commit 훅이 이미 있어서 실패하면 덮어쓰지 말고, 기존 훅이 있다는 사실을 알린 뒤 사용자가 허락하면 `FORCE=1`을 붙여 다시 실행한다.

설치 후 동작은 다음과 같다. 사용자에게 한 줄로 안내한다.
- 스테이징된 파일이 5MB를 넘으면 커밋이 막힌다.
- 이번 커밋만 허용하려면 `ALLOW_LARGE=1 git commit ...`, 기준 크기를 바꾸려면 `MAX_MB=20 git commit ...`
- `--no-verify`는 다른 훅까지 끄므로 쓰지 않는다.
