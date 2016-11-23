$(document).on 'turbolinks:load', ->
  if $('body').data('controller') == 'dashboard' && $('body').data('action') == 'index'
    Highcharts.setOptions global: useUTC: false
    $('.chart').highcharts({
      chart:
        type: 'spline'
        marginRight: 10
      title: text: 'Live sells'
      xAxis:
        type: 'datetime'
        tickPixelInterval: 150
      yAxis:
        title: text: 'Value'
        plotLines: [ {
          value: 0
          width: 1
          color: '#808080'
        },
          {
            value: 1
            width: 1
            color: '#809090'
          }]
      tooltip: formatter: ->
        '<b>' + @series.name + '</b><br/>' + Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', @x) + '<br/>' + Highcharts.numberFormat(@y, 2)
      legend: enabled: false
      exporting: enabled: false
      series: [
        {
          id: 'serie-1'
          name: 'Leche'
          data: do ->
            data = []
            time = (new Date).getTime()
            i = undefined
            i = -19
            while i <= 0
              data.push
                x: time + i * 1000
                y: Math.random()
              i += 1
            data

        },
        {
          id: 'serie-2'
          name: 'Pollo'
          data: do ->
            data = []
            time = (new Date).getTime()
            i = undefined
            i = -19
            while i <= 0
              data.push
                x: time + i * 1000
                y: Math.random()
              i += 1
            data

        },
        {
          id: 'serie-3'
          name: 'Arepas'
          data: do ->
            data = []
            time = (new Date).getTime()
            i = undefined
            i = -19
            while i <= 0
              data.push
                x: time + i * 1000
                y: Math.random()
              i += 1
            data

        }
      ]
    })



    $.getJSON '/products.json?low_stock=true', (products) ->
      categories = $.map products, (product) ->
        product.name

      product_stock = $.map products, (product) ->
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
