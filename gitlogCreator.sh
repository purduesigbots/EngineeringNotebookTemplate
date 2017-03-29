#!/bin/bash

# Must be run in the root directory of a PROS project
# Just runs the commands needed to use the existing gitlog2latex script
curl -O https://gist.githubusercontent.com/baylessj/ecd442868afcf838a0b7907e3db10908/raw/f906055eae50fce0001c3dc3a62b017b3671c36c/gitlogLaTeX.sh
export GHCRTS=-V0
chmod a+x gitlogLaTeX.sh
./gitlogLaTeX.sh
