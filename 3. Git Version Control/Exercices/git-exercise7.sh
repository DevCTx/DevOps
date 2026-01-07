# modif spell error in index.html
#        <li>Sarah - Full stack developer</li>
# instead of 
#       <li>Sarah - Full stack devlopper</li>

git add .
git commit -m "modif spell error in index.html"
git push

# modif img in index.html
#    <img src="https://cdn1.careeraddict.com/uploads/article/64692/large-career-clarity.webp" />
# instead of 
#    <img src="https://www.careeraddict.com/uploads/article/58721/illustration-group-people-team-meeting.jpg" />

git add .
git commit -m "modif img in index.html"
git push

git log 

# check the last commit id

git revert <last commit id>
git push
