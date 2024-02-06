class AsciiTable {
	constructor(headers, rows) {
		this.headers = headers
		this.rows = rows
		this.columnWidths = this.#calculateColumnWidths()
	}

	draw() {
		console.log(this.#horizontalLine())
		this.#printRow(this.headers)
		console.log(this.#horizontalLine())
		this.rows.forEach((row) => { this.#printRow(row) })
		console.log(this.#horizontalLine())
	}

	#calculateColumnWidths() {
		return this.headers.map((header, i) => {
			return [
				header,
				...this.rows.map((row) => {
					return row[i]
				})
			].reduce((max, row) => {
				const currentLength = row.length + 2;
				return Math.max(max, currentLength);
			}, 0);
		})
	}

	#horizontalLine() {
		return "+" + this.columnWidths.map((width) => {
			return "-".repeat(width)
		}).join("+") + "+"
	}

	#printRow(row) {
		row.forEach((cell, i) => {
			const paddedCell = this.#ljust(cell, (this.columnWidths[i] - 2))
		  process.stdout.write(`| ${paddedCell} `)
		})
		console.log("|")
	}

	#ljust(str, length, char = " ") {
		if (str.length >= length) {
			return str;
		}

		const padding = char.repeat(length - str.length)
		return str + padding
	}
}

module.exports = AsciiTable
