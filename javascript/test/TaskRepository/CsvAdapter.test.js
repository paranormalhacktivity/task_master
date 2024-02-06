const path = require('path');
const CsvAdapter = require(path.join(__dirname, '../../lib/taskRepository/CsvAdapter'));

test("should list all task in supplied csv", () => {
	const fixtureFile = path.join(__dirname, "../fixtures/test_data.csv");
	const instance = new CsvAdapter(fixtureFile);
	expect(instance.list().length).toBe(6);
});
