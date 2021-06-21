<template>
    <div class="card gx-10">
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-2">
                    <FormGroup label="ID">
                        <Input v-model.number="user.id" :error="hasError('id')" />
                    </FormGroup>
                </div>
                <div class="col-5">
                    <FormGroup label="firstName">
                        <Input v-model="user.firstName" :error="hasError('firstName')" />
                    </FormGroup>
                </div>
                <div class="col-5">
                    <FormGroup label="lastName">
                        <Input v-model="user.lastName" :error="hasError('lastName')" />
                    </FormGroup>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-6">
                    <FormGroup label="email">
                        <Input v-model="user.email" :error="hasError('email')" placeholder="user@example.com" />
                    </FormGroup>
                </div>
                <div class="col-6">
                    <FormGroup label="phone">
                        <Input v-model="user.phone" :error="hasError('phone')" placeholder="(123)456-7890" />
                    </FormGroup>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-3">
                    <FormGroup label="zip">
                        <Input v-model.number="user.address.zip" :error="hasError('zip')" />
                    </FormGroup>
                </div>
                <div class="col-3">
                    <FormGroup label="state">
                        <Input v-model="user.address.state" :error="hasError('state')" />
                    </FormGroup>
                </div>
                <div class="col-3">
                    <FormGroup label="city">
                        <Input v-model="user.address.city" :error="hasError('city')" />
                    </FormGroup>
                </div>
                <div class="col-3">
                    <FormGroup label="streetAddress">
                        <Input v-model="user.address.streetAddress" :error="hasError('streetAddress')" />
                    </FormGroup>
                </div>
            </div>
            
            <div class="row mb-3">
                <div class="col-12">
                    <FormGroup label="description">
                        <Input v-model="user.description" :error="hasError('description')" />
                    </FormGroup>
                </div>
            </div>
        </div>

        <div class="card-footer">
            <Button @click="saveDatum">
                Добавить в таблицу
            </Button>
        </div>  
    </div>
</template>

<script>
    import FormGroup from './FormGroup.vue'
    import Input from './Input.vue'
    import Button from './Button.vue'

    export default {
        components: {
            FormGroup,
            Input,
            Button
        },
        data() {
            return {
                user: {
                  id: '',
                  firstName: '',
                  lastName: '',
                  email: '',
                  phone: '',
                  address: {
                    streetAddress: '',
                    city: '',
                    state: '',
                    zip: '',
                  },
                  description: '',
                },
                errors: [],
            }
        },
        methods: {
            hasError(field) {
                return this.errors.includes(field);
            },
            saveDatum() {
                this.errors = [];

                if (typeof this.user.id !== 'number') {
                    this.errors.push('id');
                } 
                if (this.user.firstName === '') {
                    this.errors.push('firstName');
                } 
                if (this.user.lastName === '') {
                    this.errors.push('lastName');
                }
                if (!/^\w+@\w+\.\w+$/i.test(this.user.email)) {
                    this.errors.push('email');
                }
                if (!/^\(\d{3}\)\d{3}-\d{4}$/i.test(this.user.phone)) {
                    this.errors.push('phone');
                }
                if (this.user.address.streetAddress === '') {
                    this.errors.push('streetAddress');
                }
                if (this.user.address.city === '') {
                    this.errors.push('city');
                }
                if (this.user.address.state === '') {
                    this.errors.push('state');
                }
                if (typeof this.user.address.zip !== 'number') {
                    this.errors.push('zip');
                }
                if (this.user.description === '') {
                    this.errors.push('description');
                } 

                if (this.errors.length === 0) {
                    this.$emit('save', this.user);
                }
            }
        },
    }
</script>