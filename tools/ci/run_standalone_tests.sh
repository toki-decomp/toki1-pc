#!/bin/bash
# Run the self-contained Python tests listed in tools/ci/standalone_tests.txt.
# usage: tools/ci/run_standalone_tests.sh [PYTHON]   (run from the repository root)
PY=${1:-python3}
fail=0; n=0
while read -r t; do
  case "$t" in ''|\#*) continue;; esac
  n=$((n+1))
  if ! timeout 300 "$PY" "$t" >/tmp/standalone-test.out 2>&1; then
    echo "FAIL: $t"; tail -15 /tmp/standalone-test.out; fail=$((fail+1))
  fi
done < tools/ci/standalone_tests.txt
echo "standalone tests: $n run, $fail failed"
[ "$fail" -eq 0 ]
