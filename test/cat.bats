#!/usr/bin/env bats

setup() {
  testdir=$(mktemp -d)
}

teardown() {
  rm -rf -- "$testdir"
}

@test "reads one line from stdin" {
  echo "asdf" >"${testdir}/in"
  ./bin/cat <"${testdir}/in" >"${testdir}/out"
  diff "${testdir}/in" "${testdir}/out"
}
