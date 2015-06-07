# lita-ironio [![Gem Version](https://badge.fury.io/rb/lita-ironio.svg)](http://badge.fury.io/rb/lita-ironio)

**lita-ironio** is an handler for [Lita](https://www.lita.io) that gives your bot the power to interact with [Iron.io](https://iron.io)'s [IronWorker](http://www.iron.io/worker), [IronMQ](http://www.iron.io/mq), and [IronCache](http://www.iron.io/cache) solutions.

TODO: Add a description of the plugin.

## Installation

Add lita-ironio to your Lita instance's Gemfile:

``` ruby
gem "lita-ironio"
```

## Configuration
### Required attributes


* `token` (String) – Project specific tokenfrom the hud
* `project_id` (String) – Identifier of the project

### Example

``` ruby
Lita.configure do |config|
config.handlers.ironio.token = ENV["IRONIO_TOKEN"] 
config.handlers.ironio.project_id = ENV["IRONIO_PROJECT_ID"]
end
```

## Usage

Commands are called in the with the `iron` prefix what can be optionally with the `ir` abbreviation.

```shell
iron tasks
ir schedules
iron tasks <TASKID>
```

### Example

`iron schedules` lists all the configured schdules for the project.

## License

[MIT](http://opensource.org/licenses/MIT)
