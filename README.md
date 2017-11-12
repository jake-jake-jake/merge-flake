# merge-flake
Make linting Python files your pull request modifies a breeze.

## Installation

Navigate to your user bin directory, save the script, and make it executable:

```
cd ~/bin/
curl https://raw.githubusercontent.com/jake-jake-jake/merge-flake/master/merge-flake.sh > merge-flake
chmod +x merge-flake
```

## Usage

In a repo, checkout the branch you want to merge and execute `merge-flake [target branch]`. 
`merge-flake` defaults to master if you do not specify a target branch. The script
outputs in fancy color the linting errors flake8 finds in the diff between the
branches.