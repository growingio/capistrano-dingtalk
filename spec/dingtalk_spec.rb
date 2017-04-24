# dingtalk_spec.rb
require 'spec_helper'
require 'capistrano/dingtalk.rb'

RSpec.describe DingtalkClient do
  describe '#post_notice' do
    context 'deploy' do
      it 'posts a deploy notice to dingtalk' do
        stub_request(:post, 'https://oapi.dingtalk.com/robot/send?access_token=')
          .with(body: "{\'what\': \'deploy backend\', \'tags\': " \
          "\'backend,randomsha,deploy\', \'data\': \'testuser\'}")
          .to_return(status: '200', body: '', headers: {})
      end
    end

    context 'rollback' do
      it 'posts a rollback notice to dingtalk' do
        stub_request(:post, 'https://oapi.dingtalk.com/robot/send?access_token=')
          .with(body: "{\'what\': \'rollback backend\', \'tags\': " \
          "\'backend,randomsha,deploy\', \'data\': \'testuser\'}")
          .to_return(status: '200', body: '', headers: {})
      end
    end
  end
end
