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
				return [...new Set(this.data.map(item => item.assignee))].sort().map(assigneeName => [
					assigneeName,
					this.data.filter(item => item.assignee === assigneeName).length.toString()
				])
			}
		}
	}

	generateOutput(data) {
		return new this.AsciiTable(this.#headers(), new this.DataProcessor(data).process()).draw()
	}

	#headers() {
		return ["Assignee", "Count"]
	}
}

module.exports = TerminalHandler;

