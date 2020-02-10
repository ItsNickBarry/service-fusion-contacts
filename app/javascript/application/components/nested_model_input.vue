<template>
  <b-field
    v-show="!destroy && !model._destroy"
  >
    <b-input
      v-model="model.body"
      :value="value"
      :name="`contact[${ name }][${ index }][body]`"
    />

    <b-input
      v-show="false"
      :value="model.id"
      :name="`contact[${ name }][${ index }][id]`"
    />

    <b-input
      v-show="false"
      :value="destroy || model._destroy"
      :name="`contact[${ name }][${ index }][_destroy]`"
    />

    <b-button @click="destroy = true">
      x
    </b-button>
  </b-field>
</template>

<script>
export default {
  props: {
    index: { type: Number, default: 0 },
    name: { type: String, default: '' },
    value: { type: String, default: '' },
    model: { type: Object, default: () => new Object() },
  },

  data: function () {
    return {
      destroy: false,
    };
  },
};
</script>
