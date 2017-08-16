const state = {
  base_url: "",
  client_id: "",
  client_secret: "",
  scope: "",
  send_scope: false,
  authorize_req_state: "",
  authorize_resp_status: null,
  authorize_resp_data: null,
  token_resp_status: null,
  token_resp_data: null,
  introspect_resp_status: null,
  introspect_resp_data: null,
  test_req_url: "",
  test_req_method: "GET",
  test_req_headers: "",
  test_req_content_type: "application/json",
  test_req_content: "",
  test_req_result: ""
}

const getters = {
  base_url: state => state.base_url,
  client_id: state => state.client_id,
  client_secret: state => state.client_secret,
  scope: state => state.scope,
  send_scope: state => state.send_scope,
  authorize_req_state: state => state.authorize_req_state,
  authorize_resp_status: state => state.authorize_resp_status,
  authorize_resp_data: state => state.authorize_resp_data,
  token_resp_status: state => state.token_resp_status,
  token_resp_data: state => state.token_resp_data,
  introspect_resp_status: state => state.introspect_resp_status,
  introspect_resp_data: state => state.introspect_resp_data,
  test_req_url: state => state.test_req_url,
  test_req_method: state => state.test_req_method,
  test_req_headers: state => state.test_req_headers,
  test_req_content_type: state => state.test_req_content_type,
  test_req_content: state => state.test_req_content,
  test_req_result: state => state.test_req_result
}

const mutations = {
  import (state, data) {
    const whitelist_keys = Object.keys(state);
    for (var k of whitelist_keys) {
      if (data[k]) {
        state[k] = data[k];
      }
    }
  },
  save_profile (state, profile) {
    state.base_url = profile.base_url;
    state.client_id = profile.client_id;
    state.client_secret = profile.client_secret;
  },
  clear_profile (state) {
    state.base_url = "";
    state.client_id = "";
    state.client_secret = "";
  },
  set_scope(state, scope) {
    state.scope = scope;
  },
  clear_scope(state) {
    state.scope = "";
    state.send_scope = false;
  },
  set_send_scope(state, send) {
    state.send_scope = send;
  },
  set_authorization_state(state, req_state) {
    state.authorize_req_state = req_state;
  },
  set_authorization_result(state, {status, data}) {
    state.authorize_resp_status = status;
    state.authorize_resp_data   = data;
  },
  clear_authorization_result(state) {
    state.authorize_req_state = "";
    state.authorize_resp_status = null;
    state.authorize_resp_data   = null;
  },
  set_token_result(state, {status, data}) {
    state.token_resp_status = status;
    state.token_resp_data   = data;
  },
  clear_token_result(state) {
    state.token_resp_status = null;
    state.token_resp_data   = null;
  },
  set_introspect_result(state, {status, data}) {
    state.introspect_resp_status = status;
    state.introspect_resp_data   = data;
  },
  clear_introspect_result(state) {
    state.introspect_resp_status = null;
    state.introspect_resp_data   = null;
  },
  set_test_req(state, req_data) {
    var keys = Object.keys(req_data);
    for (var k of keys) {
      state[k] = req_data[k];
    }
  },
  clear_test_req(state) {
    state.test_req_url = "";
    state.test_req_method = "GET";
    state.test_req_headers = "";
    state.test_req_content_type = "application/json";
    state.test_req_content = "";
    state.test_req_result = "";
  }
}

export default {
  state,
  getters,
  mutations
}
