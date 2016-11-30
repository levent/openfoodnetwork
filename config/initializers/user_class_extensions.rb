Spree::Core::Engine.config.to_prepare do
  if Spree.user_class
    Spree.user_class.class_eval do

      # Override of spree method to ignore orders associated with account_invoices
      def last_incomplete_spree_order_with_ignoring_account_invoices
        spree_orders.incomplete.where("id NOT IN (?)", account_invoices.map(&:order_id)).order('created_at DESC').first
      end
      alias_method_chain :last_incomplete_spree_order, :ignoring_account_invoices
    end
  end
end
