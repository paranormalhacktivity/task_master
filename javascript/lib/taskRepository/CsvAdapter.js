const fs = require('fs');

class CsvAdapter {
	constructor(csvFilePath) {
		this.csvFilePath = csvFilePath;
	}

	list() {
		const data = fs.readFileSync(this.csvFilePath, 'utf8');
		const lines = data.split('\n').filter(Boolean);
		const results = lines.slice(1).map(line => this.#taskData(line.split(',')));
		return results;
	}

	#taskData(row) {
		return {
			id: row[0],
			name: row[1],
			assignee: row[2],
			dueOn: row[3],
			status: row[4]
		}
	}
}

module.exports = CsvAdapter;
