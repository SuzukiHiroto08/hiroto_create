# frozen_string_literal: true

require_relative "hiroto_create/version"

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

  when 'いいえ', 'no'
    puts "インストールを中止しました。hiroto_createを使用するには手動でghコマンドをインストールしてください。"
    exit(1)

  else
    puts "無効な入力です。yesかnoで答えてください。"
    exit(1)
  end
end
