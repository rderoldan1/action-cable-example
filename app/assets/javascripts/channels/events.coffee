App.events = App.cable.subscriptions.create "EventsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('.events tbody').prepend("<tr><td>#{data.message}</td></tr>")
    if $('.events tr').length == 21
      $('.events tr')[20].remove()

