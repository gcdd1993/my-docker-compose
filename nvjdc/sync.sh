#!/bin/bash
docker pull nolanhzy/nvjdc:"$VERSION" \
&& docker tag nolanhzy/nvjdc:"$VERSION" gcdd1993/nvjdc:"$VERSION" \
&& docker push gcdd1993/nvjdc:"$VERSION"

docker pull nolanhzy/nvjdc:latest \
&& docker tag nolanhzy/nvjdc:latest gcdd1993/nvjdc:latest \
&& docker push gcdd1993/nvjdc:latest