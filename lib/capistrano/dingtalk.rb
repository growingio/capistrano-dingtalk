require 'capistrano'
require 'httparty'
require 'uri'
require 'json'

# Build the request to post notice to Dingtalk
class DingtalkClient
  include HTTParty

  base_uri "https://oapi.dingtalk.com"

  def post_notice(action)
    url = "/robot/send?access_token=#{fetch(:dingtalk_access_token)}"

    self.class.post(url,
         headers: {
           'Content-Type' => 'application/json; charset=utf-8'
         },
         body: notice(action).to_json)
  end

  def notice(content)
    {
      'msgtype' => 'text',
      'text' => {
        'content' => content
      },
      'at' => {
        'isAtAll' => true
      }
    }
  end
end

namespace :deploy do
  desc 'Post an notice to dingtalk'
  task :post_dingtalk, :action do |_, args|
    action = args[:action]
    run_locally do
      if fetch(:suppress_dingtalk_notice).casecmp('false')
        DingtalkClient.new.post_notice(action)
        info("#{action.capitalize} notice posted to dingtalk.")
      elsif fetch(:suppress_dingtalk_events).casecmp('true')
        info('No notice posted: `suppress_dingtalk_notice` is set to true.')
      else
        warn('No notice posted: `suppress_dingtalk_notice` is set incorrectly.')
      end
    end
  end

  task :notify_deploy_started do
    command = "git log --no-color --max-count=5 --pretty=format:' - %an: %s' " \
              '--abbrev-commit --no-merges ' \
     "#{fetch(:previous_revision, 'HEAD')}..#{fetch(:current_revision, 'HEAD')}"

    commits = `#{command}`
    message = "#{fetch(:local_user, local_user).strip} is deploying " \
              "#{fetch(:application)} to #{fetch(:stage)}\n"
    message << commits
    invoke('deploy:post_dingtalk', message)
  end

  task :notify_deploy_finished do
    message = "#{fetch(:local_user, local_user).strip} finished deploying " \
              "#{fetch(:application)} to #{fetch(:stage)}."
    invoke('deploy:post_dingtalk', message)
  end

  task :notify_deploy_rollback do
    message = "#{fetch(:local_user, local_user).strip} cancelled deployment " \
              "of #{fetch(:application)} to #{fetch(:stage)}."
    invoke('deploy:post_dingtalk', message)
  end

  # Set the order for these tasks
  before 'deploy:updated', 'notify_deploy_started'
  after 'deploy:finishing', 'notify_deploy_finished'
  after 'deploy:finishing_rollback', 'notify_deploy_rollback'
end

namespace :load do
  task :defaults do
    set :suppress_dingtalk_notice, 'false'
  end
end
