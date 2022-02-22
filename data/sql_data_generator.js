const fs = require('fs');

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

const users = require('./generated.json')

const doctors = [
	"PVGCGR99C27G273N",
	"VCRBNC99D27G273N",
	"LPPMRL98C27G273N",
	"DCRRGG98C27G273N",
	"NRIGSP98C27G273N"
]

const products = [
	"pfizer",
	"moderna",
	"janssen",
	"astrazeneca"
]

const times = [
   	"09:00:00",
    "10:00:00",
    "11:00:00",
    "12:00:00",
    "13:00:00",              
    "14:00:00",
    "15:00:00",
    "16:00:00",
    "17:00:00",
    "18:00:00"
]

let insertUser1 = 'INSERT INTO Vac_User VALUES ('
let insertUser2 = '); '

let insertVaccine1 = 'INSERT INTO Vaccination VALUES ('
let insertVaccine2 = '); '

let insertUserCred1 = 'INSERT INTO User_Credentials VALUES ('
let insertUserCred2 = ', "96ec13d5ec40f735763e59fc46eb0a786681284d7adbdc0f2d8e0bd5abdc448"); '

const password_hash = "96ec13d5ec40f735763e59fc46eb0a786681284d7adbdc0f2d8e0bd5abdc448"

let result = ""

const specialKeys = ["gender","category","fiscal_code", "firstdate", "seconddate"]

users.forEach(u => {
	let insert = insertUser1
	let insertCred = ""

	const userFiscalCode = u.fiscal_code.toUpperCase().slice(8, 24)

	let firstVac = 
		insertVaccine1 +
		'"' + userFiscalCode + "_" + 1 + '", ' +
		'"' + userFiscalCode + '", ' + 
		'"' + doctors[getRandomInt(0,4)] + '", ' +
		'"' + products[getRandomInt(0,3)] + '", ' +
		'"' + u.firstdate + '", ' +
		'1' +
		insertVaccine2


	let secondVac = 
		insertVaccine1 +
		'"' + userFiscalCode + "_" + 2 + '", ' +
		'"' + userFiscalCode + '", ' + 
		'null, ' +
		'null, ' +
		'"' + u.seconddate + " " + times[getRandomInt(0,9)] + '", ' +
		'2' +
		insertVaccine2

	const keys = Object.keys(u)
	// console.log(keys)
	keys.forEach(k => {
		if (!specialKeys.includes(k)) {
			u[k] = '"' + u[k] + '"'
			insert += u[k] + ","
		} else if (k == "gender") {
			insert += u[k] + ","
		} else if (k == "category") {
			u[k] = '"' + u[k] + '"'
			insert += u[k]
		} else if (k == "fiscal_code") {
			// u[k] = u[k].toUpperCase()
			// u[k] = '"' + u[k].slice(8,24) + '"'
			insert += '"' + userFiscalCode + '"' + ","
			insertCred = insertUserCred1 + '"' + userFiscalCode + '"' + insertUserCred2
		}
	})

	insert += insertUser2

	result += insert + "\n"
	result += insertCred + "\n"
	result += firstVac + "\n"
	result += secondVac + "\n\n"
})

console.log("done")

fs.writeFileSync('user-result.sql', result);