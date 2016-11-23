$(document).on 'turbolinks:load', ->
  if $('body').data('controller') != 'dashboard'





    App.notifications = App.cable.subscriptions.create "NotificationsChannel",
     connected: ->
        # Called when the subscription is ready for use on the server
      
      disconnected: ->
        # Called when the subscription has been terminated by the server
      
      received: (data) ->
        $.notify({
          message: data.message
        },{
          type: 'info',
          newest_on_top: true,
          showProgressbar: true,
          delay: 2000
        })




