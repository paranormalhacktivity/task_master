const path = require('path');
const AsciiTable = require(path.join(__dirname, '../lib/AsciiTable'));
const originalConsoleLog = console.log;
let logOutput = [];

beforeAll(() => {
	console.log = jest.fn((...args) => {
		logOutput.push(args.join(' '));
	});
	process.stdout.write = jest.fn((...args) => {
		logOutput.push(args.join(' '));
	});
});

afterAll(() => {
	console.log = originalConsoleLog;
});

beforeEach(() => {
	headers = ["Header 1", "Header 2"];
	rows = [["foo", "1"], ["bar", "12"]];
	class_name = AsciiTable;
});

test("should write table to stdout", () => {
	new class_name(headers, rows).draw();
	expect(logOutput.join('')).toContain(expectedTable());
});

test("should return table where each line of the table has same number of characters", () => {
	new class_name(headers, rows).draw();
	expect(
		Array.from(
			new Set(
				logOutput.join('').split("\n").map((line) => {
					if(line.lenth > 0) {
						return line.length
					}
				})
			)
		).length
	).toEqual(1)
});

test("should dynamically resize table based on cell contents size", () => {
	differentSizedHeaders = ["Extra long header 1", "Extra long header 2"]
	new class_name(headers, rows).draw()
	const outputOne =
		Array.from(
			new Set(
				logOutput.join('').split("\n").map((line) => {
					return line.length
				})
			)
		)[0]
	console.log = originalConsoleLog;
	logOutput.length = 0
	console.log = jest.fn((...args) => {
		logOutput.push(args.join(' '));
	});
	new class_name(differentSizedHeaders, rows).draw()
	console.log = originalConsoleLog;
	const outputTwo =
		Array.from(
			new Set(
				logOutput.join('').split("\n").map((line) => {
					return line.length
				})
			)
		)[0]
	expect(outputOne).not.toEqual(outputTwo)
})

function expectedTable() {
	return [
		"+----------+----------+",
		"| Header 1 | Header 2 |",
		"+----------+----------+",
		"| foo      | 1        |",
		"| bar      | 12       |",
		"+----------+----------+"
	].join("")
}
