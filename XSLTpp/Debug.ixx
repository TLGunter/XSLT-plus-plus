
import <cstdio>;
import <string_view>;
import <format>;

export module Debug;

namespace Debug {

    export void assert_if(bool exp, std::string_view text, bool kill);

    export void breakp(bool exp);
    export void breakp();

    export void print(const std::string_view text);
    export template<typename... Args> void print_fmt(std::string_view fmt_str, Args&&... args);

    export void debug(const std::string_view text);
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

    export void print(const std::string_view text) {

        printf(text.data());
    }

    export template<typename... Args> void print_fmt(std::string_view fmt_str, Args&&... args) {

        printf(std::vformat(fmt_str, std::make_format_args(args...)).c_str());
    }

    export void debug(const std::string_view text) {

    #ifdef _DEBUG
        printf(text.data());
    #endif
    }

    export template<typename... Args> void debug_fmt(std::string_view fmt_str, Args&&... args) {

    #ifdef _DEBUG
        printf(std::vformat(fmt_str, std::make_format_args(args...)).c_str());
    #endif
    }
}