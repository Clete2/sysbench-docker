#!/bin/bash

THREADS=$(nproc --all)

function sleep() {
  printf "\n\n\n\n"
  echo "Resting 5 seconds..."
  echo "----------------------------------------------------------------------------------------------"
  /bin/sleep 5
}

echo "Sysbench version: $(sysbench --version)"
echo "Threads: $THREADS"

COMMON_OPTS="--threads=$THREADS --time=60 --events=0"

sleep
echo "Running CPU benchmark"
sysbench $COMMON_OPTS \
  --cpu-max-prime=100000 \
  cpu \
  run

sleep
echo "Running CPU threads test"
sysbench $COMMON_OPTS \
  --thread-yields=100000 \
  --thread-locks=64 \
  threads \
  run

sleep
echo "Running memory read test"
sysbench $COMMON_OPTS \
  --memory-block-size=512K \
  --memory-total-size=1TB \
  --memory-oper=read \
  --memory-access-mode=rnd \
  --report-interval=5 \
  memory \
  run

sleep
echo "Running memory write test"
sysbench $COMMON_OPTS \
  --memory-block-size=512K \
  --memory-total-size=1TB \
  --memory-oper=write \
  --memory-access-mode=rnd \
  memory \
  run

sleep
echo "Running file sequential write test"
sysbench $COMMON_OPTS \
  --file-test-mode=seqwr \
  fileio \
  run

sleep
echo "Running file sequential read test"
sysbench $COMMON_OPTS \
  --file-test-mode=seqrd \
  fileio \
  run

sleep
echo "Running file sequential rewrite test"
sysbench $COMMON_OPTS \
  --file-test-mode=seqrewr \
  fileio \
  run

sleep
echo "Running file random write test"
sysbench $COMMON_OPTS \
  --file-test-mode=rndwr \
  fileio \
  run

sleep
echo "Running file random read test"
sysbench $COMMON_OPTS \
  --file-test-mode=rndrd \
  fileio \
  run

sleep
echo "Running file random rewrite test"
sysbench $COMMON_OPTS \
  --file-test-mode=rndrw \
  fileio \
  run

sleep
echo "Running mutex test"
sysbench $COMMON_OPTS \
  mutex \
  run