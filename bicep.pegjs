
{{
  function extractList(list, index) {
    return list.map(function(element) { return element[index]; });
  }

  function buildList(head, tail, index) {
    return [head].concat(extractList(tail, index));
  }

  function buildBinaryExpression(head, tail) {
    return tail.reduce(function(result, element) {
      return {
        type: "BinaryExpression",
        operator: element[1],
        left: result,
        right: element[3]
      };
    }, head);
  }

  function optionalList(value) {
    return value !== null ? value : [];
  }
}}

BICEP = __ head:statement tail:(__ statement)* __ { 
  return { type: 'BICEP', body: buildList(head, tail, 1) }
}

statement
  = targetScopeDecl 
  / importDecl 
  / parameterDecl 
  / variableDecl 
  / resourceDecl 
  / moduleDecl 
  / outputDecl 
  / ( _ NL ) / NL

// Target scope
targetScopeDecl
  = "targetScope" _ "=" __ "'" value:targetScopeValue "'" { return {
  	type: 'TargetScopeDeclaration',
    scope: value
  }}

targetScopeValue
  = "subscription"
  / "tenant"
  / "managementGroup"
  / "resourceGroup"

importDecl = (decorator __)* "import" identifier "as" identifier object? NL

// Params
parameterDecl
  = decs:(decorator __)* "param" _ name:identifier _ dataType:DataType __ val:paramValue { 
      return {
          type: 'ParameterDeclaration',
          name: name.name,
          decorators: extractList(decs,0),
          dataType,
          expression: val
        }
    }

paramValue = exp:("=" __ expression __) { return exp[2] } / __

variableDecl = decorators:(decorator __)* "var" _ id:identifier __ "=" __ exp:expression __ {
  return {
    type: 'VariableDeclaration',
    name: id.name,
    decorators: extractList(decorators, 0),
    expression: exp
  }
}

resourceDecl = decorators:(decorator __)* "resource" _ id:identifier _ mod:interpString ext:(_ "existing")? __ "=" __ expr:(ifCondition / object / forExpression) __ {
  return {
    type: 'ResourceDeclaration',
    name: id.name,
    decorators: extractList(decorators, 0),
    module: mod,
    existing: ext,
    expression: expr
  }
}

moduleDecl = decorators:(decorator __)* "module" _ id:identifier _ mod:interpString __ "=" __ expr:(ifCondition / object / forExpression) __ {
  return {
    type: 'ModuleDeclaration',
    decorators: extractList(decorators, 0),
    name: id.name,
    module: mod,
    expression: expr
  }
}

outputDecl = decorators:(decorator __)* "output" _ id:identifier _ dataType:DataType __"=" __ expression:expression __ {
   return {
     type: "OutputDeclaration",
     id: id.name,
     decorators,
     dataType,
     expression,
  }
}

identifier = id:([a-zA-Z_0-9]+) { 
  return {
    type: 'Identifier',
    name: id.join('')
  }
}

ifCondition = "if" ___ test:parenthesizedExpression ___ object {
  return {
    type: 'IfCondition',
    test
  }
}

parenthesizedExpression = "(" expression ")"
forExpression = "[" ___ "for" _ (identifier / forVariableBlock) _ "in" _ expression ___ ":" ___ forBody "]"
forVariableBlock = "(" ___ identifier ___ "," ___ identifier ___ ")"
forBody = __ expression  __  / ifCondition

decorator = "@" exp:decoratorExpression { return { type: 'Decorator', expression: exp }}
decoratorExpression = functionCall / (memberExpression "." functionCall)

// Types
DataType
  = "string"
  / "int"
  / "bool"
  / "object"
  / "array"
  // / "any" __ "=" __ primaryExpression

expression
  = head:binaryExpression ___
    tail:("?" ___ expression ___":"___ expression)* {
      return buildBinaryExpression(head, tail) 
    }

binaryOperator = "&&" / "||" / "??"
binaryExpression 
  = head:equalityExpression 
    tail:( ___ binaryOperator ___ binaryExpression)* {
      return buildBinaryExpression(head, tail) 
    }

equalityOperator = "==" / "!="
equalityExpression 
  = head:relationalExpression 
    tail:( ___ equalityOperator ___ equalityExpression)* {
      return buildBinaryExpression(head, tail) 
    }

relationalOperator = ">" / ">="  / "<"  / "<=" 
relationalExpression =
  head:additiveExpression 
  tail:( ___ relationalOperator ___ relationalExpression)* {
    return buildBinaryExpression(head, tail) 
  }

additiveOperator = "+" / "-"
additiveExpression =
  head:MultiplicativeExpression 
  tail:(___ additiveOperator ___ additiveExpression)* {
    return buildBinaryExpression(head, tail) 
  }

MultiplicativeOperator = "*" / "/" / "%" 
MultiplicativeExpression =
  head:unaryExpression 
  tail:(___ MultiplicativeOperator ___ MultiplicativeExpression)* {
    return buildBinaryExpression(head, tail) 
  }

unaryOperator = "!" / "-" / "+"
unaryExpression = 
  head:memberExpression 
  tail:(___ unaryOperator ___ unaryExpression)* {
    return buildBinaryExpression(head, tail) 
  }

memberExpression
  = head:primaryExpression
    tail:(
    "[" property:(primaryExpression) "]" { return { type: 'IndexedProperty', property }}
    /  "." property:functionCall { return { type: 'FunctionCallProperty', property }}
    /  "." property:identifier { return { type: 'DotIdentifierProperty', property }}
    /  ":" property:identifier { return { type: 'ColonProperty', property }}
  )*  {
      return tail.reduce((result, element) => {
        return {
          type: "MemberExpression",
          object: result,
          property: element
        };
      }, head);
    }

// FIXME
char "char" 
  = unescaped 
  / escape sequence:"'" { return sequence; }

// [a-zA-Z_ *\-,\.\{\}0-9/@=;:~\\!\(\)"\|\[\]?\$<>]
unescaped
  = [a-zA-Z_ *\-,\.\{\}0-9\/@=;:~\!\(\)"\|\[\]?\$<>]

escape
  = "\\"

interpString 
  = left:stringLeftPiece middle:( expression stringMiddlePiece )* expRight:expression right:stringRightPiece {
    return {
      type: 'TemplateLiteral',
      expressions: extractList(middle,0).concat([expRight]),
      quasis: [left, ...extractList(middle,1), right]
    }
  }
  / str:stringComplete { 
      return str 
    }

stringLeftPiece = "'" str:char* "${" { return {type: 'TemplateElement', value: str.join(''), tail:false }}
stringMiddlePiece = "}" str:char* "${" { return {type: 'TemplateElement', value: str.join(''), tail:false }}
stringRightPiece = "}" str:char* "'" { return {type: 'TemplateElement', value: str.join(''), tail:true }}
stringComplete = "'" str:char* "'" { return { type: 'String', value: str.join('') } }

multilineString = "'''" str:(char / NL)* "'''" { return { type: 'MultilineString', value: str.join('') } }

primaryExpression
  = multilineString
  / interpString
  / array
  / object
  / functionCall
  / literalValue
  / identifier
  / parenthesizedExpression
  / forExpression

literalValue 
  = num:( "-" [0-9]+ / [0-9]+ ) { return { type: 'Number', value: parseInt(num.join('')), raw: num.join('') }}
  / "true" { return { type: 'Boolean', value: true, raw: 'true'}}
  / "false" { return { type: 'Boolean', value: false, raw: 'false'}}
  / "null" { return { type: 'Null', value: null, raw: 'null'}}

array = "[" ___  line:arrayLine? NL* ___ "]" {
    return {
      type: 'ArrayExpression',
      elements: line
    }
  }

arrayLine = NL+ els:arrayItem+ { return [...els] }
arrayItem = ___ exp:expression ___ NL+ { return exp }

object = "{" __ props:( objectProperty NL+ )* __ "}" {
  return {
    type: 'Object',
    properties: extractList(props,0)
  }
}
objectProperty = ___ key:( identifier / interpString ) ___ ":" ___ exp:expression ___ {
  return {
    key,
    value: exp
  }
}

functionCall = id:identifier "(" args:argumentList? ")" { return {
  type: 'FunctionCall',
  name: id.name,
  args: optionalList(args)
}}

argumentList = 
  head:expression 
  tail:("," __ expression)* { 
    return [head].concat(extractList(tail,2))
  }
// argumentList = ""

// Whitespace
___ "optional no new line" = ([ \t])*
_ "mandatory whitespace" = ([ \t])+

__ = (WhiteSpace / LineTerminatorSequence / Comment)*

WhiteSpace "whitespace" = [ \t]

// Separator, Space
Zs = [\u0020\u00A0\u1680\u2000-\u200A\u202F\u205F\u3000]

NL "NewLine" = ( Comment* [\n\r]+)

LineTerminator = [\n\r\u2028\u2029]

LineTerminatorSequence "end of line"
  = "\n"
  / "\r\n"
  / "\r"

Comment "comment"
  = MultiLineComment
  / SingleLineComment

MultiLineComment
  = "/*" comm:(!"*/" char)* "*/" {
    return { value: extractList(comm, 1)}
  }

MultiLineCommentNoLineTerminator
  = "/*" (!("*/" / LineTerminator) char)* "*/"

SingleLineComment
  = "//" comm:(!LineTerminator (char / "'"))* {
    return { value: extractList(comm, 1)}
  }

