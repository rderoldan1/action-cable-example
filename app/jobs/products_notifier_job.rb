class ProductsNotifierJob < ApplicationJob
  queue_as :default

  def perform(product_id, event)
    product = Product.find_by(id: product_id)
    params = { event: event, id: product_id }
    if product
      params[:product] = ProductsController.render(partial: 'product', locals: { product: product })
    end
    ActionCable.server.broadcast('products', params )
    ActionCable.server.broadcast('events', message: "#{event} product with id #{product_id}" )
    ActionCable.server.broadcast('notifications', message: "#{event} product with id #{product_id}" )
  end
end
