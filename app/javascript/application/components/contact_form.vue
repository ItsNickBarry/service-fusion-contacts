<template>
  <div class="contact-form">
    <b-message
      v-show="errors.length > 0"
      title="Error"
      type="is-warning"
      aria-close-label="Dismiss"
    >
      <div v-for="error in errors" :key="error">
        {{ error }}
      </div>
    </b-message>

    <form action="javascript:void(0)" @submit="save">
      <b-field label="First Name">
        <b-input v-model="first_name" name="contact[first_name]" />
      </b-field>

      <b-field label="Last Name">
        <b-input v-model="last_name" name="contact[last_name]" />
      </b-field>

      <b-field label="Date of Birth">
        <b-datepicker
          v-model="date_of_birth"
          placeholder="Click to select..."
        />
      </b-field>

      <b-field label="Addresses">
        <NestedModelInput
          v-for="i in addresses.length"
          :key="i"
          :model="addresses[i - 1]"
        />

        <b-button class="is-small" @click="addresses.push({})">
          Add Another
        </b-button>
      </b-field>

      <b-field label="Emails">
        <NestedModelInput
          v-for="i in emails.length"
          :key="i"
          :model="emails[i - 1]"
        />

        <b-button class="is-small" @click="emails.push({})">
          Add Another
        </b-button>
      </b-field>

      <b-field grouped label="Phone Numbers">
        <NestedModelInput
          v-for="i in phone_numbers.length"
          :key="i"
          :model="phone_numbers[i - 1]"
        />

        <b-button class="is-small" @click="phone_numbers.push({})">
          Add Another
        </b-button>
      </b-field>

      <b-button native-type="submit" :disabled="loading">
        Save
      </b-button>
    </form>
  </div>
</template>

<script>
import NestedModelInput from './nested_model_input.vue';

export default {
  components: { NestedModelInput },

  props: {
    collection: { type: Array, default: () => new Array() },
    contact: { type: Object, default: () => new Object() },
  },

  data: function () {
    return {
      loading: false,
      errors: [],

      id: 0,

      first_name: '',
      last_name: '',
      date_of_birth: null,

      addresses: [{ body: '' }],
      emails: [{ body: '' }],
      phone_numbers: [{ body: '' }],
    };
  },

  methods: {
    save: function () {
      this.loading = true;
      this.errors = [];

      let data = { contact: {
        first_name: this.first_name,
        last_name: this.last_name,
        date_of_birth: this.date_of_birth,
        addresses_attributes: this.addresses,
        emails_attributes: this.emails,
        phone_numbers_attributes: this.phone_numbers,
      } };

      global.$.ajax({
        type: this.id ? 'PATCH' : 'POST',
        url: `/api/contacts/${ this.id || '' }`,
        data,
        success: function (res) {
          this.loading = false;
          // TODO: update if id is set
          this.collection.push(res);
          this.$parent.close();
        }.bind(this),
        error: function (res) {
          this.loading = false;
          this.error = res.responseJSON;
        }.bind(this),
      });
    },
  },
};
</script>
