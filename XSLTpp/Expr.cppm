
#if __INTELLISENSE__
    #include "CppTypes.cppm"
    #include <string>
    #include <map>
    #include <vector>
#else
    import CppTypes;
    import <string>;
    import <map>;
    import <vector>;
#endif


export module Expr;



export enum class TokenType {
    NONE,
    RAW_XSLT,
    COMMENT,
    WORD,
};



// SYN: reserved syntax
// FUN: xslt++ function
// NAT: mimic native xslt
enum class IntrinsicType {
    NONE,

    SYN_BEGIN,
    SYN_START_DEFINE,
    SYN_END_DEFINE,
    SYN_LEFT_PAREN,
    SYN_RIGHT_PAREN,
    SYN_FINISH,

    FUN_BEGIN,
    FUN_CONCAT,
    FUN_STRINGIFY,
    FUN_TO_UPPER,
    FUN_TO_LOWER,
    FUN_TO_PROPER,
    FUN_TO_CAMEL,
    FUN_FINISH,

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
};
constexpr I32 SYN_SIZE        = (I32)IntrinsicType::SYN_FINISH - (I32)IntrinsicType::SYN_BEGIN;
constexpr I32 FUN_SIZE        = (I32)IntrinsicType::FUN_FINISH - (I32)IntrinsicType::FUN_BEGIN;
constexpr I32 NAT_SIZE        = (I32)IntrinsicType::NAT_FINISH - (I32)IntrinsicType::NAT_BEGIN;
constexpr I32 INTRINSICS_SIZE = SYN_SIZE + FUN_SIZE + NAT_SIZE;


const std::string TOK_START_DEFINE  = "@@";
const std::string TOK_END_DEFINE    = "@";
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




enum class StackObjectType {
    NONE,
    ANY,
    RAW_XSLT,
    INTRINSIC,
    CUSTOM,
};

struct StackObject {
    StackObjectType type;
    std::string     name;
};

std::vector<StackObject> stack;




StackObjectType          expected;
IntrinsicType            last_intrinsic = IntrinsicType::NONE;
bool                     define_context = false;

#pragma region Functions

void syn_start_define() {

    // Need a generic token list not a split one between intrinsics and custom shit

    if(define_context == false && 
       last_intrinsic != IntrinsicType::SYN_END_DEFINE) {

        expected = StackObjectType::CUSTOM;

        define_context = true;
        last_intrinsic = IntrinsicType::SYN_START_DEFINE;
    }
}

void syn_end_define() {

}

void syn_left_paren() {

}

void syn_right_paren() {

}

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

#pragma endregion




struct Intrinsic {
    IntrinsicType type;
    void        (*func)();
};

export std::map<std::string, Intrinsic> intrinsics = {
    { TOK_START_DEFINE , { IntrinsicType::SYN_START_DEFINE , syn_start_define  } },
    { TOK_END_DEFINE   , { IntrinsicType::SYN_END_DEFINE   , syn_end_define    } },
    { TOK_LEFT_PAREN   , { IntrinsicType::SYN_LEFT_PAREN   , syn_left_paren    } },
    { TOK_RIGHT_PAREN  , { IntrinsicType::SYN_RIGHT_PAREN  , syn_right_paren   } },

    { TOK_CONCAT       , { IntrinsicType::FUN_CONCAT       , fun_concat        } },
    { TOK_STRINGIFY    , { IntrinsicType::FUN_STRINGIFY    , fun_stringify     } },
    { TOK_TO_UPPER     , { IntrinsicType::FUN_TO_UPPER     , fun_to_upper      } },
    { TOK_TO_LOWER     , { IntrinsicType::FUN_TO_LOWER     , fun_to_lower      } },
    { TOK_TO_PROPER    , { IntrinsicType::FUN_TO_PROPER    , fun_to_proper     } },
    { TOK_TO_CAMEL     , { IntrinsicType::FUN_TO_CAMEL     , fun_to_camel      } },

    { TOK_END          , { IntrinsicType::NAT_END          , nat_end           } },
    { TOK_HEAD         , { IntrinsicType::NAT_HEAD         , nat_head          } },
    { TOK_COMMENT      , { IntrinsicType::NAT_COMMENT      , nat_comment       } },
    { TOK_OUTPUT       , { IntrinsicType::NAT_OUTPUT       , nat_output        } },
    { TOK_INCLUDE      , { IntrinsicType::NAT_INCLUDE      , nat_include       } },
    { TOK_VALUE_OF     , { IntrinsicType::NAT_VALUE_OF     , nat_value_of      } },
    { TOK_PARAM        , { IntrinsicType::NAT_PARAM        , nat_param         } },
    { TOK_WITH_PARAM   , { IntrinsicType::NAT_WITH_PARAM   , nat_with_param    } },      
    { TOK_STYLESHEET   , { IntrinsicType::NAT_STYLESHEET   , nat_stylesheet    } },
    { TOK_VARIABLE     , { IntrinsicType::NAT_VARIABLE     , nat_variable      } },
    { TOK_TEXT         , { IntrinsicType::NAT_TEXT         , nat_text          } },
    { TOK_TEMPLATE     , { IntrinsicType::NAT_TEMPLATE     , nat_template      } },
    { TOK_CALL_TEMPLATE, { IntrinsicType::NAT_CALL_TEMPLATE, nat_call_template } },
};
static_assert(SYN_SIZE        == 5 );
static_assert(FUN_SIZE        == 7 );
static_assert(NAT_SIZE        == 14);
static_assert(INTRINSICS_SIZE == 26);