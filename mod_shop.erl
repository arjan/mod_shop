%% @author Arjan Scherpenisse <arjan@scherpenisse.net>
%% @copyright 2011 Arjan Scherpenisse <arjan@scherpenisse.net>
%% Date: 2011-12-05

%% @doc Simple shoppingcart mechanism.

%% Copyright 2011 Arjan Scherpenisse
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(mod_shop).
-author("Arjan Scherpenisse <arjan@scherpenisse.net>").

-mod_title("Shop").
-mod_description("A shoppingcart and checkout process for Zotonic.").
-mod_depends([mod_signal]).
-mod_schema(1).

-include_lib("include/zotonic.hrl").
-include_lib("include/mod_shop.hrl").

-export([
         manage_schema/2,
         event/2,
         observe_payment_status/2
        ]).

%% @doc Add an item to the shoppingcart.
event({submit, {add_to_cart, [{id, Id}, {variant_id, VariantId}]}, _, _}, Context) ->

    Amount = abs(z_convert:to_integer(z_context:get_q("amount", Context))),
    Price = z_convert:to_float(m_rsc:p(VariantId, price, Context)),
    Item = [{variant_id, VariantId}, {id, Id}, {price, Price}, {size, z_context:get_q("size", Context)}],

    m_shoppingcart:add_to_cart(Amount, Item, Context),   
    Context;

%% @doc On submit of the checkout form.
event({submit, {checkout, []}, _, _}, Context) ->

    %% Get the checkout details
    FormValues = z_context:get_q_validated(
                   [firstname, lastname, address, postcode, city, phone, email], Context),


    Cart = m_shoppingcart:get_cart(Context),
    Order = order_from_cart(Cart, FormValues, Context),

    %% Store the order
    Order1 = store_order(Order, Context),
    
    %% Do the payment
    payment_redirect(Order1, Context).



%% @doc A payment has been made. Redirect to a sane location.
observe_payment_status(#payment_status{status=Status, order_id=OrderId, details=Details}, Context) ->

    ContextAdmin = z_acl:sudo(Context),

    %% Add information to the order
    m_rsc:update(OrderId, [{payment, Details}, {status, Status}], ContextAdmin),
    
    %% Clear the cart
    m_shoppingcart:empty_cart(Context),

    %% Set order in session
    OrderRsc = m_rsc:get(OrderId, Context),
    z_context:set_session(shop_order, OrderRsc, Context),

    %% E-mail
    Email = proplists:get_value(email, proplists:get_value(details, proplists:get_value(order, OrderRsc))),

    %% Mail the user
    z_email:send(#email{
                    to=Email,
                    bcc="arjan@miraclethings.nl",
                    reply_to=m_site:get(reply_to, Context),
                    html_tpl="email_order_confirm.tpl",
                    vars=[{order_id, OrderId}]
                   }, Context),
    

    %% Redirect
    z_dispatcher:url_for(shop_order_status, [{id, OrderId}], Context).


manage_schema(install, _Context) ->
    #datamodel{categories=
                   [
                    {shop_order, undefined, [{title, <<"Shop order">>}]}
                   ],
               resources=
                   [
                    {page_shoppingcart, text, [{title, <<"Shopping cart">>}, {page_path, <<"/cart">>}]},
                    {page_checkout, text, [{title, <<"Checkout">>}, {page_path, <<"/checkout">>}]}
                   ]
              }.



%% @doc Given a shopping cart, create an order record.
order_from_cart(Cart, FormValues, Context) ->
    Items = proplists:get_value(items, Cart),
    Items1 = [[{amount, Amount} | Item] || {Item, Amount} <- Items],
    Cart1 = z_utils:prop_replace(items, Items1, Cart),
    Price = proplists:get_value(total, Cart1),
    Order = #shop_order{
      status = new,
      cart = Cart1,
      details = FormValues,
      id = undefined,
      email = proplists:get_value(email, FormValues),
      shopper_ref = z_context:persistent_id(Context),
      price_ex_vat = Price*100,
      price_inc_vat = round(Price*1.19*100)},
    Order.


%% @doc Store the order in the database.
store_order(Order=#shop_order{}, Context) ->
    ContextAdmin = z_acl:sudo(Context),
    Props = [{category, shop_order},
             {title, ["Shop order on ", erlydtl_dateformat:format("j F Y, H:i", ContextAdmin)]},
             {is_published, true},
             {status, Order#shop_order.status},
             {order, lists:zip(record_info(fields, shop_order), tl(tuple_to_list(Order)))},
             {visible_for, ?ACL_VIS_USER}],
    {ok, Id} = m_rsc:insert(Props, ContextAdmin),
    ?DEBUG(Id),
    Order#shop_order{id=Id}.
    

%% @doc Handle the payment of the order based on the payment-provider POST value.
payment_redirect(Order, Context) ->
    %% Get the provider
    Pp = list_to_existing_atom(z_context:get_q("payment-provider", Context)),
    Provider = hd(lists:filter(fun(P) -> case P#payment_provider.module of Pp -> true; _ -> false end end,
                               m_shop:get_payment_providers(Context))),

    Module = Provider#payment_provider.module,
    Function = Provider#payment_provider.function,
    Module:Function(Order, Context).
    
