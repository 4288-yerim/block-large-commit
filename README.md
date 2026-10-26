# block-large-commit

스테이징된 파일 중 5MB를 넘는 것이 있으면 커밋을 막는 git `pre-commit` 훅입니다.
가중치(`.onnx`, `.pth`), 데이터셋, 압축 파일처럼 `.gitignore`에서 빠뜨리기 쉬운 큰 파일이 레포에 들어가는 것을 막습니다.

## 설치

훅을 적용할 레포에서 실행합니다.

```bash
cp pre-commit /path/to/repo/.git/hooks/pre-commit
chmod +x /path/to/repo/.git/hooks/pre-commit
```

`.git/hooks`는 레포에 올라가지 않으므로 다른 PC에서는 다시 설치해야 합니다.

## 동작

- 스테이징된 추가·수정·이름 변경 파일의 크기를 확인합니다. 삭제된 파일은 건너뜁니다.
- 5MB를 초과한 파일이 하나라도 있으면 파일 경로와 크기를 보여 주고 커밋을 중단합니다. 크기만 보며 확장자는 보지 않습니다.
- 이미 커밋된 기록은 검사하지 않고 앞으로의 커밋만 막습니다.

```text
커밋 차단: 5MB를 넘는 파일이 스테이징되어 있습니다.
  6.0 MB  models/best.onnx

해결: git restore --staged <파일> 로 빼거나 .gitignore에 추가하세요.
의도한 커밋이면: ALLOW_LARGE=1 git commit ...
```

## 우회와 설정

| 목적 | 방법 |
|---|---|
| 이번 커밋만 허용 | `ALLOW_LARGE=1 git commit -m "..."` |
| 기준 크기 변경 | `MAX_MB=20 git commit -m "..."` |

`--no-verify`는 다른 훅까지 함께 끄므로 쓰지 않고, 위 환경변수로 우회합니다.
