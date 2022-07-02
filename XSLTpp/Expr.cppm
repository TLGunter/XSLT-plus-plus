
#if __INTELLISENSE__
    #include "CppTypes.cppm"
    #include "Debug.cppm"
    #include <string>
    #include <map>
    #include <vector>
    #include <set>
#else
    import CppTypes;
    import Debug;
    import <string>;
    import <map>;
    import <vector>;
    import <set>;
#endif


export module Expr;

using namespace Debug;

export enum class TokenType {
    //Primitive types
    NONE,
    COMMENT,
    WORD,
    RAW_XSLT,

    // Custom
    MACRO,

    // SYN: reserved syntax
    SYN_BEGIN,
    SYN_START_DEFINE,
    SYN_END_DEFINE,
    SYN_LEFT_PAREN,
    SYN_RIGHT_PAREN,
    SYN_FINISH,

    // FUN: xslt++ function
    FUN_BEGIN,
    FUN_CONCAT,
    FUN_STRINGIFY,
    FUN_TO_UPPER,
    FUN_TO_LOWER,
    FUN_TO_PROPER,
    FUN_TO_CAMEL,
    FUN_FINISH,

    // NAT: mimic native xslt
    NAT_BEGIN,
    NAT_END,
    NAT_HEAD,
    NAT_COMMENT,
    NAT_OUTPUT,
    NAT_INCLUDE,
    NAT_VALUE_OF,
    NAT_PARAM,
    NAT_WITH_PARAM,
    NAT_STYLESHEET,
    NAT_VARIABLE,
    NAT_TEXT,
    NAT_TEMPLATE,
    NAT_CALL_TEMPLATE,
    NAT_FINISH,

    SIZE
};
constexpr I32 SYN_SIZE        = (I32)TokenType::SYN_FINISH - (I32)TokenType::SYN_BEGIN;
constexpr I32 FUN_SIZE        = (I32)TokenType::FUN_FINISH - (I32)TokenType::FUN_BEGIN;
constexpr I32 NAT_SIZE        = (I32)TokenType::NAT_FINISH - (I32)TokenType::NAT_BEGIN;
constexpr I32 INTRINSICS_SIZE = SYN_SIZE + FUN_SIZE + NAT_SIZE;
constexpr I32 TOKENS_SIZE     = (I32)TokenType::SIZE;


const std::string TOK_START_DEFINE  = "#define";
const std::string TOK_END_DEFINE    = "#end";
const std::string TOK_LEFT_PAREN    = "(";
const std::string TOK_RIGHT_PAREN   = ")";
static_assert(SYN_SIZE == 5 );

const std::string TOK_CONCAT        = "##";
const std::string TOK_STRINGIFY     = "#";
const std::string TOK_TO_UPPER      = "to_upper";
const std::string TOK_TO_LOWER      = "to_lower";
const std::string TOK_TO_PROPER     = "to_proper";
const std::string TOK_TO_CAMEL      = "to_camel";
static_assert(FUN_SIZE == 7 );

const std::string TOK_END           = "end";
const std::string TOK_HEAD          = "head";
const std::string TOK_COMMENT       = "comment";
const std::string TOK_OUTPUT        = "output";
const std::string TOK_INCLUDE       = "include";
const std::string TOK_VALUE_OF      = "value-of";
const std::string TOK_PARAM         = "param";
const std::string TOK_WITH_PARAM    = "with-param";
const std::string TOK_STYLESHEET    = "stylesheet";
const std::string TOK_VARIABLE      = "variable";
const std::string TOK_TEXT          = "text";
const std::string TOK_TEMPLATE      = "template";
const std::string TOK_CALL_TEMPLATE = "call-template";
static_assert(NAT_SIZE == 14);

static_assert(INTRINSICS_SIZE == 26);




export struct Token {
    std::string name;
    TokenType   type;

    void reset() {
        name = "";
        type = TokenType::NONE;
    }
};

export std::vector<Token>  stack;
export std::set<TokenType> expected;
export TokenType           last_token = TokenType::NONE;

struct Context {
    bool in_define = false;
    bool in_params = false;
} ctx;

#pragma region Functions

void syn_start_define() {

    if(ctx.in_define == true) {

        print("No `#define` allowed in another `#define`");
        breakp();

    } else {

        expected = { TokenType::WORD };
        
        ctx.in_define = true;
        last_token    = TokenType::SYN_START_DEFINE;
    }
}

void syn_end_define() {

}

void syn_left_paren() {

}

void syn_right_paren() {

}
static_assert(SYN_SIZE == 5 );

void fun_concat() {

}

void fun_stringify() {

}

void fun_to_upper() {

}

void fun_to_lower() {

}

void fun_to_proper() {

}

void fun_to_camel() {

}
static_assert(FUN_SIZE == 7 );

void nat_end() {

}

void nat_head() {

}

void nat_comment() {

}

void nat_output() {

}

void nat_include() {

}

void nat_value_of() {

}

void nat_param() {

}

void nat_with_param() {

}

void nat_stylesheet() {

}

void nat_variable() {

}

void nat_text() {

}

void nat_template() {

}

void nat_call_template() {

}
static_assert(NAT_SIZE == 14);

#pragma endregion




export struct Intrinsic {
    TokenType type;
    void    (*func)();
};

export std::map<std::string, Intrinsic> token_map = {

    { TOK_START_DEFINE , { TokenType::SYN_START_DEFINE , syn_start_define  } },
    { TOK_END_DEFINE   , { TokenType::SYN_END_DEFINE   , syn_end_define    } },
    { TOK_LEFT_PAREN   , { TokenType::SYN_LEFT_PAREN   , syn_left_paren    } },
    { TOK_RIGHT_PAREN  , { TokenType::SYN_RIGHT_PAREN  , syn_right_paren   } },

    { TOK_CONCAT       , { TokenType::FUN_CONCAT       , fun_concat        } },
    { TOK_STRINGIFY    , { TokenType::FUN_STRINGIFY    , fun_stringify     } },
    { TOK_TO_UPPER     , { TokenType::FUN_TO_UPPER     , fun_to_upper      } },
    { TOK_TO_LOWER     , { TokenType::FUN_TO_LOWER     , fun_to_lower      } },
    { TOK_TO_PROPER    , { TokenType::FUN_TO_PROPER    , fun_to_proper     } },
    { TOK_TO_CAMEL     , { TokenType::FUN_TO_CAMEL     , fun_to_camel      } },

    { TOK_END          , { TokenType::NAT_END          , nat_end           } },
    { TOK_HEAD         , { TokenType::NAT_HEAD         , nat_head          } },
    { TOK_COMMENT      , { TokenType::NAT_COMMENT      , nat_comment       } },
    { TOK_OUTPUT       , { TokenType::NAT_OUTPUT       , nat_output        } },
    { TOK_INCLUDE      , { TokenType::NAT_INCLUDE      , nat_include       } },
    { TOK_VALUE_OF     , { TokenType::NAT_VALUE_OF     , nat_value_of      } },
    { TOK_PARAM        , { TokenType::NAT_PARAM        , nat_param         } },
    { TOK_WITH_PARAM   , { TokenType::NAT_WITH_PARAM   , nat_with_param    } },      
    { TOK_STYLESHEET   , { TokenType::NAT_STYLESHEET   , nat_stylesheet    } },
    { TOK_VARIABLE     , { TokenType::NAT_VARIABLE     , nat_variable      } },
    { TOK_TEXT         , { TokenType::NAT_TEXT         , nat_text          } },
    { TOK_TEMPLATE     , { TokenType::NAT_TEMPLATE     , nat_template      } },
    { TOK_CALL_TEMPLATE, { TokenType::NAT_CALL_TEMPLATE, nat_call_template } },
};
static_assert(SYN_SIZE        == 5 );
static_assert(FUN_SIZE        == 7 );
static_assert(NAT_SIZE        == 14);
static_assert(INTRINSICS_SIZE == 26);
static_assert(TOKENS_SIZE     == 34);