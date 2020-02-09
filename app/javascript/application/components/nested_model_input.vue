<template>
  <div>
    <b-input
      v-model="model.body"
    />
    <b-input
      v-show="false"
      v-model="model.id"
    />
    <b-input
      v-show="false"
      v-model="model._destroy"
    />
  </div>
</template>

<script>
export default {
  props: {
    model: { type: Object, default: () => new Object() },
  },
};
</script>
