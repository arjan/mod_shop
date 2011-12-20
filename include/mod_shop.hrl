
-record(payment_provider,
        {name, module, function}).

-record(payment_status,
        {status, order_id, details=[]}).
        
-record(shop_order,
        {cart=[],               % the items
         details=[],            % address details

         status,
         id,
         email,
         shopper_ref,

         price_ex_vat=0,        % in cents
         price_inc_vat=0        % in cents
        }).
