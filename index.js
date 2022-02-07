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
let failures = 0
fileIndex.forEach((file) => {
  if (file.filePath.startsWith("000") || true) {

    const testContent = fs.readFileSync(`./examples/${file.filePath}`, {
      encoding: "utf-8",
    });

    let passed = true;
    let error;

    try {
      parser.parse(testContent);
    } catch (e) {
      passed = false;
      failures++
    }

    results.push({ file: file.filePath, passed, error });

    console.log(`| [${file.filePath}](/examples/${file.filePath}) | ${passed ? '🟢 passed' : '🔴 failed' } |`);
  }
});

console.log(`${results.length - failures}/${results.length} files successfully parsed`);
