# coding: utf-8
# frozen_string_literal: true

require_relative "hiroto_create/version"

module HirotoCreate
  class Error < StandardError; end
  def self.hiroto_create

    # .gitファイルを作る
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

    # ghコマンドがインストールされているか確認
    gh_installed = system('which gh > /dev/null')

    unless gh_installed
      puts "ghコマンドが見つかりません。"

      # インストール確認
      print "ghコマンドをインストールしますか？ (yes/no): "
      user_input = gets.chomp.strip.downcase

      case user_input
      when 'yes'
        # macOSの場合
        if RUBY_PLATFORM.include?('darwin')
          puts "GitHub CLI (gh)のインストール中..."
          system('brew install gh') 
          # インストールの完了を待機する
        end

        # Linuxの場合 (ここではUbuntu)
        if RUBY_PLATFORM.include?('linux')
          puts "GitHub CLI (gh)のインストール中..."
          system('sudo apt install gh') 
          # インストールの完了を待機する
        end

        # インストールが成功したか再度確認
        gh_installed_after_install = system('which gh > /dev/null')
        if gh_installed_after_install
          puts "GitHub CLI (gh)のインストールが完了しました。"
        else
          puts "GitHub CLI (gh)のインストールに失敗しました。手動でインストールしてください。"
          exit(1)
        end

      when 'no'
        puts "インストールを中止しました。hiroto_createを使用するには手動でghコマンドをインストールしてください。"
        exit(1)

      else
        puts "無効な入力です。yesかnoで答えてください。"
        exit(1)
      end
    end


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
