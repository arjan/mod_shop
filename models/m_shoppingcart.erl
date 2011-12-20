%% @author Arjan Scherpenisse <arjan@scherpenisse.net>
%% @copyright 2011 Arjan Scherpenisse <arjan@scherpenisse.net>
%% Date: 2011-12-05

%% @doc Model for shopping cart

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

-module(m_shoppingcart).
-author("Arjan Scherpenisse <arjan@scherpenisse.net>").

%% interface functions
-export([
         m_find_value/3,
         m_to_list/2,
         m_value/2,

         get_cart/1,
         add_to_cart/3,
         update_cart/3,
         remove_from_cart/2,
         empty_cart/1
]).


-include_lib("zotonic.hrl").


%% @doc Fetch the value for the key from a model source
%% @spec m_find_value(Key, Source, Context) -> term()
m_find_value(X, #m{value=undefined}, Context) ->
    proplists:get_value(X, get_cart(Context)).


%% @doc Transform a m_config value to a list, used for template loops
%% @spec m_to_list(Source, Context) -> List
m_to_list(_, Context) ->
    get_cart(Context).

%% @doc Transform a model value so that it can be formatted or piped through filters
%% @spec m_value(Source, Context) -> term()
m_value(_, _Context) ->
    undefined.


%% @doc Get the cart from the sesion.
get_cart(Context) ->
    z_context:get_session(m_shoppingcart, Context,
                          [{items, []},
                           {total, 0},
                           {count, 0}]).

%% @doc Get only the items from the cart.
get_cart_items(Context) ->
    proplists:get_value(items, get_cart(Context)).


%% @doc Set the shopping cart to its new contents.
set_cart(Items, Context) ->
    Total = lists:foldl(fun({I, C}, X) -> proplists:get_value(price, I, 0)*C+X end, 0.0, Items),
    Count = lists:sum([C || {_, C} <- Items]),
    Cart = [{items, Items},
            {total, Total},
            {count, Count}],
    z_context:set_session(m_shoppingcart, Cart, Context),
    mod_signal:emit({shoppingcart_changed, [{cart, z_context:persistent_id(Context)}]}, Context).


%% @doc Add an item to the cart (one or more of the same)
add_to_cart(Amount, Item, Context) when is_integer(Amount) andalso Amount > 0 ->
    Items = get_cart_items(Context),
    Items1 = case proplists:get_value(Item, Items) of
                 undefined ->
                     [{Item, Amount} | Items];
                 Count when is_integer(Count) ->
                     z_utils:prop_replace(Item, Count+Amount, Items)
             end,
    set_cart(Items1, Context).

%% @doc Update the amount of items in the cart
update_cart(0, Item, Context) ->
    remove_from_cart(Item, Context);
update_cart(Amount, Item, Context) when is_integer(Amount) andalso Amount > 0 ->
    Items = get_cart_items(Context),
    Items1 =z_utils:prop_replace(Item, Amount, Items),
    set_cart(Items1, Context).


%% @doc Remove an item from the cart.
remove_from_cart(Item, Context) ->
    set_cart(proplists:delete(Item, get_cart_items(Context)), Context).


%% @doc Empty the shoppingcart.
empty_cart(Context) ->
    set_cart([], Context).
