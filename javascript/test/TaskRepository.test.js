const path = require('path');
const TaskRepository = require(path.join(__dirname, '../lib/TaskRepository'));

beforeEach(() => {
	mockAdapter = new TestAdapter();
	className = TaskRepository;
});

test("should delegate to the list function of the supplied adapter", () => {
	const expected = mockAdapter.list().map(element => {
		return element.name;
	});
	const actual = new className(mockAdapter).list().map(element => {
		return element.name;
	});
	expect(actual).toStrictEqual(expected);
});

test("should filter list of tasks by status", () => {
	const expected = ["Foo"];
	const actual = new className(mockAdapter).listByStatus({statuses: ["Completed"]}).map(element => {
		return element.name;
	});
	expect(actual).toStrictEqual(expected);
});

test("should filter list of tasks by assignee", () => {
	const expected = ["Baz"];
	const actual = new className(mockAdapter).listByAssignee({assignees: "John Smith"}).map(element => {
		return element.name;
	});
	expect(actual).toStrictEqual(expected);
});

test("should list tasks that are within the as upcoming", () => {
	const expected = ["Baz"];
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const actual = new className(mockAdapter).listUpcoming().map(element => {
		return element.name;
	});
	expect(actual).toStrictEqual(expected);
});

test("should list tasks are not within the week as upcoming", () => {
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const actual = new className(mockAdapter).listUpcoming().map(element => {
		return element.name;
	});
	expect(actual).not.toContain("Quux");
});

test("should list tasks as overdue if they happen in the past are incomplete", () => {
	const expected = ["Bar"];
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const actual = new className(mockAdapter).listOverdue().map(element => {
		return element.name;
	});
	expect(actual).toStrictEqual(expected);
});

test("should filter list of tasks by ones that have been completed", () => {
	const expected = ["Foo"];
	const actual = new className(mockAdapter).listComplete().map(element => {
		return element.name;
	});
	expect(actual).toStrictEqual(expected);
});


class TestAdapter {
	constructor() {}

	list() {
		return [
			{
				id: "1",
				name: "Foo",
				assignee: "Jim Bob",
				dueOn: "2023-11-11",
				status: "Completed"
			},
			{
				id: "2",
				name: "Bar",
				assignee: "Jim Bob",
				dueOn: "2023-11-11",
				status: "In Progress"
			},
			{
				id: "3",
				name: "Baz",
				assignee: "John Smith",
				dueOn: "2023-11-13",
				status: "Not Started"
			},
			{
				id: "4",
				name: "Quux",
				assignee: "Jane Doe",
				dueOn: "2023-11-23",
				status: "Not Started"
			}
		]
	}
}
