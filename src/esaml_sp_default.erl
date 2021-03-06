%% esaml - SAML for erlang
%%
%% Copyright (c) 2013, Alex Wilson and the University of Queensland
%% All rights reserved.
%%
%% Distributed subject to the terms of the 2-clause BSD license, see
%% the LICENSE file in the root of the distribution.

-module(esaml_sp_default).
-behaviour(esaml_sp).

-include("esaml.hrl").

-export([init/2, handle_assertion/3, terminate/2]).

init(Req, _Args) -> {ok, Req, none}.

handle_assertion(Req, Assertion, State) ->
	Attrs = Assertion#esaml_assertion.attributes,
	Uid = proplists:get_value(uid, Attrs),
	Output = io_lib:format("<html><head><title>SAML SP demo</title></head><body><h1>Hi there!</h1><p>This is the <code>esaml_sp_default</code> demo SP callback module from eSAML.</p><table><tr><td>Your name:</td><td>\n~p\n</td></tr><tr><td>Your UID:</td><td>\n~p\n</td></tr></table><hr /><p>The assertion I got was:</p><pre>\n~p\n</pre></body></html>", [Assertion#esaml_assertion.subject#esaml_subject.name, Uid, Assertion]),
	{ok, Req2} = cowboy_req:reply(200, [{<<"Content-Type">>, <<"text/html">>}], Output, Req),
	{ok, Req2, State}.

terminate(_Req, _State) ->
	ok.
