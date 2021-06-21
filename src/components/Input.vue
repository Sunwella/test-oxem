<template>
	<input 
		v-model="internalValue"
		class="form-control" 
		:class="{'is-invalid': error}"
		:placeholder="placeholder"
	/>
</template>

<script>
	export default {
		props: {
			value: [String, Number],
			error: {
				type: Boolean,
				default() {
					return false;
				}
			},
			placeholder: {
				type: [String, Number],
				default() {
					return '';
				},
			},
		},
		computed: {
			internalValue: {
				get() {
					return this.value;
				},
				set(val) {
					this.$emit('input', val);
				},
			}
		},
	}
</script>
