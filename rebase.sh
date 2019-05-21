#!/bin/sh

BRANCHES=$( git branch | cut -c3-999 )

OLD_IFS=$IFS
IFS=$'\n'

git fetch --all

git checkout master
git rebase upstream/master

for BRANCH in $BRANCHES
do
if [ "$BRANCH" == "master" ]; then
	echo Not rebasing branch: $BRANCH
else
	echo Rebasing branch: $BRANCH
	git checkout $BRANCH
	git rebase upstream/master
fi
done
IFS=$OLD_IFS

git checkout master

echo "Time to do a 'git push --all -f'?"
