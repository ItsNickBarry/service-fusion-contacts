<template>
  <div>
    <p v-show="loading">
      TODO: LOADING
    </p>

    <div class="container">
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
    </div>

    <div v-show="!loading && errors.length == 0">
      <div class="container">
        <b-button @click="modalActive = true">
          New Contact
        </b-button>
      </div>

      <b-table
        v-show="!loading"
        :data="collection"
        :columns="columns"
        detailed
        :show-detail-icon="true"
      >
        <template slot="detail" slot-scope="props">
          <ContactDetail :contact="props.row" />
        </template>
      </b-table>
    </div>

    <b-modal :active.sync="modalActive">
      <div class="card">
        <div class="card-content">
          <div class="media">
            <ContactForm :collection="collection" />
          </div>
        </div>
      </div>
    </b-modal>
  </div>
</template>

<script>
import ContactForm from './contact_form.vue';
import ContactDetail from './contact_detail.vue';

export default {
  components: { ContactForm, ContactDetail },
  data: function () {
    return {
      loading: true,
      errors: [],

      modalActive: false,
      columns: [
        { field: 'first_name', label: 'First Name', sortable: true, searchable: true },
        { field: 'last_name', label: 'Last Name', sortable: true, searchable: true },
        { field: 'date_of_birth', label: 'Date of Birth', sortable: true },
      ],
      collection: [],
    };
  },

  mounted: function () {
    global.$.ajax({
      type: 'GET',
      url: '/api/contacts',
      success: function (res) {
        this.loading = false;
        this.collection = res;
      }.bind(this),
      error: function (res) {
        this.loading = false;
        this.errors = [res.statusText];
      }.bind(this),
    });
  },
};
</script>
