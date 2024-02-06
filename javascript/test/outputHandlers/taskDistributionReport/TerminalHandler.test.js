const path = require('path');
const TerminalHandler = require(path.join(__dirname, '../../../lib/outputHandlers/taskDistributionReport/TerminalHandler'));
const DataProcessor = new TerminalHandler().DataProcessor
const Task = require(path.join(__dirname, '../../../lib/Task'));

test("should call ascii table and draw with correct headers", () => {
	const testData = [{ id: 1 }, { id: 2 }]
	const expected = ["Assignee", "Count"]
	const instance = new TerminalHandler();

	instance.AsciiTable = TestAsciiTable
	instance.DataProcessor = TestDataProcessor
	expect(instance.generateOutput(testData).headers).toStrictEqual(expected)
});

test("should call ascii table and draw with correct row data that came from the data processor", () => {
	const testData = [{ id: 1 }, { id: 2 }]
	const expected = testData.map(element => { return element.id })
	const instance = new TerminalHandler();

	instance.AsciiTable = TestAsciiTable
	instance.DataProcessor = TestDataProcessor
	expect(instance.generateOutput(testData).rows).toStrictEqual(expected)
});

test("should return array with id, name, assignee, dueOn, and status", () => {
	const testData = [
		new Task(
			{ id: "1",
			name: "Foo",
			assignee: "Jim Bob",
			dueOn: "2023-11-08",
			status: "Completed" }
		),
		new Task(
			{ id: "2",
			name: "Bar",
			assignee: "Jim Bob",
			dueOn: "2023-11-09",
			status: "In Progress" }
		),
		new Task(
			{ id: "3",
			name: "Baz",
			assignee: "John Smith",
			dueOn: "2023-11-11",
			status: "In Progress" }
		)
	]
	const expected = [
		["Jim Bob", "2"],
		["John Smith", "1"]
	]
	expect(new DataProcessor(testData).process()).toStrictEqual(expected)
});


class TestAsciiTable {
	constructor(headers, rows) {
		this.headers = headers;
		this.rows = rows
	}

	draw() {
		return { headers: this.headers, rows: this.rows }
	}
}

class TestDataProcessor {
	constructor(data) {
		this.data = data
	}

	process() {
		return this.data.map(task => {
			return task.id
		})
	}
}
