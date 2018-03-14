# Version control and collaboration - part 2

# Fork.
# - A copy of a repository.
# - Experiment with changes without affecting the original project.

# "A fork is really a Github (not Git) construct to store a clone of the repo in
#  your user account." from https://stackoverflow.com/a/13403195

# Demo: forking the scrum club repo.
# Web browser: click 'fork' in upper right corner.

# Clone the forked repository:
git clone https://github.com/ingo-m/scrum-club.git

# Keep fork in sync with original ('upstream') repository.
# List current remote:
git remote -v

# Follow original repository:
git remote add upstream https://github.com/wviechtb/scrum-club

# Verify changes:
git remote -v

# Fetch the upstream (i.e. the original) repository:
git fetch upstream

# Merge the changes from the original repository:
git merge upstream/master

# Push changes (so that the copy on github is also updated):
git push origin master

# Pull requests are used to integrate changes into someone else's repository.

# Make a change to ingo-m/scrum-club (add this file).

git add .
git commit -m "Material for session on 14/03/2018."
git push origin master

# In web browser, make pull request.

# git is not only for software source code.
# For example:
# https://www.overleaf.com

# References
# https://git-scm.com/book/en/v2
