
#if __INTELLISENSE__
    #include <cstdio>
    #include <string>
    #include <string_view>
    #include <format>
#else
    import <cstdio>;
    import <string>;
    import <string_view>;
    import <format>;
#endif

export module Debug;

namespace Debug {

    export void assert_if(bool exp, std::string_view text, bool kill);
    //export void assert_str(bool exp, char            *text);
    export void breakp(bool exp);
    export void breakp();
    export void print (const std::string &text);
    export void print (const char        *text);
    export template<typename... Args> void print_fmt(std::string_view fmt_str, Args&&... args);
    export void debug (const std::string &text);
    export void debug (const char        *text);
    export template<typename... Args> void debug_fmt(std::string_view fmt_str, Args&&... args);



    export void assert_if(bool exp, std::string_view text, bool kill = false) {
    #ifdef _DEBUG
        if(exp == true) {

            printf("ASSERTION: %s", text.data());

            if(kill == true) {
            
                getchar();
                exit(-1);
            
            } else {

                breakp();
            }
        }
    #endif
    }

    export void breakp(bool exp) {
    #ifdef _DEBUG
        if(exp == true) __debugbreak();
    #endif
    }

    export void breakp() {
    #ifdef _DEBUG
        __debugbreak();
    #endif
    }

    export void print(const std::string &text) {
        printf(text.c_str());
    }

    export void print(const char *text) {
        printf(text);
    }

    export template<typename... Args> void print_fmt(std::string_view fmt_str, Args&&... args) {
        printf(std::vformat(fmt_str, std::make_format_args(args...)).c_str());
    }

    export void debug(const std::string &text) {
    #ifdef _DEBUG
        printf(text.c_str());
    #endif
    }

    export void debug(const char *text) {
    #ifdef _DEBUG
        printf(text);
    #endif
    }

    export template<typename... Args> void debug_fmt(std::string_view fmt_str, Args&&... args) {
    #ifdef _DEBUG
        printf(std::vformat(fmt_str, std::make_format_args(args...)).c_str());
    #endif
    }
}