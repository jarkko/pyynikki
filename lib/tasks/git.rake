namespace :git do
  desc "Get latest from upstream"
  task :pull do
    system("git pull")
  end

  desc "Push local git branch to remote svn"
  task :push do
    system("git push origin master")
  end
end