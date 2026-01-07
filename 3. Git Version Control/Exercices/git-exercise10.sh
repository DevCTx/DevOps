git branch -a

#delete bugfix branch
git branch -d bugfix/spell_error 
git push origin --delete bugfix/spell_error 

#delete feature branch
git branch -d feature/logstash_upgrade 
git push origin --delete feature/logstash_upgrade

#check and verify
git branch -a
git ls-remote --heads origin

