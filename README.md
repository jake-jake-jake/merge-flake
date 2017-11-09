# merge-flake
Make linting Python files your branch modifies a breeze.

## Installation

Navigate to your local bin directory, save the script, and make it executable:
```cd ~/bin/
curl https://raw.githubusercontent.com/jake-jake-jake/merge-flake/master/merge-flake.sh > merge-flake
chmod +x merge-flake```

## Usage

In a repo, checkout the branch you want to merge and execute `merge-flake [target]`. 
`merge-flake` defaults to master if you do not specify a target branch. The script
outputs in fancy color the linting errors as found by flake8 in the diff between
the branches.