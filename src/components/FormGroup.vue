<template>
	<div class="form-group">
		<div class="label">{{ label }}</div>
		<slot />
	</div>
</template>

<script>
	export default {
		props: {
			label: {
				type: String, 
				required: true,
			},
		},
	}
</script>