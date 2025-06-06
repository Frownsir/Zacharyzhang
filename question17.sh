cd git-practice-03
cp dir3/bar dir3/bar_copy
git add dir3/
git commit -m "main branch modified"
git branch branch1
git switch branch1
mv dir1/dir2/foo dir1/
rm -rf dir1/dir2/
rm -rf dir3/bar_copy
touch newfile1
git add . 
git commit -m "branch1 created and modified"
git switch main
git branch branch2
git switch branch2
mv dir1/dir2/foo dir1/dir2/foo_modified
rm -rf dir3/
mkdir dir1/dir3
touch dir1/dir3/newfile2
git add .
git commit -m "branch2 created and modified"