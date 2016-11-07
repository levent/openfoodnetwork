Spree::Core::ControllerHelpers::Order.class_eval do
  def current_order_with_scoped_variants(create_order_if_necessary = false)
    order = current_order_without_scoped_variants(create_order_if_necessary)

    if order
      scoper = OpenFoodNetwork::ScopeVariantToHub.new(order.distributor)
      order.line_items.each do |li|
        scoper.scope(li.variant)
      end
    end

    order
  end
  alias_method_chain :current_order, :scoped_variants
end
