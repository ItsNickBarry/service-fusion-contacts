<template>
  <div id="app">
    <p v-show="loading">
      TODO: LOADING
    </p>
    <b-table
      v-show="!loading"
      :data="collection"
      :columns="columns"
      detailed
    >
      <template slot="detail" slot-scope="props">
        <article class="media">
          <figure class="media-left">
            <p class="image is-64x64">
              <v-gravatar :email="props.row.emails[0].body" :size="64" />
            </p>
          </figure>
          <div class="media-content">
            <strong>{{ props.row.first_name }} {{ props.row.last_name }}</strong>
            <small v-for="address in props.row.addresses" :key="address.id">{{ address.body }}</small>
            <br>
            <small v-for="email in props.row.emails" :key="email.id">{{ email.body }}</small>
            <br>
            <small v-for="phone_number in props.row.phone_numbers" :key="phone_number.id">{{ phone_number.body }}</small>
          </div>
        </article>
      </template>
    </b-table>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      loading: true,
      error: null,
      columns: [
        { field: 'first_name', label: 'First Name', sortable: true },
        { field: 'last_name', label: 'Last Name', sortable: true },
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
        this.error = res;
      }.bind(this),
    });
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
