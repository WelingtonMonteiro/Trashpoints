module.exports = {
    correctDate: correctDate,
    searchDate: searchDate
};

const _ = require('lodash');

function correctDate(DateInput) {
    if (!DateInput) {
        return null;
    }

	DateInput = DateInput.split(/\/|-\\/);

	let dateString = _.padStart(DateInput[2], 4, '0') + '-';
	//noinspection JSUnresolvedFunction
	dateString += _.padStart(DateInput[1], 2, '0') + '-';
	//noinspection JSUnresolvedFunction
	dateString += _.padStart(DateInput[0], 2, '0');

	return new Date(dateString);
}

function searchDate(DateInput) {
    try {
        if (!(DateInput instanceof Date)) {
            if (typeof DateInput !== 'string') {
                DateInput = DateInput.toString();
            }
            DateInput = new Date(DateInput);
        }
    } catch (Exception) {
        return null;
    }
    return parseInt(dateToNumber(DateInput), 10);
}

function dateToNumber(DateInput) {
    const year = DateInput.getFullYear();
    const month = DateInput.getMonth() + 1;
    const date = DateInput.getDate();

    //noinspection JSUnresolvedFunction
    let dateString = _.padStart(year, 4, '0');

    //noinspection JSUnresolvedFunction
    dateString += _.padStart(month, 2, '0');
    //noinspection JSUnresolvedFunction
    dateString += _.padStart(date, 2, '0');

    return dateString;
}