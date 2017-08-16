<template>
  <np-step title='Provide Authorization Scope' status='none'>
    <div class='form-group'>
      <label class='form-label' for='np_scope'>
        Enter a space separated list of permissions
      </label>
      <input type='text' id='np_scope'
        class='form-input'
        v-model='scope'
        v-on:keyup='update_send_status_on_scope_change'
        placeholder='permission1 permission2 permission3'
      />
    </div>
    <div class='form-group'>
      <label class='form-checkbox'>
        <input type='checkbox'
          v-bind:checked='do_not_send_scope'
          v-on:change='do_not_send_scope_changed'
        />
        <i class='form-icon'></i>
        Do not send scope
      </label>
    </div>
  </np-step>
</template>

<script>
import NpStep       from './np_step'

export default {
  name: 'SetupScope',
  components: {
    'np-step': NpStep
  },
  computed: {
    scope: {
      get() {
        return this.$store.state.scope;
      },
      set(value) {
        this.$store.commit('set_scope', value);
      }
    },
    do_not_send_scope: function() {
      return !this.$store.state.send_scope;
    }
  },
  methods: {
    do_not_send_scope_changed: function(ev) {
      this.$store.commit('set_send_scope', !ev.target.checked);
    },
    update_send_status_on_scope_change: function() {
      var scope = this.$store.state.scope;
      var current_send_scope = this.$store.state.send_scope;
      var send_scope = scope === '' ? false : true;
      if (current_send_scope != send_scope) {
        this.$store.commit('set_send_scope', send_scope);
      }
    }
  }
}
</script>
