#!/bin/bash

if [ $# != 2 ]; then
	echo "Usage: $0 <infile> <outfile>"
	exit 1
fi

set -exuo pipefail

INFILE=$1
OUTFILE=$2
sed "s/#.*//" ${INFILE} | xxd -r -p - ${OUTFILE}
chmod 755 ${OUTFILE}
