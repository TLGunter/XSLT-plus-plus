
#ifdef __INTELLISENSE__
    #include "Debug.cppm"
    #include "CppTypes.cppm"
    #include "Expr.cppm";
    #include <iostream>
    #include <string>
    #include <vector>
#else
    import Debug;
    import CppTypes;
    import Expr;
    import <iostream>;
    import <string>;
    import <vector>;
#endif


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


export std::vector<Token> xsltpp_lex(const std::string &xsltpp_raw) {
    
    std::vector<Token> tokens;

    Token curr_token;
    char  prev_char;

    for(const char c : xsltpp_raw) {

        if(c < 0) break; //@TODO: investigate if we lose the last word
        
        switch(curr_token.type) {
            
            case TokenType::NONE: {

                if(c == '`') {

                    curr_token.type = TokenType::RAW_XSLT;
                    curr_token.name += c;

                } else if(c == '/') {

                    curr_token.type = (prev_char == '/')  ? TokenType::COMMENT
                                                          : TokenType::NONE;

                } else if(is_whitespace(c)) {

                    break;

                } else if(c != '/') {

                    curr_token.type = TokenType::WORD;
                    curr_token.name += c;
                
                } else breakp();

                break;
            }
            
            case TokenType::RAW_XSLT: {

                curr_token.name += c;

                if(c == '`') {

                    tokens.push_back(curr_token);
                    curr_token.reset();

                }
                break;
            }

            case TokenType::COMMENT: {

                if(c == '\n') {

                    curr_token.reset();
                }
                break;
            }

            case TokenType::WORD: {

                if(is_whitespace(c)) {

                    tokens.push_back(curr_token);
                    curr_token.reset();

                } else {

                    curr_token.name += c;
                }
                break;
            }

            default: {

                breakp();
                break;
            }
        }

        prev_char = c;
    }

    return tokens;
}


bool expected_type(TokenType type) {

    auto it = expected.find(type);
    if(it != expected.end()) return true;
    
    it = expected.find(TokenType::NONE);
    return (it == expected.end()) ? false : true;
}

export std::string xsltpp_parse(std::vector<Token> tokens) {

    for(const Token &token : tokens) {

        switch(token.type) {

            case TokenType::RAW_XSLT: {

                break;
            }

            case TokenType::WORD: {

                auto token_it = token_map.find(token.name);

                if(token_it == token_map.end()) {

                    print_fmt("invalid token\n");
                    breakp();
                    break;
                }

                Intrinsic &const curr_token = token_it->second;

                const bool is_expected = expected_type(curr_token.type);
                if(is_expected == false) {

                    print_fmt("expected a different type, was given {}\n", (i32)curr_token.type);
                    breakp();
                    break;
                }

                (curr_token.func)();
                break;
            }

            default: {
                breakp();
                break;
            }
        }
        
    }

    return "";
}