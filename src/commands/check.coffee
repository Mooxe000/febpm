echo = console.log
{error} = console
_ = require 'lodash'
Thenjs = require 'thenjs'
{exit} = process
{status} = require '../libs/config'
check = require './checkHelper'

module.exports = ->

  Thenjs()

  # check step 0: Uninitialized
  .then (cont) ->
    check.initialize()
    .then (contA, result_arr) ->
      step = 'Uninitialized'

      check.error_handler step, result_arr
      .then (contB, check) ->
        contA null, true

    .then -> cont null, true

  # check step 1: Unsynchronized
  .then (cont, state) ->
    check.synchronize()
    .then (contA, result_arr) ->
      step = 'Unsynchronized'

      check.error_handler step, result_arr
      .then (contB, check) ->
        contA null, true

    .then -> cont null, true

  # check step 2: Uninstalled
  .then (cont, state) ->
    check.install()
    .then (contA, result_arr) ->
      step = 'Uninstalled'

      check.error_handler step, result_arr
      .then (contB, check) ->
        contA null, true

    .then -> cont null, true

  # FAIL ERROR
  .fail (cont, err) ->
    error err
