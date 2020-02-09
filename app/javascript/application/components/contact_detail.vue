<template>
  <article class="media">
    <figure class="media-left">
      <p class="image is-128x128">
        <v-gravatar :email="contact.emails[0].body" :size="128" />
      </p>
      <strong>{{ contact.first_name }} {{ contact.last_name }}</strong>
      <br>
      <small>{{ contact.date_of_birth }}</small>
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
              @close="removeAddress(address, i)"
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
              @close="removeEmail(email, i)"
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
              @close="removePhoneNumber(phoneNumber, i)"
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

  methods: {
    removeAddress: function (address, i) {
      this.contact.addresses[i]._destroy = true;
      this.save();
    },

    removeEmail: function (email, i) {
      this.contact.emails[i]._destroy = true;
      this.save();
    },

    removePhoneNumber: function (phoneNumber, i) {
      this.contact.phone_numbers[i]._destroy = true;
      this.save();
    },

    save: function () {
      let data = { contact: {
        first_name: this.contact.first_name,
        last_name: this.contact.last_name,
        date_of_birth: this.contact.date_of_birth,
        addresses_attributes: this.contact.addresses.filter(el => !el.id || el._destroy),
        emails_attributes: this.contact.emails.filter(el => !el.id || el._destroy),
        phone_numbers_attributes: this.contact.phone_numbers.filter(el => !el.id || el._destroy),
      } };

      global.$.ajax({
        type: 'PATCH',
        url: `/api/contacts/${ this.contact.id }`,
        data,
        success: function (res) {
          this.loading = false;
          this.contact = res;
        }.bind(this),
        error: function (res) {
          this.loading = false;
          this.error = res;
        }.bind(this),
      });
    },
  },
};
</script>
