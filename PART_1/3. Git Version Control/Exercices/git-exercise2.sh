git rm -r --cached build/
git rm --cached .DS_Store  # -r not need cause file and not dir
git rm -r --cached .idea/

touch .gitignore
echo 'build/' >> .gitignore  # do not ignore build.grade !
echo '.DS_Store' >> .gitignore
echo '.idea/' >> .gitignore

