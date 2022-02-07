const fs = require("fs");
const peggy = require("peggy");

const fileIndex = JSON.parse(
  fs.readFileSync("./examples/index.json", { encoding: "utf-8" })
);

const parser = peggy.generate(
  fs.readFileSync("bicep.peggy", { encoding: "utf-8" })
);

const results = [];
let failures = 0;

fileIndex.forEach((mainFile) => {
  const dirPath = mainFile.filePath.substring(0, mainFile.filePath.lastIndexOf("/") + 1);

  fs.readdirSync(`./examples/${dirPath}`).forEach((fileName) => {
    if (fileName.endsWith(".bicep")) {
      const testContent = fs.readFileSync(`./examples/${dirPath}${fileName}`, {
        encoding: "utf-8",
      });

      let passed = true;

      try {
        parser.parse(testContent);
      } catch (e) {
        passed = false;
        failures++;
      }

      results.push({ file: `./examples/${dirPath}${fileName}`, passed });

      console.log(
        `| [${dirPath}${fileName}](./examples/${dirPath}${fileName}) | ${
          passed ? "🟢 yes" : "🔴 failed"
        } |`
      );
    }
  });
});

console.log(
  `${results.length - failures}/${results.length} files successfully parsed`
);
