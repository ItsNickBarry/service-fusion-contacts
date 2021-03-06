<template>
  <div class="contact-form">
    <form action="javascript:void(0)" @submit="save">
      <div class="columns">
        <div class="column">
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

          <b-field label="First Name">
            <b-input v-model="first_name" name="contact[first_name]" required />
          </b-field>

          <b-field label="Last Name">
            <b-input v-model="last_name" name="contact[last_name]" required />
          </b-field>
        </div>

        <div class="column">
          <b-field label="Date of Birth">
            <b-datepicker
              v-model="date_of_birth"
              placeholder="Click to select..."
              name="contact[date_of_birth]"
              required
              inline
            />
          </b-field>
        </div>
      </div>

      <div class="columns">
        <div class="column">
          <strong><b-icon icon="home" />Addresses</strong>

          <NestedModelInput
            v-for="(model, i) in addresses"
            :key="i"
            :index="i"
            name="addresses_attributes"
            :model="model"
          />

          <br>

          <b-button icon-left="plus-circle" @click="addresses.push({})">
            Add Another
          </b-button>
        </div>

        <div class="column">
          <strong><b-icon icon="email" />Emails</strong>

          <NestedModelInput
            v-for="(model, i) in emails"
            :key="i"
            :index="i"
            name="emails_attributes"
            :model="model"
          />

          <br>

          <b-button icon-left="plus-circle" @click="emails.push({})">
            Add Another
          </b-button>
        </div>

        <div class="column">
          <strong><b-icon icon="phone" />Phone Numbers</strong>

          <NestedModelInput
            v-for="(model, i) in phone_numbers"
            :key="i"
            :index="i"
            name="phone_numbers_attributes"
            :model="model"
          />

          <br>

          <b-button icon-left="plus-circle" @click="phone_numbers.push({})">
            Add Another
          </b-button>
        </div>
      </div>
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
    contact: { type: Object, default: () => new Object() },
  },

  data: function () {
    return {
      loading: false,
      errors: [],

      id: this.contact.id || 0,

      first_name: this.contact.first_name || '',
      last_name: this.contact.last_name || '',
      date_of_birth: this.contact.date_of_birth || null,

      addresses: this.contact.addresses || [{ body: '' }],
      emails: this.contact.emails || [{ body: '' }],
      phone_numbers: this.contact.phone_numbers || [{ body: '' }],
    };
  },

  methods: {
    save: function () {
      this.loading = true;
      this.errors = [];

      let data = global.$(event.target).closest('form').serializeJSON();

      // serializeJSON does not work with inline datepicker
      data.contact.date_of_birth = this.date_of_birth;

      ['addresses_attributes', 'emails_attributes', 'phone_numbers_attributes'].forEach(function (name) {
        let collection = data.contact[name];

        for (let i in collection) {
          let model = collection[i];

          if (model.body.length === 0) {
            if (model.id) {
              model._destroy = true;
            } else {
              delete collection[i];
            }
          }
        }
      });

      global.$.ajax({
        type: this.id ? 'PATCH' : 'POST',
        url: `/api/contacts/${ this.id || '' }`,
        data,
        success: function (res) {
          this.loading = false;
          this.$emit(this.id ? 'update' : 'create', res);
          // Buefy documentation indicates use of this.$parent
          this.$parent.close();
        }.bind(this),
        error: function (res) {
          this.loading = false;
          this.errors = res.responseJSON || [res.statusText];
        }.bind(this),
      });
    },
  },
};
</script>
