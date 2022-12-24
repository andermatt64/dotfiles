#!/bin/sh

sed -i 's/decorations: none/decorations: full/g' $1
sed -i 's/size: 7\.5/size: 9/g' $1
