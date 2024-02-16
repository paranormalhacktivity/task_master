const TaskRepository = require("./TaskRepository");
const Report = require("./Report");

class ReportGenerator {
	constructor(repositoryAdapter, outputHandler) {
		this.repositoryAdapter = repositoryAdapter
		this.outputHandler = outputHandler
		this.repository = new TaskRepository(repositoryAdapter)
	}

	taskListReport({ sortBy, order }) {
		return this.#report().generate(this.repository.list({sortBy: sortBy || "Task ID", order: order || "desc"}))
	}

	overdueTasksReport({ sortBy, order }) {
		return this.#report().generate(this.repository.listOverdue({sortBy: sortBy || "Task ID", order: order || "desc"}))
	}

	tasksByStatusReport({ statuses, sortBy, order }) {
		return this.#report().generate(this.repository.listByStatus({statuses: statuses, sortBy: sortBy || "Task ID", order: order || "desc"}))
	}

	tasksByAssigneeReport({ assignees, sortBy, order }) {
		return this.#report().generate(this.repository.listByAssignee({assignees: assignees, sortBy: sortBy || "Task ID", order: order || "desc"}))
	}

	upcomingTasksReport({ sortBy, order }) {
		return this.#report().generate(this.repository.listUpcoming({sortBy: sortBy || "Task ID", order: order || "desc"}))
	}

	completedTasksReport({ sortBy, order }) {
		return this.#report().generate(this.repository.listComplete({sortBy: sortBy || "Task ID", order: order || "desc"}))
	}

	taskSummaryReport() {
		return this.#report().generate(this.repository.list())
	}

	taskDistributionReport() {
		return this.#report().generate(this.repository.list())
	}

	countdownReport({sortBy, order}) {
		return this.#report().generate(this.repository.list({sortBy: sortBy || "Task ID", order: order || "desc"}))
	}

	#report() {
		return new Report(this.outputHandler)
	}
}

module.exports = ReportGenerator
