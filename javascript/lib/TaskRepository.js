const Task = require("./Task");

class TaskRepository {
	constructor(adapter) {
		this.adapter = adapter;
	}

	list() {
		return this.adapter.list().map(taskData => {
			return new Task(taskData);
	  })
	}

	listByStatus({statuses, sortBy, order}) {
		console.log(statuses)
		console.log("here")
		return this.list().filter(task => {
			return task.hasStatusOf(statuses) == true;
		})
	}

	listByAssignee({ assignees, sortBy, order }) {
		return this.list().filter(task => {
			return task.isAssignedTo(assignees) == true;
		})
	}

	listUpcoming() {
		return this.list().filter(task => {
			return task.isUpcoming() == true;
		})
	}

	listOverdue() {
		return this.list().filter(task => {
			return task.isOverdue() == true;
		})
	}

	listComplete() {
		return this.list().filter(task => {
			return task.isComplete() == true;
		})
	}
}

module.exports = TaskRepository;
