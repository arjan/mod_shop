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

-export([manage_schema/2, event/2]).

%% @doc Add an item to the shoppingcart.
event({submit, {add_to_cart, [{id, Id}, {variant_id, VariantId}]}, _, _}, Context) ->

    Amount = abs(z_convert:to_integer(z_context:get_q("amount", Context))),
    Price = z_convert:to_float(m_rsc:p(VariantId, price, Context)),
    Item = [{variant_id, VariantId}, {id, Id}, {price, Price}, {size, z_context:get_q("size", Context)}],

    m_shoppingcart:add_to_cart(Amount, Item, Context),   
    Context.


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
