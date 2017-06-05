#!/bin/sh

kill -9 $(ps -aef | grep node | grep -v grep | awk '{ print $2}')
kill -9 $(ps -aef | grep tplogin.Application | grep -v grep | awk '{ print $2}')
