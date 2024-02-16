const path = require('path');
const ReportGenerator = require(path.join(__dirname, '../lib/ReportGenerator'));

beforeEach(() => {
	className = ReportGenerator;
	mockHandler = new TestHandler()
	mockRepository = new TestRepository()
});

test("list report", () => {
	const generator = new className(
		"Should be a repo adapter, but doesn't matter because we're stubbing repo",
		mockHandler
	)
	generator.repository = mockRepository
	expect(generator.taskListReport({})).toStrictEqual(mockRepository.list())
})

test("tasks by status report", () => {
	const generator = new className(
		"Should be a repo adapter, but doesn't matter because we're stubbing repo",
		mockHandler
	)
	generator.repository = mockRepository
	expect(generator.tasksByStatusReport({statuses: ["Test"]})).toStrictEqual(mockRepository.listByStatus({statuses: ["Test"]}))
})

test("tasks by assignee report", () => {
	const generator = new className(
		"Should be a repo adapter, but doesn't matter because we're stubbing repo",
		mockHandler
	)
	generator.repository = mockRepository
	expect(generator.tasksByAssigneeReport({assignees: ["Test"]})).toStrictEqual(mockRepository.listByAssignee({assignees: ["Test"]}))
})

test("upcoming tasks report", () => {
	const generator = new className(
		"Should be a repo adapter, but doesn't matter because we're stubbing repo",
		mockHandler
	)
	generator.repository = mockRepository
	expect(generator.upcomingTasksReport({})).toStrictEqual(mockRepository.listUpcoming())
})

test("overdue tasks report", () => {
	const generator = new className(
		"Should be a repo adapter, but doesn't matter because we're stubbing repo",
		mockHandler
	)
	generator.repository = mockRepository
	expect(generator.overdueTasksReport({})).toStrictEqual(mockRepository.listOverdue())
})

test("complete tasks report", () => {
	const generator = new className(
		"Should be a repo adapter, but doesn't matter because we're stubbing repo",
		mockHandler
	)
	generator.repository = mockRepository
	expect(generator.completedTasksReport({})).toStrictEqual(mockRepository.listComplete())
})

test("summary report", () => {
	const generator = new className(
		"Should be a repo adapter, but doesn't matter because we're stubbing repo",
		mockHandler
	)
	generator.repository = mockRepository
	expect(generator.taskSummaryReport()).toStrictEqual(mockRepository.list())
})

test("distribution report", () => {
	const generator = new className(
		"Should be a repo adapter, but doesn't matter because we're stubbing repo",
		mockHandler
	)
	generator.repository = mockRepository
	expect(generator.taskDistributionReport()).toStrictEqual(mockRepository.list())
})

test("countdown report", () => {
	const generator = new className(
		"Should be a repo adapter, but doesn't matter because we're stubbing repo",
		mockHandler
	)
	generator.repository = mockRepository
	expect(generator.countdownReport({})).toStrictEqual(mockRepository.list())
})

class TestRepository {
  list(sortBy, order) {
    ["list success"]
	}

  listOverdue(sortBy, order) {
    ["list overdue"]
	}

  listByStatus(status, sortBy, order) {
    ["list by #{status}"]
	}

  listByAssignee(assignee, sortBy, order) {
    ["list by #{assignee}"]
	}

  listUpcoming(sortBy, order) {
    ["list upcoming"]
	}

  listComplete(sortBy, order) {
    ["list Completed"]
	}
}

class TestHandler {
	generateOutput(data) {
		data
	}
}
