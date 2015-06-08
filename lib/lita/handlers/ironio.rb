require 'iron_worker_ng'
require 'iron_mq'

module Lita
  module Handlers
    class Ironio < Handler
      config :project_id, required: true
      config :token, required: true


      class << self
        attr_accessor :iron
      end

      def self.config(config)
        self.iron = nil
      end

      route /^ir(?:on)?\s(tasks|stacks|schedules|queues|caches)$/i, :list, help: {
        "iron tasks" => "list project tasks",
        "iron stacks" => "list available stacks",
        "iron codes" => "list project code packages",
        "iron queues" => "list project queues",
      }

      route /^ir(?:on)?\s(tasks|stacks|codes|schedules|queues)?\s(.+)$/i, :get, help: {
        "iron tasks [id]" => "list project tasks",
        "iron stacks [id]" => "list available stacks",
        "iron codes [id]" => "list project code packages",
        "iron queues [id]" => "list project queues",
      }

      def list(msg)
        reply = nil
        response = self.client("#{msg.matches.flatten.first}".to_sym).send("#{msg.matches.flatten.first}_list")
        case response
          when 0, nil, []
            reply = "No #{msg.matches.flatten.first}"
          else
            reply = response
        end
        msg.reply reply
      end

      def get(msg)
        reply = nil
        begin
          response = self.client("#{msg.matches.flatten.first}".to_sym).send("#{msg.matches.flatten.first}_get", msg.matches.flatten[1])
        rescue
          response = "Welps!"
        end
        case response
          when 0, nil, []
            reply = "No #{msg.matches.flatten.first}"
          else
            reply = response
        end
        msg.reply reply
      end

      def client(lib)
        plugin = {
          [:stacks, :tasks, :codes] => :worker,
          [:queues] => :mq,
        }.select {|k,v| k.include?(lib) }.values
        case plugin.first
          when :worker
            self.class.iron ||= IronWorkerNG::Client.new({token: config.token, project_id: config.project_id})
          when :mq
            self.class.iron ||= IronMQ::Client.new({token: config.token, project_id: config.project_id})
          else
            self.class.iron ||= IronWorkerNG::Client.new({token: config.token, project_id: config.project_id})
        end
      end
    end

    Lita.register_handler(Ironio)
  end
end
