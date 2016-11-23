$(document).on 'turbolinks:load', ->
  if $('body').data('controller') == 'dashboard' && $('body').data('action') == 'index'
    App.sell = App.cable.subscriptions.create "SellChannel",
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        $('.chart').highcharts().get(data.serie).addPoint([(new Date).getTime(), data.point], true, true)
