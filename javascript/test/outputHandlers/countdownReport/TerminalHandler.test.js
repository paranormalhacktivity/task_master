const path = require('path');
const TerminalHandler = require(path.join(__dirname, '../../../lib/outputHandlers/countdownReport/TerminalHandler'));
const DataProcessor = new TerminalHandler().DataProcessor
const Task = require(path.join(__dirname, '../../../lib/Task'));

test("should call ascii table and draw with correct headers", () => {
	const testData = [{ id: 1 }, { id: 2 }]
	const expected = ["Task ID", "Task Name", "Assignee", "Due Date", "Status", "Time Remaining (Days)"]
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
			assignee: "Jim Bob",
			dueOn: "2023-11-11",
			status: "In Progress" }
		),
		new Task(
			{ id: "4",
			name: "Quux",
			assignee: "Jim Bob",
			dueOn: "2023-11-12",
			status: "In Progress" }
		)
	]
	const expected = [
		["1", "Foo", "Jim Bob", "2023-11-08", "Completed", "-"],
		["2", "Bar", "Jim Bob", "2023-11-09", "In Progress", "1 day overdue"],
		["3", "Baz", "Jim Bob", "2023-11-11", "In Progress", "1 day"],
		["4", "Quux", "Jim Bob", "2023-11-12", "In Progress", "2 days"],
	]
	jest.useFakeTimers().setSystemTime(new Date('2023-11-10T00:00:00Z'));
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
