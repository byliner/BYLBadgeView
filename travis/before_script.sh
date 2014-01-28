#!/bin/sh
brew update
status=$?
if [[ $status != 0 ]] ; then
	exit $status
fi

# Upgrade may fail if we're at the latest version, but that's okay
brew upgrade xctool
exit 0
