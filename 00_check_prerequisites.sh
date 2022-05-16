#!/bin/sh


if [ -z "$HCP_CLIENT_ID" ]
then
    echo "\$HCP_CLIENT_ID must be set." >&2
	exit -1
fi

if [ -z "$HCP_CLIENT_SECRET" ]
then
    echo "\$HCP_CLIENT_SECRET must be set." >&2
	exit -1
fi

if [ -z "$GITLAB_TOKEN" ]
then
    echo "\$GITLAB_TOKEN must be set." >&2
	exit -1
fi

if [ -z "$TFE_TOKEN" ]
then
    echo "\$TFE_TOKEN must be set." >&2
	exit -1
fi

