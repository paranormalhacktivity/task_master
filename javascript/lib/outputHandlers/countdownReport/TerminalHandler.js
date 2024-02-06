const path = require('path');
const AsciiTable = require(path.join(__dirname, '../../AsciiTable'));

class TerminalHandler {
	constructor() {
		this.AsciiTable = AsciiTable
		this.DataProcessor = class {
			constructor(data) {
				this.data = data
			}

			process() {
				return this.data.map(task => {
					return [
						String(task.id),
						task.name,
						task.assignee,
						this.#formatDateString(task.dueOn),
						task.status,
						this.#timeUntilDueString(task)
					]
				})
			}

			#timeUntilDueString(task) {
				if(Math.abs(task.numberOfDaysUntilDue()) == 1) {
					return task.isOverdue() ? "1 day overdue" : "1 day";
				} else if(task.isComplete()) {
					return "-";
				} else {
					const overdue = ""
					if(task.isOverdue) {
						const overdue = ' overdue'
					}
					return `${task.numberOfDaysUntilDue()} days${overdue}`;
				}
			}

			#formatDateString(date) {
				return String(date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + String(date.getDate()).padStart(2, '0'));
			}
		}
	}

	generateOutput(data) {
		return new this.AsciiTable(this.#headers(), new this.DataProcessor(data).process()).draw()
	}

	#headers() {
		return ["Task ID", "Task Name", "Assignee", "Due Date", "Status", "Time Remaining (Days)"]
	}
}

module.exports = TerminalHandler;
