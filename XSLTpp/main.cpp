
import CppTypes;
import Debug;
import Expr;
import Utils;

import <string>;
import <string_view>;
import <vector>;



int main() {

    using namespace Debug;

    std::string xsltpp_raw = file_to_str("test\\example.xslt++");

    //print(xsltpp_raw);

    std::vector<Pass1_Token> xsltpp_tokens = pass1_tokenise(xsltpp_raw);

    return 0;
}