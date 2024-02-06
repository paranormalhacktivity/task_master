class Report {
	constructor(outputHandler) {
		this.outputHandler = outputHandler
	}

	generateReport(data) {
		return this.outputHandler.generateOutput(data)
	}
}

module.exports = Report
