#!/bin/bash

echo "===> Making Files"

touch $1_{deployment,service,secrets,namespace}.yaml

touch pg_$1_{pvc,secrets,service,stateful_set}.yaml

echo "===> DONE !!!!"