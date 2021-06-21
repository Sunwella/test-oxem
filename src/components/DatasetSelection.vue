<template>
	<div class="d-grid gap-2 mx-auto text-center">
		<h1>Выберите набор данных</h1>
		<div class="d-grid gap-2" v-for="dataset in datasets" :key="dataset.id">
			<Button type="button" class="btn btn-primary btn-lg" @click="$emit('dataset-select', dataset.rows)">
				{{ dataset.title }}
			</Button>
		</div>
	</div>
</template>

<script>
	import Button from './Button.vue'

	export default {
		components: {
			Button
		},
		data() {
			return {
				datasets: [
					{
						id: 1,
						title: 'Маленький объем данных',
						rows: 32,
					},
					{
						id: 2,
						title: 'Большой объем данных',
						rows: 1000,
					}
				]
			}
		}
	}
</script>