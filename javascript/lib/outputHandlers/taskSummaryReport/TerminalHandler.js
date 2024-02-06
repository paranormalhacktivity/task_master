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
				return [
					["Total Tasks", this.data.length.toString()],
					["Completed Tasks", this.data.filter((task) => task.isComplete()).length.toString()],
					["Tasks in Progress", this.data.filter((task) => task.isInProgress()).length.toString()],
					["Tasks Not Started", this.data.filter((task) => task.isNotStarted()).length.toString()],
				]
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
		return ["Metric", "Count"]
	}
}

module.exports = TerminalHandler;

