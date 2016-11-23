App.sell = App.cable.subscriptions.create "SellChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    switch data.graph
      when 'sells' then $('.chart').highcharts().get(data.serie).addPoint([(new Date).getTime(), data.point], true, true)
      when 'stock'
        categories = $.map JSON.parse(data.products), (product) ->
          product.name

        product_stock = $.map JSON.parse(data.products), (product) ->
          { name: product.name, data: [parseFloat(product.stock)] }


        $('.stock-chart').highcharts({
          chart:
            type: 'column'
          title:
            text: 'Products Stock'
          subtitle:
            text: 'products with less of 20 items in stock'
          xAxis:
            categories: categories
            crosshair: true
          yAxis:
            min: 0
            title:
              text: 'Units'
          tooltip:
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>'
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' + '<td style="padding:0"><b>{point.y:.1f} units</b></td></tr>'
            footerFormat: '</table>'
            shared: true
            useHTML: true
          plotOptions:
            column:
              pointPadding: 0.2
              borderWidth: 0
          series: product_stock
        })


