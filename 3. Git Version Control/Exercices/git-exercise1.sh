cd ~
git clone https://gitlab.com/twn-devops-bootcamp/latest/03-git/git-exercises
cd ~/Documents/DevOps/3.\ Git\ Version\ Control/Exercices/
cp -r ~/git-exercises/* ./git-exercises
git pull
git status
git add git-exercises/
git commit -m "Add git-exercises copy"
git push

