<template>
  <div class='timeline-item'>
    <div class='timeline-left'>
      <a href='#' class='timeline-icon' :class='cl_icon_size'>
        <i v-if='status === "success"' class='icon icon-check'></i>
        <i v-else-if='status === "error"' class='icon icon-cross'></i>
      </a>
    </div>
    <div class='timeline-content'>
      <div class='tile'>
        <div class='tile-content'>
          <p><strong>{{title}}</strong></p>
          <slot>content from parent</slot>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'NpStep',
  props: ['title', 'status'],
  computed: {
    cl_icon_size: function() {
      return {'icon-lg': this.status !== 'none'};
    }
  }
}
</script>
