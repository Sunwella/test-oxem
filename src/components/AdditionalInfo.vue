<template>
	<div class="card">
		<div class="card-body">
			<h4>Выбран пользователь: </h4>
			<p>{{ fullName }}</p>

			<h4>Описание: </h4>
			<p>{{ user.description }}</p>

			<h4>Адрес проживания: </h4>
			<p>{{ user.address.streetAddress }}</p>

			<h4>Город:</h4>
			<p>{{ user.address.city }}</p>

			<h4>Провинция/штат: </h4>
			<p>{{ user.address.state }}</p>
			
			<h4>Индекс: </h4>
			<p>{{ user.address.zip }}</p>

			<Button size="lg" block @click="$emit('close')">
				Закрыть
			</Button>
		</div>
	</div>
</template>

<script>
	import Button from './Button.vue'

	export default {
		props: {
			user: {
				type: Object,
				required: true,
			},
		},
		components: {
			Button
		},
		computed: {
			fullName() {
				return this.user.firstName + ' ' + this.user.lastName;
			},
		},
	};
</script>