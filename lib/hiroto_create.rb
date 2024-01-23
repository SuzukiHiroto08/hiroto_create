# frozen_string_literal: true

require_relative "hiroto_create/version"

module HirotoCreate
  class Error < StandardError; end
  def self.hiroto_create
    # .git ファイルを作る
    system("git init")

    # リポジトリ名の入力
    print 'Enter the repository name: '
    repo_name = gets.chomp.strip

    # GitHubユーザー名の入力
    print 'Enter your GitHub username: '
    username = gets.chomp.strip

    # publicかprivateかを聞く
    print 'Enter public or private: '
    flag = gets.chomp.strip

    # リモートリポジトリのSSH
    remote_repo_url = "git@github.com:#{username}/#{repo_name}.git"

    # リモートリポジトリの作成
    system("gh repo create #{username}/#{repo_name} --#{flag}")

    # GitHubにログイン
    system('gh auth login')

    # リモートリポジトリへの接続
    system("git remote add origin #{remote_repo_url}")
  end
end
