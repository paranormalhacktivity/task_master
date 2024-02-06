class Task {
	constructor({id, name, assignee, dueOn, status}) {
		this.id = Number(id);
		this.name = String(name);
		this.assignee = String(assignee);
		this.dueOn = new Date(Date.parse(dueOn));
		this.status = String(status);
	}

	isIncomplete() {
		return !this.isComplete();
	}

	isComplete() {
		return this.hasStatusOf("Completed");
	}

	isInProgress() {
		return this.hasStatusOf("In Progress");
	}

	isNotStarted() {
		return this.hasStatusOf("Not Started");
	}

	hasStatusOf(statuses) {
		return [statuses].flat().includes(this.status);
	}

	isAssignedTo(assignees) {
		return [assignees].flat().includes(this.assignee);
	}

	isUpcoming() {
		const today = new Date()
		const nextWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 7)
		return this.#isDateBetween(this.dueOn, today, nextWeek)
	}

	isOverdue() {
		return this.dueOn < new Date() && this.isIncomplete();
	}

	numberOfDaysUntilDue() {
		return this.dueOn.getDate() - new Date().getDate()
	}

	#isDateBetween(targetDate, startDate, endDate) {
		return targetDate >= startDate && targetDate <= endDate;
	}
}

module.exports = Task
