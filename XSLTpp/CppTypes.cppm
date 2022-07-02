export module CppTypes;

export typedef unsigned char            u8;
export typedef const unsigned char      U8;
export typedef char                     i8;
export typedef const char               I8;

export typedef unsigned short           u16;
export typedef const unsigned short     U16;
export typedef short                    i16;
export typedef const short              I16;

export typedef unsigned long            u32;
export typedef const unsigned long      U32;
export typedef long                     i32;
export typedef const long               I32;

export typedef unsigned long long       u64;
export typedef const unsigned long long U64;
export typedef long long                i64;
export typedef const long long          I64;

export typedef float                    f32;
export typedef const float              F32;

export typedef double                   f64;
export typedef const double             F64;

export using any64 = i64;

export template<typename P> inline any64 in64 (P     in ) { return *(any64*)&in; }
export template<typename R> inline R     out64(any64 out) { return *(R*)&out;    }