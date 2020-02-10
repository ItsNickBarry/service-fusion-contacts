<template>
  <article class="media">
    <figure class="media-left">
      <p class="image is-128x128">
        <v-gravatar :email="contact.emails[0].body" :size="128" />
      </p>
      <strong>{{ contact.first_name }} {{ contact.last_name }}</strong>
      <br>
      <small>{{ contact.date_of_birth }}</small>
      <br>
      <b-button @click="$emit('edit', contactData)">
        Edit
      </b-button>
    </figure>

    <div class="media-content">
      <div class="columns">
        <div class="column">
          Addresses
          <br>
          <b-taglist>
            <b-tag v-if="contact.addresses.length == 0">
              None
            </b-tag>

            <b-tag
              v-for="(address, i) in contact.addresses"
              v-show="!address._destroy"
              :key="i"
              closable
              @close="removeAddress(i)"
            >
              {{ address.body }}
            </b-tag>
          </b-taglist>
        </div>

        <div class="column">
          Emails
          <br>
          <b-taglist>
            <b-tag
              v-for="(email, i) in contact.emails"
              v-show="!email._destroy"
              :key="i"
              :closable="contact.emails.length > 1"
              @close="removeEmail(i)"
            >
              {{ email.body }}
            </b-tag>
          </b-taglist>
        </div>

        <div class="column">
          Phone Numbers
          <br>
          <b-taglist>
            <b-tag
              v-for="(phoneNumber, i) in contact.phone_numbers"
              v-show="!phoneNumber._destroy"
              :key="i"
              :closable="contact.phone_numbers.length > 1"
              @close="removePhoneNumber(i)"
            >
              {{ phoneNumber.body }}
            </b-tag>
          </b-taglist>
        </div>
      </div>
    </div>
  </article>
</template>

<script>
export default {
  props: {
    contact: { type: Object, default: () => new Object() },
  },

  data: function () {
    return {
      errors: [],
    };
  },

  computed: {
    contactData: function () {
      return {
        id: this.contact.id || 0,
        first_name: this.contact.first_name || '',
        last_name: this.contact.last_name || '',
        date_of_birth: this.contact.date_of_birth ? new Date(this.contact.date_of_birth) : null,
        addresses: this.contact.addresses || [{ body: '' }],
        emails: this.contact.emails || [{ body: '' }],
        phone_numbers: this.contact.phone_numbers || [{ body: '' }],
      };
    },
  },

  methods: {
    removeAddress: function (i) {
      this.contactData.addresses[i]._destroy = true;
      this.save();
    },

    removeEmail: function (i) {
      this.contactData.emails[i]._destroy = true;
      this.save();
    },

    removePhoneNumber: function (i) {
      this.contactData.phone_numbers[i]._destroy = true;
      this.save();
    },

    save: function () {
      let data = Object.assign({}, this.contactData, {
        addresses_attributes: this.contactData.addresses,
        emails_attributes: this.contactData.emails,
        phone_numbers_attributes: this.contactData.phone_numbers,
      });

      global.$.ajax({
        type: 'PATCH',
        url: `/api/contacts/${ this.contact.id }`,
        data: { contact: data },
        success: function (res) {
          this.loading = false;
          this.$emit('update', res);
        }.bind(this),
        error: function (res) {
          this.loading = false;
          this.errors = res;
        }.bind(this),
      });
    },
  },
};
</script>
