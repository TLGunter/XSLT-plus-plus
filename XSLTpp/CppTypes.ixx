export module CppTypes;

export typedef char               i8;
export typedef short              i16;
export typedef long               i32;
export typedef long long          i64;

export typedef unsigned char      u8;
export typedef unsigned short     u16;
export typedef unsigned long      u32;
export typedef unsigned long long u64;

export typedef float              f32;
export typedef double             f64;

export using any64 = i64;

export template<typename P> inline any64 in64 (P     in ) { return *(any64*)&in; }
export template<typename R> inline R     out64(any64 out) { return *(R*)&out;    }

export extern constinit u64 ADR_SIZE = sizeof(void *);




//import <string>;
//import <string_view>;
//import <map>;
//import <vector>;
//import <set>;
//
//export                                  using String      = std::string;
//export                                  using String_View = std::string_view;
//export template<typename K, typename V> using Map         = std::map<K, V>;
//export template<typename T>             using Vector      = std::vector<T>;
//export template<typename T>             using Set         = std::set<T>;