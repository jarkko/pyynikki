namespace :git do
  desc "Get latest from upstream"
  task :pull do
    system("git-svn rebase")
  end

  desc "Push local git branch to remote svn"
  task :push do
    system("git-svn dcommit")
  end
end