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

@test "reads multiple lines from stdin" {
  echo "asdf" >"${testdir}/in"
  echo "qwerty" >>"${testdir}/in"
  echo "zxcvbn" >>"${testdir}/in"

  ./bin/cat <"${testdir}/in" >"${testdir}/out"

  diff "${testdir}/in" "${testdir}/out"
}

@test "read lines starting with whitespace" {
  echo "      alksjdfalskfda" >"${testdir}/in"

  ./bin/cat <"${testdir}/in" >"${testdir}/out"

  diff "${testdir}/in" "${testdir}/out"
}

@test "reads file from first argument" {
  echo "asdf" >"${testdir}/in"
  echo "zxcvbn" >>"${testdir}/in"

  ./bin/cat "${testdir}/in" >"${testdir}/out"

  diff "${testdir}/in" "${testdir}/out"
}
