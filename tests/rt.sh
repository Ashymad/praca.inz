#!/bin/sh

chrt -f -p 99 $$
exec $*
