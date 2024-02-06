const path = require('path');
const Report = require(path.join(__dirname, '../lib/Report'));

beforeEach(() => {
	className = Report;
});

test("should generate a report by passing data to the output handler to generate output", () => {
	testData = "This is a test"
	expected = testData + " that it made it to the handler"
	expect(new className(new TestHandler()).generateReport(testData)).toStrictEqual(expected);
});


class TestHandler {
	generateOutput(data) {
		return data + " that it made it to the handler"
	}
}
