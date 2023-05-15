var express = require('express');
var router = express.Router();
var db = require('../db')

router.get('/', function (req, res, next) {
  res.send(`Yes I am working!`);
});

router.get('/showTables', (req, res, next) => {
  try {
    let query = "show tables;"
    db.executeQueryAsPromise(query, null)
      .then((queryResults) => {
        if (queryResults.length == 0) {
          queryResults = "No results found"
        }
        res.send(queryResults)
      }).catch((err) => { next(err) })
  }
  catch (err) { next(err) }
})

//************************************ */
//************CREATE ROUTES*********** */
//************************************ */

router.post("/addOrUpdateAbout", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO about (id, name, bio, followCount, socialLink, pannel) VALUES \
    (?,?,?,?,?,?) \
    on duplicate key update name=values(name), bio=values(bio), followCount=values(followCount), \
    socialLink=values(socialLink), pannel=values(pannel); \
    SELECT * FROM about"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})


router.post("/addOrUpdateCategory", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO category (id, title, description) VALUES  \
    (?,?,?) \
    on duplicate key update title=values(title), description=values(description);\
    select * from about"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdateLive", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO live (id, title, name, viewLive, display, time, follow, subscribe) VALUES \
    (?,?,?,?,?,?,?,?) \
    on duplicate key update title=values(title), name=values(name), viewLive=(viewLive),\
display=values(display), time=values(time), follow=values(follow), subscribe=values(subscribe);\
    select * from live"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdateChannel", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO channel (id, name, followCount, verification, avatar, follow, subscribe, liveId, aboutId) VALUES \
    (?,?,?,?,?,?,?,?,?) \
    on duplicate key update name=values(name), followCount=values(followCount), verification=values(verification), \
    avatar=values(avatar), follow=values(follow), subscribe=values(subscribe), liveId=values(liveId), aboutId=values(aboutId);\
    select * from channel"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})


router.post("/addOrUpdateLiveCategory", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `live-category` (liveId, categoryId) VALUES \
    (?,?) \
    on duplicate key update liveId=values(liveId), categoryId=values(categoryId);\
    select * from  `live-category`;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})


router.post("/addOrUpdateChat", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO chat (id, name, message, badge, settings, liveId) VALUES \
    (?,?,?,?,?,?) \
    on duplicate key update name=values(name), message=values(message), badge=values(badge),  \
    settings=values(settings), liveId=values(liveId);\
    select * from chat"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdateTag", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO tag (id, name, liveId) VALUES  \
    (?,?,?) \
    on duplicate key update name=values(name), liveId=values(liveId);\
    select * from chat"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})


//************************************ */
//*********RETRIEVE ROUTES************ */
//************************************ */
//Select queries can be done as gets

router.get('/getCategoryLive/:id', (req, res, next) => {
  const inputs = [req.params.id]
  const query = "\
    SELECT live.* \
    from live\
    JOIN `live-category` ON `live-category`.liveId = live.id\
    JOIN category ON `live-category`.categoryId = category.id\
    where category.id = ?;"
  db.executeQueryAsPromise(query, inputs)
    .then(results => {
      if (results.length == 0) {
        res.send("No results found")
      } else {
        res.send(results)
      }
    }).catch((error) => {
      issue = { issue: "There was a problem running your queries", error }
      console.log(issue)
      res.send(issue)
    })
})

router.get('/getChatMessage/:id', (req, res, next) => {
  const inputs = [req.params.id]
  const query = "\
    SELECT name, message \
    from chat\
    where id = ?;"
  db.executeQueryAsPromise(query, inputs)
    .then(results => {
      if (results.length == 0) {
        res.send("No results found")
      } else {
        res.send(results)
      }
    }).catch((error) => {
      issue = { issue: "There was a problem running your queries", error }
      console.log(issue)
      res.send(issue)
    })
})

router.get('/getAboutBio/:id', (req, res, next) => {
  const inputs = [req.params.id]
  const query = "\
    SELECT name, bio \
    from about\
    where id = ?;"
  db.executeQueryAsPromise(query, inputs)
    .then(results => {
      if (results.length == 0) {
        res.send("No results found")
      } else {
        res.send(results)
      }
    }).catch((error) => {
      issue = { issue: "There was a problem running your queries", error }
      console.log(issue)
      res.send(issue)
    })
})

//************************************ */
//***********UPDATE ROUTES************ */
//************************************ */
//Update queries can be done as posts


router.post("/updateChatName", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    update chat set name = ? where id = ?;\
    \
    SELECT * FROM chat;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/updateChannelAvatar", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    update channel set avatar = ? where id = ?;\
    \
    select * from channel;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

//************************************ */
//***********DELETE ROUTES*********** */
//************************************ */

router.post("/deleteLiveCategory", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    delete from `live-category` where categoryId = ?;\
    \
    select * from `live-category`;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/deleteTopicTag", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    delete from `topic-tag` where tagId = ?;\
    \
    select * from `topic-tag`;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/deleteTag", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    delete from tag where id = ?;\
    \
    select * from tag;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})



//************************************ */
//***********GENERIC ROUTES*********** */
//************************************ */
//These routes take care of any calls you make that are spelled wrong or have the wrong type
//No need to mess with them unless you are an experienced programmer

router.get('/*', (req, res, next) => {
  res.send(`The route you used:${req.originalUrl} was not found. Was it supposed to be a POST?`)
})
router.post('/*', (req, res, next) => {
  res.send(`The route you used:${req.originalUrl} was not found. Was it supposed to be a GET?`)
})


//************************************ */
//***********SUPPORTING CODES********* */
//************************************ */
//This code is used by the routes.
//No need to mess with it unless you are an experienced programmer

function rowsToHtmlTable(results) {
  const tableStyle = '"border:1px solid black;padding:5px"'
  const cellStyle = '"border:1px solid black;padding:5px"'
  const cellStyleFirstRow = '"font-weight:600"'
  const htmlRows = results.map((row, index) => {
    const columns = Object.keys(row).map((columnName) => {
      return { columnName, columnValue: row[columnName] }
    })
    let htmlColumns = null
    if (index == 0) {
      htmlColumns = columns.map((column) => {
        return `<th style=${cellStyleFirstRow}>${column.columnName}</th>`
      })
    } else {
      htmlColumns = columns.map((column) => {
        return `<td style=${cellStyle}>${column.columnValue}</td>`
      })
    }
    return `<tr>${htmlColumns.join("")}</tr>`
  })
  return `<table style=${tableStyle}>${htmlRows.join("")}</table>`
}

function validateAndFormatInputs(inputs) {
  let results = { inputsAreValid: true, validations: [], placeholders: [] }
  if (typeof (inputs) !== "object") {
    results.inputsAreValid = false
    results.validations.push({ error: true, message: `Expecting an object, got: ${typeof (inputs)}` })
  }
  Object.keys(inputs).forEach((input) => {
    let valueOfInput = inputs[input]
    switch (input) {
      //add a case for any input that you want to validate
      case "id":
        if (valueOfInput != null && !Number.isInteger(valueOfInput)) {
          results.inputsAreValid = false
          results.validations.push({ error: true, message: `In id value expecting null or an integer, got: ${valueOfInput}` })
        }
        break
      case "dateAdded":
        if (valueOfInput === "*fillInCurrentDate*") valueOfInput = mysqlTimestamp()
        if (isNaN(Date.parse(valueOfInput))) {
          results.inputsAreValid = false
          results.validations.push({ error: true, message: `This is not a valid date: ${valueOfInput}` })
        }
        break
      case "email":
        if (!valueOfInput.includes("@")) {
          results.inputsAreValid = false
          results.validations.push({ error: true, message: `There needs to be an @ in your email input, got: ${valueOfInput}` })
        }
        break
    }
    results.placeholders.push(valueOfInput)
  })
  return results
}

mysqlTimestamp = () => {
  var date = new Date(Date.now());
  var yyyy = date.getFullYear();
  var mm = date.getMonth() + 1;
  var dd = date.getDate();
  var hh = date.getHours();
  var min = date.getMinutes();
  var ss = date.getSeconds();
  var mysqlDateTime = yyyy + '-' + mm + '-' + dd + ' ' + hh + ':' + min + ':' + ss;
  return mysqlDateTime;
}
module.exports = router;
