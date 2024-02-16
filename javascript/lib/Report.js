class Report {
	constructor(outputHandler) {
		this.outputHandler = outputHandler
	}

	generate(data) {
		return this.outputHandler.generateOutput(data)
	}
}

module.exports = Report
