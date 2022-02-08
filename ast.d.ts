type DataType = "bool" | "string" | "int" | "object" | "array";

type BinaryOperator = "&&" | "||" | "??";
type EqualityOperator = "==" | "!=";
type RelationalOperator = ">" | ">=" | "<" | "<=";
type AdditiveOperator = "+" | "-";
type MultiplicativeOperator = "*" | "|" | "%";
type UnaryOperator = "!" | "-" | "+";

type LeftRightOperator =
  | BinaryOperator
  | EqualityOperator
  | RelationalOperator
  | AdditiveOperator
  | MultiplicativeOperator
  | UnaryOperator;

interface BinaryExpression {
  type: "BinaryExpression";
  operator: LeftRightOperator;
  left: Expression;
  right: Expression;
}

interface IndexedProperty {
  type: "IndexedProperty";
  property: NumberLiteral;
}

interface DotIdentifierProperty {
  type: "DotIdentifierProperty";
  property: Identifier;
}

interface FunctionCallProperty {
  type: "FunctionCallProperty";
  property: FunctionCall;
}

interface ColonProperty {
  type: "ColonProperty";
  property: Identifier;
}

interface MemberExpression {
  type: "MemberExpression";
  object: Expression;
  property:
    | IndexedProperty
    | DotIdentifierProperty
    | FunctionCallProperty
    | ColonProperty;
}

type Expression = BinaryExpression | PrimaryExpression | MemberExpression;

interface TargetScopeDeclaration {
  type: "TargetScopeDeclaration";
  scope: "subscription" | "tenant" | "managementGroup" | "resourceGroup";
}

interface ImportDeclaration {
  type: "ImportDeclaration";
  name: string;
  // decorators: Decorator[];
  // dataType: DataType;
  // expression: Expression;
}

interface ParameterDeclaration {
  type: "ParameterDeclaration";
  name: string;
  decorators: Decorator[];
  dataType: DataType;
  expression: Expression;
}
interface VariableDeclaration {
  type: "VariableDeclaration";
  name: string;
  decorators: Decorator[];
  expression: Expression;
}
interface ResourceDeclaration {
  type: "ResourceDeclaration";
  name: string;
  decorators: Decorator[];
  module: StringLiteral;
  existing: "existing";
  expression: BObject;
}
interface ModuleDeclaration {
  type: "ModuleDeclaration";
  decorators: Decorator[];
  name: string;
  module: StringLiteral;
  expression: Expression;
}
interface OutputDeclaration {
  type: "OutputDeclaration";
  id: string;
  decorators: Decorator[];
  dataType: DataType;
  expression: Expression;
}

interface Decorator {
  type: Decorator;
  expression: FunctionCall; // OR mem expr . functioncall
}

interface Identifier {
  type: "Identifier";
  name: string;
}

interface TemplateLiteral {
  type: "TemplateLiteral";
  expressions: Expression[];
  quasis: StringLiteral[];
}

interface StringLiteral {
  type: "String";
  value: string;
}

interface NumberLiteral {
  type: "Number";
  value: number;
  raw: string;
}

interface BooleanLiteral {
  type: "Boolean";
  value: boolean;
  raw: string;
}

interface NullLiteral {
  type: "Null";
  value: null;
  raw: string;
}

type LiteralValue = BooleanLiteral | NullLiteral | NumberLiteral;

interface BArray {
  type: "ArrayExpression";
  elements: Expression[];
}

interface BObjectProperty {
  key: Identifier | StringLiteral | TemplateLiteral;
  value: Expression;
}

interface BObject {
  type: "Object";
  properties: BObjectProperty[];
}

interface FunctionCall {
  type: "FunctionCall";
  name: string;
  args?: Expression[];
}

type Statement =
  | ParameterDeclaration
  | VariableDeclaration
  | ImportDeclaration
  | ModuleDeclaration
  | OutputDeclaration
  | ResourceDeclaration
  | TargetScopeDeclaration;

type PrimaryExpression =
  | StringLiteral
  | TemplateLiteral
  | BArray
  | BObject
  | FunctionCall
  | LiteralValue
  | Identifier
  | TemplateElement;

interface TemplateElement {
  type: "TemplateElement";
  value: string;
  tail: boolean;
}

interface AST {
  type: "Bicep";
  body: Statement[];
}


