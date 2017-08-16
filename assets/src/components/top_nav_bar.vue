<template>
  <nav class='navbar'>
    <section class='navbar-section'>
      <a href='#sidebar' class='btn btn-lg btn-link btn-action show-sm'>
        <i class='icon icon-menu'></i>
      </a>
      <a href='index.html' class='navbar-brand mr-10'>
        <strong>Noa Playground</strong>
      </a>
    </section>
    <section class='navbar-section'>
      <button class='btn btn-primary' v-on:click.stop.prevent='show_settings'>
        Settings
      </button>
    </section>
  </nav>
</template>

<script>
import AppEvents from '../lib/app_events.js'

export default {
  name: 'TopNavBar',
  methods: {
    show_settings: function() {
      AppEvents.bus.$emit('show_settings_view');
    }
  }
}
</script>
