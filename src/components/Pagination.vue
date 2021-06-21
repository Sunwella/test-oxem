<template>
	<nav>
		<ul class="pagination justify-content-center">
			<li class="page-item page-link">
				<Button :disabled="disabledPrevButton" size="sm" link @click="currentPage = 1">
					Начало
				</Button>
			</li>
			<li class="page-item page-link">
				<Button :disabled="disabledPrevButton" size="sm" link @click="currentPage -= 1">
					Сюда
				</Button>
			</li>
			<li v-for="page in pagination" :key="page" class="page-item page-link">
				<Button :disabled="page === currentPage" size="sm" link @click="changePage(page)">
					{{ page }}
				</Button>
			</li>
			<li class="page-item page-link">
				<Button :disabled="disabledNextButton" size="sm" link @click="currentPage += 1">
					Туда
				</Button>
			</li>
			<li class="page-item page-link">
				<Button :disabled="disabledNextButton" size="sm" link @click="currentPage = pagesCount">
					Конец
				</Button>
			</li>
		</ul>
	</nav>
</template>

<script>
	import Button from './Button.vue'

	export default {
		props: {
			data: {
				type: Array,
				default() {
					return [];
				},
			},
		},
		components: {
			Button,
		},
		data() {
			return {
				elementsPerPage: 50,
				currentPage: 1,
				shownSideButtonsCount: 5,
			}
		},
		methods: {
			changePage(page) {
				this.currentPage = page;
			}
		},
		computed: {
			pagesCount() {
				const from = (this.currentPage - 1) * this.elementsPerPage;
				const to = from + this.elementsPerPage;

				this.$emit('change-page', from, to);

				return Math.ceil(this.data.length / this.elementsPerPage);
			},
			pages() {
				const arr = [];

				for (let i = 1; i <= this.pagesCount; i++) {
					arr.push(i);
				}

				return arr;
			},
			pagination() {
				const pagination = [];
				const negativeNumberDifference = this.currentPage - this.shownSideButtonsCount <= 1;
				const sumPaginationElem = this.currentPage + this.shownSideButtonsCount;
				const maxPaginationElemOnPage = this.shownSideButtonsCount * 2 + 1;

				if (this.pagesCount < maxPaginationElemOnPage) {
					return this.pages;
				}

				if (negativeNumberDifference && sumPaginationElem <= maxPaginationElemOnPage) {
					for (let i = 0; i <= this.shownSideButtonsCount * 2; i++) {
						pagination.push(this.pages[i]);
					}
				} else if (!negativeNumberDifference && sumPaginationElem <= this.pagesCount) {
					for (let i = this.currentPage - this.shownSideButtonsCount - 1; i < this.currentPage + this.shownSideButtonsCount; i++) {
						pagination.push(this.pages[i]);
					}
				} else if (sumPaginationElem > this.pagesCount) {
					for (let i = this.pagesCount - this.shownSideButtonsCount * 2 - 1; i < this.pagesCount; i++) {
						pagination.push(this.pages[i]);
					}
				} 

				return pagination;
			},
			disabledPrevButton() {
				return this.currentPage == 1;
			},
			disabledNextButton() {
				return this.currentPage == this.pagesCount;
			}
		}
	}
</script>