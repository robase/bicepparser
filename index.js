const fs = require("fs");
const peggy = require("peggy");
const { exit } = require("process");

const fileIndex = JSON.parse(
  fs.readFileSync("./examples/index.json", { encoding: "utf-8" })
);

const parser = peggy.generate(
  fs.readFileSync("bicep.peggy", { encoding: "utf-8" })
);

const results = [];

fileIndex.forEach((file) => {
  if (file.filePath.startsWith("000")) {
    const testContent = fs.readFileSync(`./examples/${file.filePath}`, {
      encoding: "utf-8",
    });
    let passed = true;
    let error;
    try {
      parser.parse(testContent);
    } catch (e) {
      passed = false;
    //   error = e;
    //     console.log(e.location);
      //   exit();
    }

    results.push({ file: file.filePath, passed, error });
  }
});

console.log(results);
