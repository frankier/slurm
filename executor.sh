#!/usr/bin/env bash

tmp_dir=$1

if [[ -z "$NO_CLEANUP" ]]; then
  trap "exit" INT TERM
  trap "rm -rf $tmp_dir" EXIT
fi

while IFS= read -r line
do
  iden=${line%%" "*}
  cmd=${line#*" "}
  echo "Running iden: $iden on behalf of container: $cmd"
  $cmd > $tmp_dir/req_run/$iden.stdout 2> $tmp_dir/req_run/$iden.stderr
  echo $? > $tmp_dir/req_run/$iden.code
  cat $tmp_dir/req_run/$iden.stdout
  cat $tmp_dir/req_run/$iden.stderr
done
