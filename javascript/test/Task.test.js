const path = require('path');
const Task = require(path.join(__dirname, '../lib/Task'));

beforeEach(() => {
	className = Task;
});

test("should return id of task", () => {
	const expected = 1;
	const actual = new className(
		{ id: String(expected),
		name: "Chore",
		assignee: "John Smith",
		dueOn: "2023-10-31",
		status: "In Progress" }
	).id
	expect(actual).toStrictEqual(expected);
});

test("should return name of task", () => {
	const expected = "Chore";
	const actual = new className(
		{ id: "1",
		name: expected,
		assignee: "John Smith",
		dueOn: "2023-10-31",
		status: "In Progress" }
	).name
	expect(actual).toStrictEqual(expected);
});

test("should return assignee of task", () => {
	const expected = "John Smith";
	const actual = new className(
		{ id: "1",
		name: "Chore",
		assignee: expected,
		dueOn: "2023-10-31",
		status: "In Progress" }
	).assignee
	expect(actual).toStrictEqual(expected);
});

test("should return due on of task", () => {
	const expected = new Date(Date.parse("2023-10-31"));
	const actual = new className(
		{ id: "1",
		name: "Chore",
		assignee: "John Smith",
		dueOn: "2023-10-31",
		status: "In Progress" }
	).dueOn
	expect(actual).toStrictEqual(expected);
});

test("should return status of task", () => {
	const expected = "In Progress";
	const actual = new className(
		{ id: "1",
		name: "Chore",
		assignee: "John Smith",
		dueOn: "2023-10-31",
		status: expected }
	).status
	expect(actual).toStrictEqual(expected);

});

test("should return true if the task has a status that matches a list of given statuses", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "Completed" }
		).hasStatusOf(["Completed"])
	).toBeTruthy()
});

test("should return false if the task has a status that matches a list of given statuses", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "Completed" }
		).hasStatusOf(["In Progress"])
	).toBeFalsy()

});

test("should return true if the task has a assignee that matches a list of given assignees", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "Completed" }
		).isAssignedTo(["John Smith"])
	).toBeTruthy()
});

test("should return false if the task has a assignee that matches a list of given assignees", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "Completed" }
		).isAssignedTo(["Jane Doe"])
	).toBeFalsy()
});

test("should return true if the task is complete", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "Completed" }
		).isComplete()
	).toBeTruthy()
});

test("should return false if the task is incomplete", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "In Progress" }
		).isComplete()
	).toBeFalsy()
});

test("should return true if the task is in progress", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "In Progress" }
		).isInProgress()
	).toBeTruthy()
});

test("should return false if the task is not in progress", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "Not Started" }
		).isInProgress()
	).toBeFalsy()
});

test("should return true if the task is not started", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "Not Started" }
		).isNotStarted()
	).toBeTruthy()
});

test("should return false if the task has been started", () => {
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: "2023-10-31",
			status: "Completed" }
		).isNotStarted()
	).toBeFalsy()
});

test("should return true if the task has a due date within the upcoming week", () => {
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const today = new Date();
	const inNextSevenDays = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 7)
	const inNextSevenDaysAsString = String(
		inNextSevenDays.getFullYear() + '-' + (inNextSevenDays.getMonth() + 1) + '-' + inNextSevenDays.getDate()
	);
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: inNextSevenDaysAsString,
			status: "Not Started" }
		).isUpcoming()
	).toBeTruthy()
});

test("should return false if the task has a due date not within the upcoming week", () => {
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const today = new Date();
  const inNextEightDays = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 8);
	const inNextEightDaysAsString = String(
		inNextEightDays.getFullYear() + '-' + (inNextEightDays.getMonth() + 1) + '-' + inNextEightDays.getDate()
	);
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: inNextEightDaysAsString,
			status: "Completed" }
		).isUpcoming()
	).toBeFalsy()
});

test("should return true if the task has a due date that is past due", () => {
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const today = new Date();
  const yesterday = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 1);
	const yesterdayAsString = String(
		yesterday.getFullYear() + '-' + (yesterday.getMonth() + 1) + '-' + yesterday.getDate()
	);
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: yesterdayAsString,
			status: "In Progress" }
		).isOverdue()
	).toBeTruthy()
});

test("should return false if the task has a due date that is not past due", () => {
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const today = new Date();
  const tomorrow = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
	const tomorrowAsString = String(
		tomorrow.getFullYear() + '-' + (tomorrow.getMonth() + 1) + '-' + tomorrow.getDate()
	);
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: tomorrowAsString,
			status: "In Progress" }
		).isOverdue()
	).toBeFalsy()
});

test("should return the number of days until due date as integer", () => {
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const expected = 7;
	const today = new Date();
  const nextWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() + expected);
	const nextWeekAsString = String(
		nextWeek.getFullYear() + '-' + (nextWeek.getMonth() + 1) + '-' + nextWeek.getDate()
	);
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: nextWeekAsString,
			status: "Completed" }
		).numberOfDaysUntilDue()
	).toStrictEqual(expected)
});

test("should return the number of days until due date as positive if due on in future", () => {
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const today = new Date();
  const nextWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 7);
	const nextWeekAsString = String(
		nextWeek.getFullYear() + '-' + (nextWeek.getMonth() + 1) + '-' + nextWeek.getDate()
	);
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: nextWeekAsString,
			status: "Completed" }
		).numberOfDaysUntilDue()
	).toBeGreaterThan(0)
});

test("should return the number of days until due date as negative if due on in past", () => {
	jest.useFakeTimers().setSystemTime(new Date('2023-11-12T00:00:00Z'));
	const today = new Date();
  const lastWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 7);
	const lastWeekAsString = String(
		lastWeek.getFullYear() + '-' + (lastWeek.getMonth() + 1) + '-' + lastWeek.getDate()
	);
	expect(
		new className(
			{ id: "1",
			name: "Chore",
			assignee: "John Smith",
			dueOn: lastWeekAsString,
			status: "Completed" }
		).numberOfDaysUntilDue()
	).toBeLessThan(0)
});
