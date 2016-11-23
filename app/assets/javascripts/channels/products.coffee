$(document).on 'turbolinks:load', ->
  if $('body').data('controller') == 'products' && $('body').data('action') == 'index'
    App.products = App.cable.subscriptions.create "ProductsChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
    
      disconnected: ->
        # Called when the subscription has been terminated by the server
    
      received: (data) ->
        console.log(data.event)
        debugger
        switch data.event
          when 'create' then $('#product-list tbody').prepend(data.product)
          when 'update' then $('#product-list #' + data.id).html(data.product)
          when 'destroy' then $('#product-list #' + data.id).addClass('table-danger').remove()
          else console.log(data.event)
