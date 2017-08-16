<template>
  <div v-if='visible' class='modal active'>
    <div class='modal-overlay'></div>
    <div class='modal-container' style='width: 80%;'>
      <form>
        <div class='modal-header'>
          <button
            class='btn btn-clear float-right'
            v-on:click.stop.prevent='hide_modal'
          >
          </button>
          <div class='modal-title'>Noa OAuth Playground Settings</div>
        </div>
        <div class='modal-body'>
          <div class='content'>
            <div class='form-group'>
              <label class='form-label' for='np_prov_url'>Noa Authorization Provider URL</label>
              <input type='url' id='np_prov_url'
                class='form-input'
                v-model='base_url'
                placeholder='https://my.noa/as/v1/provider-id'
              />
            </div>
            <div class='form-group'>
              <label class='form-label' for='np_client_id'>Oauth Client ID</label>
              <input type='text' id='np_client_id'
                class='form-input'
                v-model='client_id'
                placeholder='3eefb410-8479-486e-b105-ac3307541be1'
              />
            </div>
            <div class='form-group'>
              <label class='form-label' for='np_client_secret'>
                Client Secret
              </label>
              <input type='text' id='np_client_secret'
                class='form-input'
                v-model='client_secret'
              />
            </div>
          </div>
        </div>
        <div class='modal-footer'>
          <div class='form-group'>
            <button type='reset' class='btn btn-link' v-on:click.stop.prevent='hide_modal'>
              Cancel
            </button>
            <button class='btn btn-primary' v-on:click.stop.prevent='save_settings'>
              Submit
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import AppEvents from '../lib/app_events.js'
import Utils from '../lib/utils.js'

export default {
  name: 'Settings',
  methods: {
    show_modal: function() {
      this.base_url = this.$store.state.base_url;
      this.client_id = this.$store.state.client_id;
      this.client_secret = this.$store.state.client_secret;
      this.visible = true;
    },
    hide_modal: function() {
      this.visible = false;
    },
    save_settings: function() {
      var profile = {
        base_url: this.base_url,
        client_id: this.client_id,
        client_secret: this.client_secret
      }
      this.$store.commit('save_profile', profile);
      this.$store.commit('clear_scope');
      this.$store.commit('clear_authorization_result');
      this.$store.commit('clear_token_result');
      this.$store.commit('clear_introspect_result');
      this.hide_modal();
      Utils.save_state(this);
    }
  },
  created: function() {
    var me = this;
    me.$nextTick(function() {
      AppEvents.bus.$on('show_settings_view', me.show_modal);
    });
  },
  data() {
    return {
      visible: false,
      base_url: "",
      client_id: "",
      client_secret: ""
    }
  }
}
</script>
