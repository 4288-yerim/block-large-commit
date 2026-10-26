#!/bin/sh
# 현재 git 레포에 같은 폴더의 pre-commit을 훅으로 설치한다.
# 다른 pre-commit 훅이 이미 있으면 덮어쓰지 않는다. 덮어쓰려면: FORCE=1 sh install.sh

src="$(cd "$(dirname "$0")" && pwd)/pre-commit"
dest=$(git rev-parse --git-path hooks/pre-commit 2>/dev/null) || {
    echo "git 레포 안에서 실행하세요." >&2
    exit 1
}

if [ -e "$dest" ] && ! cmp -s "$src" "$dest" && [ "$FORCE" != "1" ]; then
    echo "이미 다른 pre-commit 훅이 있습니다: $dest" >&2
    echo "덮어쓰려면: FORCE=1 sh $0" >&2
    exit 1
fi

cp "$src" "$dest" && chmod +x "$dest"
echo "설치 완료: $dest"
