<template>
	<button 
		class="btn" 
		:class="classes" 
		:disabled="disabled"
		type="button" 
		@click="$emit('click')"
	>
		<slot /> 
	</button>
</template>

<script>
	export default {
		props: {
			disabled: {
				type: Boolean,
				default() {
					return false;
				},
			},
			link: {
				type: Boolean,
				default() {
					return false;
				},
			},
			variant: {
				type: String,
				validator(val) {
					return ['primary', 'success', 'danger', 'warning'].includes(val);
				},
				default() {
					return 'primary';
				},
			},
			size: {
				type: String,
				validator(val) {
					return ['sm', 'md', 'lg'].includes(val);
				},
				default() {
					return 'md';
				},
			},
			block: {
				type: Boolean,
				default() {
					return false;
				},
			},
			outline: {
				type: Boolean,
				default() {
					return false;
				},
			},
		},
		computed: {
			classes() {
				return {
					[`btn${this.outline ? '-outline' : ''}-${this.variant}`]: !this.link,
					[`btn-${this.size}`]: true,
					'btn-block': this.block,
					'btn-link': this.link,
				};
			},
		},
	};
</script>
