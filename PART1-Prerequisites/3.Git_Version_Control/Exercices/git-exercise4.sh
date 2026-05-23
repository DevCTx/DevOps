git checkout main
git checkout -b bugfix/spell_error

# fix spelling bug into Application.java
#         log.info("Java app started");
# instead of 
#         log.info("Java app starte");

git diff

git add .
git commit -m "fix spelling bug into Application.java"
git push --set-upstream origin bugfix/spell_error
