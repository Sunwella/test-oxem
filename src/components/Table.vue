<template>
	<div>
		<table class="table">
			<thead>
				<tr>
					<th v-for="colName in columns" 
						:key="colName" 
						:class="{
							asc: isSortAsc && sortedColName === colName,
							desc: !isSortAsc && sortedColName === colName,
						}"
						@click="sort(colName)"
					>
						{{ colName }}
					</th>
				</tr>
			</thead>
			<tbody>
				<template v-for="datum in pageData">
					<tr :key="`${datum[keyField]}_row`">
						<td v-for="colName in columns" :key="colName" @click="toggleAdditionalInfo(datum[keyField])">
							{{ datum[colName] }}
						</td>
					</tr>

					<tr v-if="selectedRow === datum[keyField]" :key="`${datum[keyField]}_details`">
						<td :colspan="columns.length">
							<slot name="additional-info" :datum="datum" :on-close="closeAdditionalInfo" />
						</td>
					</tr>
				</template>
			</tbody>
		</table>
		
		<Pagination :data="sortDataTable" @change-page="paginationPageElements" />
	</div>
</template>

<script>
	import Pagination from './Pagination.vue'

	export default {
		props: {
			data: {
				type: Array,
				default() {
					return [];
				},
			},
			columns: {
				type: Array,
				default() {
					return [];
				},
			},
			keyField: {
				type: String,
				required: true,
			},
		},
		components: {
			Pagination,
		},
		data() {
			return {
				isSortAsc: false,
				sortedColName: null,
				paginationFrom: null,
				paginationTo: null,
				selectedRow: null,
			}
		},
		methods: {
			sort(colName) {
				this.isSortAsc = this.sortedColName === colName ? !this.isSortAsc : true;
				this.sortedColName = colName;
			},
			paginationPageElements(from, to) {
				this.paginationTo = to;
				this.paginationFrom = from;
			},
			toggleAdditionalInfo(rowKey) {
				this.selectedRow = this.selectedRow === rowKey ? null : rowKey;
			},
			closeAdditionalInfo() {
				this.selectedRow = null;
			},
			getTotalDataIdxByPageIdx(pageIdx) {
				return this.paginationFrom + pageIdx;
			},
		},
		computed: {
			sortDataTable() {
				const data = [...this.data];

				if (this.sortedColName === null) {
					return data;
				}

				return data.sort((a, b) => {
					if (this.isSortAsc) {
						return a[this.sortedColName] > b[this.sortedColName] ? 1 : -1;
					} else {
						return a[this.sortedColName] > b[this.sortedColName] ? -1 : 1;
					}
				});
			},
			pageData() {
				return this.sortDataTable.slice(this.paginationFrom, this.paginationTo);
			}
		}
	}
</script>

<style scoped>
	.asc::before {
		content: "▲";
	}
	
	.desc::before {
		content: "▼"
	}
</style>