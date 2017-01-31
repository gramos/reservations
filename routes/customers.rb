class Customers < Cuba

  define do
    on get, ':city', param('q') do |city, q|
      as_json do

        city_id = DB[:cities].where( :name => URI.decode(city) ).first[:id]

        Customer.where(:last_name => /#{q}/i).all.map do |c|

          address = Address.where(:customer_id => c.id, :city_id => city_id).first
          address ||= {}

          addresses   = Address.where( :customer_id => c.id,
                                       :city_id => city_id ).map{|a| a.to_hash}
          addresses ||= []

          c.to_hash.merge({:address => address.to_hash, :addresses => addresses})
        end
      end
    end

    on get, param('q') do |q|
      customers_ds = Customer.order(:first_name).
                     where( Sequel.function(:lower, :last_name).
                            like("#{q.downcase}%") )

      @pager = Paginator.create(customers_ds.count, 8) do |offset, per_page|
        customers_ds.limit(per_page).offset(offset)
      end

      @page = @pager.page( req.params['page'] )

      render 'customers/index', { :customers => @page,
                                  :customer => Customer.new }

    end

    on get do
      @pager = Paginator.create(Customer.count, 8) do |offset, per_page|
        Customer.order(:last_name).limit(per_page).offset(offset)
      end

      @page = @pager.page( req.params['page'] )

      on param('customer_id') do |id|
        render 'customers/index', { :customers => @page,
                                    :customer => Customer[id] }
      end

      render 'customers/index', { :customers => @page,
                                  :customer => Customer.new }
    end



    # -----------------------------------------------------
    # Delete customer
    #
    on post, ':id/delete' do |id|
      DB.transaction do
        Address.where("customer_id = ?", id).delete
        Customer[id].delete
      end

      res.redirect "/customers"
    end

    # -----------------------------------------------------
    # Update customer / create or update address
    #
    on post, ':id' do |id|
      address_id = req.params['address'].delete('id')
      customer   = Customer[id]

      DB.transaction do
        customer.update( req.params['customer'] )

        if address_id.empty?
          customer.add_address( req.params['address'] )
        else
          Address[address_id].update( req.params['address'] )
        end
      end

      res.redirect "/customers?customer_id=#{id}"
    end

    # ----------------------------------------------------------
    # Create customer
    #
    on post, param('customer'), param('address') do |c, a|
      a.delete('id')

      customer = nil
      address  = nil

      DB.transaction do
        customer = Customer.create(c)
        customer.add_address(a)
      end

      res.redirect "/customers?customer_id=#{customer.id}"
    end

  end
end
