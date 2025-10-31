require('luasnip.session.snippet_collection').clear_snippets 'cpp'

local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node

local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt


ls.add_snippets('cpp', {
  s('ssle', fmt('NN_DETAIL_SSL_LOG_ERROR("{}", {});{}', { i(1), i(2), i(0) })),
  s('sslw', fmt('NN_DETAIL_SSL_LOG_WARN("{}", {});{}', { i(1), i(2), i(0) })),
  s('ssli', fmt('NN_DETAIL_SSL_LOG_INFO("{}", {});{}', { i(1), i(2), i(0) })),
  s('sslt', fmt('NN_DETAIL_SSL_LOG_TRACE("{}", {});{}', { i(1), i(2), i(0) })),
  s('sslnse', fmt('NN_DETAIL_SSL_LOG_ERROR_NOSYS("{}", {});{}', { i(1), i(2), i(0) })),
  s('sslnsw', fmt('NN_DETAIL_SSL_LOG_WARN_NOSYS("{}", {});{}', { i(1), i(2), i(0) })),
  s('sslnsi', fmt('NN_DETAIL_SSL_LOG_INFO_NOSYS("{}", {});{}', { i(1), i(2), i(0) })),
  s('sslnst', fmt('NN_DETAIL_SSL_LOG_TRACE_NOSYS("{}", {});{}', { i(1), i(2), i(0) })),
  s('sslst', fmt('NN_DETAIL_SSL_TRACED_STR({}){}', { i(1), i(0) })),
  s('sslsm', fmt('NN_DETAIL_SSL_MASKED_STR({}){}', { i(1), i(0) })),
  s('sslsu', fmt('NN_DETAIL_SSL_UNSAFE_STR({}){}', { i(1), i(0) })),
  s('sslerr', fmt('%04d-%04d{}', { i(0) })),
  -- TODO: make the ending ); a choice node
  s('ssleargs', fmt('{}.GetModule(), {}.GetDescription());{}', { i(1), rep(1), i(0) })),
})
