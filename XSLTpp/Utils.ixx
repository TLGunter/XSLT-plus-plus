
import Debug;
import CppTypes;
import Expr;

import <iostream>;
import <string>;
import <string_view>;
import <vector>;
import <map>;


export module Utils;

using namespace Debug;

export i32 file_length(FILE *fp) {

    i32       length;
    const i32 OFFSET = 0;

    fseek(fp, OFFSET, SEEK_END);
    length = ftell(fp);

    fseek(fp, OFFSET, SEEK_SET);

    return length;
}

export std::string file_to_str(const std::string& path) {

    FILE *file   = fopen(path.c_str(), "rb");
    char *buffer = 0;
    i32   length;

    assert_if(file == nullptr, "file == nullptr\n");

    length = file_length(file);
    buffer = new char[length];

    assert_if(buffer == nullptr, "buffer == nullptr\n");

    fread(buffer, sizeof(char), length, file);
    fclose(file);

    return buffer;
}

inline const bool is_letter(const char c) {

    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

inline const bool is_number(const char c) {

    return c >= '0' && c <= '9';
}

inline const bool is_whitespace(const char c){

    return c == '\t' || c == ' ' || c == '\n' || c == '\r' || c == '\f';
}


template<typename TokenType> struct Token {

  TokenType        type;
//std::string_view data; // @TODO: research string view
  std::string      data;
};


enum class Pass1_TokenType {
  None,
  Raw,     // surrounded by backticks
  Comment, // "//" to end of line
  Number,  // starts with numeral
  Word,    // everything else
};
export using Pass1_Token = Token<Pass1_TokenType>;


Pass1_Token pass1_tokenise_raw(const std::string &xsltpp_raw, u32 &i) {

  const u32   start_i = i;
  Pass1_Token raw_token;

  i++;
  for (; i < xsltpp_raw.size(); i++) {

    char c = xsltpp_raw[i];

    // @TODO: escape \`
    if (c == '`') {

      raw_token.type = Pass1_TokenType::Raw;
      i++;
      raw_token.data = xsltpp_raw.substr(start_i, i-start_i);
      break;
    }
  }

  if (i == start_i) {
    // @TODO: assert
  }

  return raw_token;
}

Pass1_Token pass1_tokenise_comment(const std::string &xsltpp_raw, u32 &i) {

  const u32   start_i = i;
  Pass1_Token raw_token;

  i++;
  for (; i < xsltpp_raw.size(); i++) {

    char c = xsltpp_raw[i];

    if (c == '\n') {

      raw_token.type = Pass1_TokenType::Comment;
      raw_token.data = xsltpp_raw.substr(start_i, i-start_i);
      break;
    }
  }

  if (i == start_i) {
    // @TODO: assert
  }

  return raw_token;
}

Pass1_Token pass1_tokenise_number(const std::string &xsltpp_raw, u32 &i) {

  const u32   start_i = i;
  Pass1_Token raw_token;

  for (; i < xsltpp_raw.size(); i++) {

    char c = xsltpp_raw[i];

    if (is_whitespace(c)) {

      raw_token.type = Pass1_TokenType::Number;
      raw_token.data = xsltpp_raw.substr(start_i, i-start_i);
      break;
    }
  }

  if (i == start_i) {
    // @TODO: assert
  }

  return raw_token;
}

Pass1_Token pass1_tokenise_word(const std::string &xsltpp_raw, u32 &i) {

  const u32   start_i = i;
  Pass1_Token raw_token;

  for (; i < xsltpp_raw.size(); i++) {

    char c = xsltpp_raw[i];

    if (is_whitespace(c)) {

      raw_token.type = Pass1_TokenType::Word;
      raw_token.data = xsltpp_raw.substr(start_i, i-start_i);
      break;
    }
  }

  if (i == start_i) {
    // @TODO: assert
  }

  return raw_token;
}

export std::vector<Pass1_Token> pass1_tokenise(const std::string &xsltpp_raw) {

  std::vector<Pass1_Token> pass1_tokens;

  for (u32 i = 0; i < xsltpp_raw.size(); i++) {

    const char c = xsltpp_raw[i];

    if (is_whitespace(c)) {
      continue;
    }

    if (c == '`') { // backtick

      pass1_tokens.push_back(pass1_tokenise_raw(xsltpp_raw, i));
      continue;
    }

    if (c == '/' && xsltpp_raw[i+1] == '/') { // comment

      if (i+1 < xsltpp_raw.size() && xsltpp_raw[i+1] == '/') {

        pass1_tokens.push_back(pass1_tokenise_comment(xsltpp_raw, i));
        continue;

      } else {
        print("don't do that"); // @TODO: error handling
      }
    }

    if (is_number(c)) {

      pass1_tokens.push_back(pass1_tokenise_number(xsltpp_raw, i));
      continue;
    }

    // not very strict right now
    pass1_tokens.push_back(pass1_tokenise_word(xsltpp_raw, i));
  }

  for (const auto &it : pass1_tokens) {

    std::string type;
    // @TODO: need for text_to_enum, enum to text
    if (it.type == Pass1_TokenType::None   ) type = "None    : ";
    if (it.type == Pass1_TokenType::Raw    ) type = "Raw     : ";
    if (it.type == Pass1_TokenType::Comment) type = "Comment : ";
    if (it.type == Pass1_TokenType::Number ) type = "Number  : ";
    if (it.type == Pass1_TokenType::Word   ) type = "Word    : ";

    print(type + it.data + "\n");
  }

  return pass1_tokens;
}



enum class Pass2_TokenType {
  None,
  Raw,
  // from number
  Real,
  Integer,
  // from word
  Name,
  Hash_Define,
  Hash_End_Define,
  Paren_Left,
  Paren_Right,
//Intrinsic,
};
export using Pass2_Token = Token<Pass2_TokenType>;


std::map<std::string, Pass2_TokenType> internal_words {
  { "#define"    , Pass2_TokenType::Hash_Define     },
  { "#end_define", Pass2_TokenType::Hash_End_Define },
  { "("          , Pass2_TokenType::Paren_Left      },
  { ")"          , Pass2_TokenType::Paren_Right     },
};

//@TODO: rename this, what is the definitions of tokenise, lex, parse???
Pass2_Token pass2_tokenise_word(const Pass1_Token &pass1_token) {

  Pass2_Token pass2_token;
  // note to self, the Token<> can go,
  // pass 2 seems to involve parsing into IR
  return pass2_token;
}

export std::vector<Pass2_Token> pass2_tokenise(const std::vector<Pass1_Token> &pass1_tokens) {

  std::vector<Pass2_Token> pass2_tokens;

  for (const Pass1_Token &pass1_token : pass1_tokens) {

    switch (pass1_token.type) {

      case Pass1_TokenType::None: {
        //@TODO: assert
        print("pass1 tokentype not set");
      } break;

      case Pass1_TokenType::Raw: {
        pass2_tokens.push_back({Pass2_TokenType::Raw, pass1_token.data});
      } break;

      case Pass1_TokenType::Comment: {
        // do nothing, let comment fade into the abyss
      } break;

      case Pass1_TokenType::Number: {
        //@TODO: real numbers
        //@TODO: check if number is any good
        pass2_tokens.push_back({Pass2_TokenType::Integer, pass1_token.data});
      } break;

      case Pass1_TokenType::Word: {
        pass2_tokens.push_back(pass2_tokenise_word(pass1_token));
      } break;

      default: {
        //@TODO: assert
        print("token type not added");
      } break;
    }
  }

  return pass2_tokens;
}