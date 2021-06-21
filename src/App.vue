<template>
  <div id="app" class="container">
    <DatasetSelection v-if="!isDatasetSelected" @dataset-select="datasetLoad" />

    <template v-else>
      <Spinner v-if="isSpinnerShown" />

      <template v-else>
        <div class="d-flex mt-30">
          <div class="mr-auto p-2 flex-grow-1">
            <Button class="mr-2" @click="isUserFormShown = !isUserFormShown">
              Добавить
            </Button>
          </div>

          <div class="p-2">
            <Input 
              v-model="temporarySearchQuery"
              class="form-control mr-2" 
              type="search" 
              placeholder="Поиск..."
            />
          </div>

          <div class="p-2">
            <Button variant="success" outline @click="find">
              Найти
            </Button>
          </div>
        </div>

        <UserForm v-if="isUserFormShown" @save="saveUser" />

        <Table :data="filteredData" :columns="columns" key-field="id">
          <template #additional-info="{ datum, onClose }">
            <AdditionalInfo :user="datum" @close="onClose" />
          </template>
        </Table>
      </template>
    </template>
  </div>
</template>

<script>
  import Button from './components/Button.vue'
  import Input from './components/Input.vue'
  import DatasetSelection from './components/DatasetSelection.vue'
  import Spinner from './components/Spinner.vue'
  import Table from './components/Table.vue'
  import AdditionalInfo from './components/AdditionalInfo.vue'
  import UserForm from './components/UserForm.vue'
  import {loadData} from './data.js'

  export default {
    components: {
      Button,
      Input,
      DatasetSelection,
      Spinner,
      Table,
      AdditionalInfo,
      UserForm
    },
    data() {
      return {
        users: [],
        isSpinnerShown: false,
        isDatasetSelected: false,
        isUserFormShown: false,
        temporarySearchQuery: '',
        searchQuery: '',
        columns: ['id', 'firstName', 'lastName', 'email', 'phone'],
      }
    },
    methods: {
      async datasetLoad(rows) {
        this.isDatasetSelected = true;
        this.isSpinnerShown = true;
        this.users = await loadData(`http://www.filltext.com/?rows=${rows}&id={index}&firstName={firstName}&lastName={lastName}&email={email}&phone={phone|(xxx)xxx-xx-xx}&address={addressObject}&description={lorem|32}`);
        this.isSpinnerShown = false;
      },
      find() {
        this.searchQuery = this.temporarySearchQuery;
      },
      saveUser(user) {
        this.users.unshift(user);
        this.isUserFormShown = false;
      },
    },
    computed: {
      filteredData() {
        return [...this.users].filter(item => 
          this.columns.some(col => 
            String(item[col]).toUpperCase().includes(this.searchQuery.toUpperCase())
          )
        );
      },
    }
  }
</script>

