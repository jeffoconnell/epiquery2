config    = require '../config.coffee'
log       = require './log.coffee'
eClient   = require '@azure/event-hubs'
uuid      = require 'uuid/v4'

class EventPublisher
  @publisher: undefined

  constructor: () ->
    if @publisher == undefined
      try
        @publisher = eClient.EventHubClient.createFromConnectionString(
                  config.eventHubConnString, config.eventHubName)

      catch err
        log.error err

  publish: (eventMsg) ->
    # publish
    @publisher.send(eventMsg).catch((err) => 
      log.error err
    )
        

module.exports.EventPublisher = EventPublisher
