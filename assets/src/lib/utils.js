import QS from 'query-string'
import Debug from './debug.js'

const save_state = function(vm) {
  const keys = Object.keys(vm.$store.state);
  for (var k of keys) {
    var v = JSON.stringify(vm.$store.state[k])
    sessionStorage.setItem(k, v);
  }
}

const restore_state = function(vm) {
  const keys = Object.keys(vm.$store.state);
  var data = {};
  for (var k of keys) {
    const v = sessionStorage.getItem(k);
    if (v) {
      data[k] = JSON.parse(v);
    }
  }

  vm.$store.commit('import', data);
}

const playground_origin = function() {
  return window.location.origin;
}

const playground_url = function() {
  return `${window.location.origin}${window.location.pathname}`;
}

const compose_authorization_url = function(base_url, client_id, redirect_uri, state, scope) {
  const uri = `${base_url}/authorize`
  var   params = {
    response_type: 'code',
    client_id: client_id,
    redirect_uri: redirect_uri,
    state: state
  }

  if (scope) {
    params['scope'] = scope;
  }

  var qs =
    Object.keys(params)
    .map(k => `${encodeURIComponent(k)}=${encodeURIComponent(params[k])}`)
    .join('&');
  return `${uri}?${qs}`;
}

const get_hash_frags = function(hash) {
  return QS.parse(hash.replace('#', '?'));
}

const get_qs_params = function(search) {
  return QS.parse(search);
}

const process_authorization_response = function(vm, resp_data) {
  Debug.log(resp_data, 'Authorize Request Callback Data');
  if (resp_data['state'] == vm.$store.state.authorize_req_state) {
    if (resp_data['code']) {
      vm.$store.commit('set_authorization_result', {
        status: "OK",
        data: resp_data
      });
      vm.$store.commit('clear_token_result');
      vm.$store.commit('clear_introspect_result');
    }
    else if (resp_data['access_token']) {
      vm.$store.commit('set_token_result', {
        status: "OK",
        data: resp_data
      });
      vm.$store.commit('clear_introspect_result');
    }
    else if (resp_data['error']) {
      vm.$store.commit('set_authorization_result', {
        status: "ERROR",
        data: resp_data
      });
      vm.$store.commit('clear_token_result');
      vm.$store.commit('clear_introspect_result');
    }
    return true;
  }
  else {
    return false;
  }
}

export default {
  save_state,
  restore_state,
  playground_origin,
  playground_url,
  compose_authorization_url,
  get_hash_frags,
  get_qs_params,
  process_authorization_response
}
