# Version control and collaboration

# git originated from the linux project.

# (1) Version control

# Version control is a system that records changes to a file or set of files
# over time so that you can recall specific versions later.

# Primitive form of version control: keeping many versions of a file.
# Error prone.

# (2) Collaboration & sharing

# Pritimitve form of sharing: sending files by email.
# Error prone.

# Professional solution for version control: version control system
# git
git --help

# Professional solution for sharing: Distributed version control system
# github
# https://github.com/

# Purpose of git & github:
# - Keep track of changes, and revert if necessary
# - Share between people or devices
# - Test changes without risk to the original

# Create repository on github (using web browser)

# Clone the repository:
git clone https://github.com/ingo-m/scrum_club_test.git

# Create text file within repository.

# Check what has happened:
git status

# File is 'untracked' (i.e. git doesn't know about it).
git add .

# Check status again:
git status

# Commit:
git commit -m "Added a text file."

git status

# Push changes to remote:
git push

git status

# Change text file.

git status

git diff

git add .

git commit -m "Added text."

git push

# Github: you can access any version of your documents at any point in time.
# Often you would do this using the web browser:
# Example: https://github.com/ingo-m/pyprf/commit/12d95556b70d30d34b5d2608cf25ff2db411870e

# But it can also be done locally:
git log
git show <commit id>

# git keeps entire history of the project (robust).

# Pull changes made from a collaborator (or by you from another computer):
git pull

# Branches:
git branch -a

# Create new branch:
git branch devel

git branch -a

git checkout devel

# Create a new text file. Add and commit it.
git add .
git commit -m "Experimental change."

# Push changes to devel branch:
git push origin devel

# Check repo in web browser. Also look at network graph.

# Go back to master branch:
git checkout master

# Make change to main text file, and push changes.
git add .
git commit -m "Normal work done on master."
git push origin master

# Again, check branches in web browser.

# Merge changes from devel:
git merge devel -m "Merge experimental changes."
git push origin master

# Check results in web browser.

# Fork.
# - A copy of a repository.
# - Experiment with changes without affecting the original project.

# Demo: forking the scrum club repo.
# Web browser: click 'fork' in upper right corner.

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
git commit -m "Material for session on 28/02/2018."
git push origin master

# In web browser, make pull request.

# git is not only for software source code.
# For example:
# https://www.overleaf.com

# References
# https://git-scm.com/book/en/v2
