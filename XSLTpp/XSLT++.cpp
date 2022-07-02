
#ifdef __INTELLISENSE__
    #include "CppTypes.cppm"
    #include "Debug.cppm"
    #include "Expr.cppm"
    #include "Utils.cppm"
    #include <string>
    #include <vector>
#else
    import CppTypes;
    import Debug;
    import Expr;
    import Utils;
    import <string>;
    import <vector>;
#endif



int main() {

    using namespace Debug;

    print("G'day Australia!\n\n");

    // const std::string xslt_raw = file_to_str("test\\super_alignment_report_csv_V4.xslt");
    // print_fmt("{}", xslt_raw.c_str());

    std::string xslt_out;
    {
        std::vector<Token> xsltpp_tokens;
        {
            const std::string xsltpp_raw = file_to_str("test\\example.xslt++");

            xsltpp_tokens = xsltpp_lex(xsltpp_raw);
        }

        //for(auto word : xsltpp_tokens) print_fmt("{}: {}\n", (i32)word.type, word.name);

        xslt_out = xsltpp_parse(xsltpp_tokens);
    }



    return 0;
}