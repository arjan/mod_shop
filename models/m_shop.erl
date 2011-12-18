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

-module(m_shop).
-author("Arjan Scherpenisse <arjan@scherpenisse.net>").

%% interface functions
-export([
         m_find_value/3,
         m_to_list/2,
         m_value/2
        ]).


-include_lib("zotonic.hrl").
-include_lib("../include/mod_shop.hrl").

%% @doc Fetch the value for the key from a model source
%% @spec m_find_value(Key, Source, Context) -> term()
m_find_value(payment_providers, #m{value=undefined}, Context) ->
    [pp_as_proplist(P) || P <- z_notifier:foldl(get_payment_providers, [], Context)].


%% @doc Transform a m_config value to a list, used for template loops
%% @spec m_to_list(Source, Context) -> List
m_to_list(_, _Context) ->
    undefined.

%% @doc Transform a model value so that it can be formatted or piped through filters
%% @spec m_value(Source, Context) -> term()
m_value(_, _Context) ->
    undefined.



pp_as_proplist(Value = #payment_provider{}) ->
    lists:zip(record_info(fields, payment_provider), tl(tuple_to_list(Value))).
