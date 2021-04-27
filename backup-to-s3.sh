#!/bin/bash
cd ~/valheim-backups
aws s3 cp worlds s3://8dot3/valheim/worlds --recursive
