/**
 * @file opFuncs.h
 * @brief operation functions
 */

#ifndef PARSER_H
#define PARSER_H

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include <stack>
#include <iostream>
#include "PNode.h"

namespace Parser {

struct SemanticVersion {
  unsigned major = 0;
  unsigned minor = 0;
  unsigned patch = 0;

  bool operator<(const SemanticVersion& rhs) const {
    if (major != rhs.major) return major < rhs.major;
    if (minor != rhs.minor) return minor < rhs.minor;
    return patch < rhs.patch;
  }

  std::string str() const {
    return std::to_string(major) + "." + std::to_string(minor) + "." +
           std::to_string(patch);
  }
};

class Lexical : public yyFlexLexer {
public:
  PNode* root = NULL;
  PList* list = NULL;
  SemanticVersion version;
  Lexical(std::istream& arg_yyin, std::ostream& arg_yyout) : Lexical(&arg_yyin, &arg_yyout) {}
  Lexical(std::istream* arg_yyin = nullptr, std::ostream* arg_yyout = nullptr) :
    yyFlexLexer(arg_yyin, arg_yyout) {
    indentLevels.push(0);
  }
  Lexical(std::istream& arg_yyin, std::ostream& arg_yyout,
          SemanticVersion arg_version) : Lexical(&arg_yyin, &arg_yyout) {
    version = arg_version;
  }
  int lex(Syntax::semantic_type* yylval);
  int lex_debug(Syntax::semantic_type* yylval);
  void set_lineno(int n) { yylineno = n; }
  void requireChoiceFeature(const char* feature) const {
    static const SemanticVersion firstChoiceVersion{7, 0, 0};
    if (version < firstChoiceVersion) {
      std::cerr << "Error at line " << yylineno << ": " << feature
                << " requires FIRRTL version 7.0.0 or newer; file declares "
                << version.str() << "." << std::endl;
      exit(EXIT_FAILURE);
    }
  }
protected:
  int curr_indent = 0;
  int angle_num = 0;
  int square_num = 0;
  int bracket_num = 0;
  int parenthesis_num = 0;
  std::stack<int>indentLevels;
};

}  // namespace Parser

#endif
