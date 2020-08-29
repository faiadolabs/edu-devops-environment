#!/usr/bin/python3
import sys
from os import walk, listdir
from os.path import isfile, isdir, join
from git import Repo
from git.repo.fun import is_git_dir

# print("The script has the name %s" % (sys.argv[0]))
# print("Argument List: %s" % str(sys.argv))

mypath = sys.argv[1]

# --------------------------------------------
# f = []
# for (root, dirs, files) in walk(mypath):
#     print(str(root), str(dirs), str(files))
# --------------------------------------------

# Es una ternaria con una inizaliciación por iteración
onlyRepos = [f for f in listdir(mypath) if isdir(join(mypath, f)) and isdir(join(mypath, f, ".git"))]
print(onlyRepos)

for repo_name in onlyRepos:
    repo = Repo(join(mypath, repo_name))
    print(repo.remotes)

# --------------------------------------------
# from git import Repo, InvalidGitRepositoryError

# try:
#     Repo(path_to_repo)
#     print 'is git repo'
# except InvalidGitRepositoryError:
#     print 'isn`t git repo'
# --------------------------------------------