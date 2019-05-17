From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH v8 babeltrace 1/4] Fix: bitfield: shift
 undefined/implementation defined behaviors
Date: Fri, 17 May 2019 16:44:21 -0400
Message-ID: <CA+jJMxswGtHLCF2H6_gTPt-SRheYUbhv7WYkbHC6nBYfPMSzAg__38820.584111248$1558125962$gmane$org@mail.gmail.com>
References: <20190516205848.20409-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1827548165829402597=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 455Kzg3LySz11TH
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2019 16:45:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 74B271E3BC3
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2019 16:45:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id o8G9peeEdM8a for <lttng-dev@lists.lttng.org>;
 Fri, 17 May 2019 16:45:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A44E71E3BAD
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2019 16:45:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id X4B8-TFaNmOK for <lttng-dev@lists.lttng.org>;
 Fri, 17 May 2019 16:45:00 -0400 (EDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by mail.efficios.com (Postfix) with ESMTPSA id D85A81E3B93
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2019 16:44:59 -0400 (EDT)
Received: by mail-lf1-f49.google.com with SMTP id y13so6225231lfh.9
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2019 13:44:59 -0700 (PDT)
In-Reply-To: <20190516205848.20409-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Simon Marchi <simon.marchi@efficios.com>, Jeremie Galarneau <jgalar@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1827548165829402597==
Content-Type: multipart/alternative; boundary="000000000000ae95a105891b7444"

--000000000000ae95a105891b7444
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged in master and stable-2.0.
The first patch (the fix) was back-ported to stable-1.5.

Anyone interested in the discussion that lead to v8, see the following
gerrit changes:
https://review.lttng.org/c/babeltrace/+/1311
https://review.lttng.org/c/babeltrace/+/1305/4
https://review.lttng.org/c/babeltrace/+/1307/4
https://review.lttng.org/c/babeltrace/+/1318/1

Thanks!
J=C3=A9r=C3=A9mie




On Thu, 16 May 2019 at 16:58, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> bitfield.h uses the left shift operator with a left operand which
> may be negative. The C99 standard states that shifting a negative
> value is undefined.
>
> When building with -Wshift-negative-value, we get this gcc warning:
>
> In file included from
> /home/smarchi/src/babeltrace/include/babeltrace/ctfser-internal.h:44:0,
>                  from /home/smarchi/src/babeltrace/ctfser/ctfser.c:42:
> /home/smarchi/src/babeltrace/include/babeltrace/ctfser-internal.h: In
> function =E2=80=98bt_ctfser_write_unsigned_int=E2=80=99:
> /home/smarchi/src/babeltrace/include/babeltrace/bitfield-internal.h:116:2=
4:
> error: left shift of negative value [-Werror=3Dshift-negative-value]
>    mask =3D ~((~(type) 0) << (__start % ts));  \
>                         ^
> /home/smarchi/src/babeltrace/include/babeltrace/bitfield-internal.h:222:2=
:
> note: in expansion of macro =E2=80=98_bt_bitfield_write_le=E2=80=99
>   _bt_bitfield_write_le(ptr, type, _start, _length, _v)
>   ^~~~~~~~~~~~~~~~~~~~~
> /home/smarchi/src/babeltrace/include/babeltrace/ctfser-internal.h:418:3:
> note: in expansion of macro =E2=80=98bt_bitfield_write_le=E2=80=99
>    bt_bitfield_write_le(mmap_align_addr(ctfser->base_mma) +
>    ^~~~~~~~~~~~~~~~~~~~
>
> This boils down to the fact that the expression ~((uint8_t)0) has type
> "signed int", which is used as an operand of the left shift.  This is due
> to the integer promotion rules of C99 (6.3.3.1):
>
>     If an int can represent all values of the original type, the value is
>     converted to an int; otherwise, it is converted to an unsigned int.
>     These are called the integer promotions. All other types are unchange=
d
>     by the integer promotions.
>
> We also need to cast the result explicitly into the left hand
> side type to deal with:
>
> warning: large integer implicitly truncated to unsigned type [-Woverflow]
>
> The C99 standard states that a right shift has implementation-defined
> behavior when shifting a signed negative value. Add a preprocessor check
> that the compiler provides the expected behavior, else provide an
> alternative implementation which guarantees the intended behavior.
>
> A preprocessor check is also added to ensure that the compiler
> representation for signed values is two's complement, which is expected
> by this header.
>
> Document that this header strictly respects the C99 standard, with
> the exception of its use of __typeof__.
>
> Adapt use of _bt_piecewise_lshift in plugins/text/pretty/print.c
> to the new API.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Acked-by: Simon Marchi <simon.marchi@efficios.com>
> Change-Id: I47d2655cfe671baf0fc18813883adf7ce11dfd6a
> ---
> Changes since v1:
> - Generate compile-time error if the type argument passed to
>   _bt_unsigned_cast() is larger than sizeof(uint64_t), this
>   allows removing _bt_check_max_64bit,
> - Introduce _br_fill_mask, which replaces _bt_bitwise_not,
> - Clarify _bt_unsigned_cast comment,
> - Expand explanation of the issue within the patch commit message.
>
> Changes since v2:
> - Fix unwanted sign extension when generating masks,
> - Introduce macro helpers to clarify code:
>   - _bt_cast_value_to_unsigned()
>   - _bt_cast_value_to_unsigned_type(),
>   - _bt_make_mask_complement(),
>   - _bt_make_mask().
>
> Changes since v3:
> - Fix additional left shift undefined behavior. Identified with
>   -fsanitize=3Dundefined.
> - Create fallback for right shift implementation-defined behavior
>   if the behavior is found not to be as intended. Detect the behavior
>   with a preprocessor check.
> - Ensure that the compiler represents signed types with two's complement
>   with a preprocessor check.
> - Add _bt_rshift() and _bt_lshift() shift helpers to take care of
>   C99's undefined behaviors related to shifting signed types.
> - Remove statement-expressions to allow building with -std=3Dc99.
> - Use __typeof__ instead of typeof to allow building with -std=3Dc99.
>   Strictly speaking, the use of __typeof__ is specific to the compiler.
>   Therefore, porting to a strict ansi C compiler would require removing
>   those __typeof__.
> - Remove use of gnu extension: replace (a ? : b) expressions by (a ? a :
>   b) to please compiling with -std=3Dc99 -Wpedantic.
>
> Changes since v4:
> - Document strict C89 compliance, except for use of __typeof__
>   compiler-specific extension.
> - Adapt use of _bt_piecewise_lshift in plugins/text/pretty/print.c
>   to the new API.
>
> Changes since v5:
> - Bump standard compliance from C89 to C99, because we use
>   C99 types.h.
>
> Changes since v6:
> - Fix wrong use of _bt_make_mask() in _bt_bitfield_write_be. Should
>   be _bt_make_mask_complement. Caught by testing on powerpc.
>
> Changes since v7:
> - Style fixes.
> ---
>  include/babeltrace/bitfield-internal.h | 312
> ++++++++++++++++++++++-----------
>  plugins/text/pretty/print.c            |   4 +-
>  2 files changed, 208 insertions(+), 108 deletions(-)
>
> diff --git a/include/babeltrace/bitfield-internal.h
> b/include/babeltrace/bitfield-internal.h
> index c5d5eccd..5ecde05e 100644
> --- a/include/babeltrace/bitfield-internal.h
> +++ b/include/babeltrace/bitfield-internal.h
> @@ -2,7 +2,7 @@
>  #define _BABELTRACE_BITFIELD_H
>
>  /*
> - * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright 2010-2019 - Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com>
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining
> a copy
>   * of this software and associated documentation files (the "Software"),
> to deal
> @@ -27,49 +27,157 @@
>  #include <babeltrace/compat/limits-internal.h> /* C99 5.2.4.2 Numerical
> limits */
>  #include <babeltrace/endian-internal.h>        /* Non-standard
> BIG_ENDIAN, LITTLE_ENDIAN, BYTE_ORDER */
>
> -/* We can't shift a int from 32 bit, >> 32 and << 32 on int is undefined
> */
> -#define _bt_piecewise_rshift(_v, _shift)                               \
> -({                                                                     \
> -       typeof(_v) ___v =3D (_v);                                        =
 \
> -       typeof(_shift) ___shift =3D (_shift);                            =
 \
> -       unsigned long sb =3D (___shift) / (sizeof(___v) * CHAR_BIT - 1); =
 \
> -       unsigned long final =3D (___shift) % (sizeof(___v) * CHAR_BIT - 1=
); \
> -                                                                       \
> -       for (; sb; sb--)                                                \
> -               ___v >>=3D sizeof(___v) * CHAR_BIT - 1;                  =
 \
> -       ___v >>=3D final;                                                =
 \
> -})
> -
> -#define _bt_piecewise_lshift(_v, _shift)                               \
> -({                                                                     \
> -       typeof(_v) ___v =3D (_v);                                        =
 \
> -       typeof(_shift) ___shift =3D (_shift);                            =
 \
> -       unsigned long sb =3D (___shift) / (sizeof(___v) * CHAR_BIT - 1); =
 \
> -       unsigned long final =3D (___shift) % (sizeof(___v) * CHAR_BIT - 1=
); \
> -                                                                       \
> -       for (; sb; sb--)                                                \
> -               ___v <<=3D sizeof(___v) * CHAR_BIT - 1;                  =
 \
> -       ___v <<=3D final;                                                =
 \
> -})
> +/*
> + * This header strictly follows the C99 standard, except for use of the
> + * compiler-specific __typeof__.
> + */
> +
> +/*
> + * This bitfield header requires the compiler representation of signed
> + * integers to be two's complement.
> + */
> +#if (-1 !=3D ~0)
> +#error "bitfield.h requires the compiler representation of signed
> integers to be two's complement."
> +#endif
>
>  #define _bt_is_signed_type(type)       ((type) -1 < (type) 0)
>
>  /*
> - * NOTE: The cast to (uint64_t) below ensures that we're not casting a
> - * negative value, which is undefined in C. However, this limits the
> - * maximum type size of `type` and `v` to 64-bit. The
> - * _bt_check_max_64bit() is used to check that the users of this header
> - * do not use types with a size greater than 64-bit.
> + * Produce a build-time error if the condition `cond` is non-zero.
> + * Evaluates as a size_t expression.
> + */
> +#define _BT_BUILD_ASSERT(cond)                                 \
> +       sizeof(struct { int f:(2 * !!(cond) - 1); })
> +
> +/*
> + * Cast value `v` to an unsigned integer of the same size as `v`.
> + */
> +#define _bt_cast_value_to_unsigned(v)                                  \
> +       (sizeof(v) =3D=3D sizeof(uint8_t) ? (uint8_t) (v) :              =
   \
> +       sizeof(v) =3D=3D sizeof(uint16_t) ? (uint16_t) (v) :             =
   \
> +       sizeof(v) =3D=3D sizeof(uint32_t) ? (uint32_t) (v) :             =
   \
> +       sizeof(v) =3D=3D sizeof(uint64_t) ? (uint64_t) (v) :             =
   \
> +       _BT_BUILD_ASSERT(sizeof(v) <=3D sizeof(uint64_t)))
> +
> +/*
> + * Cast value `v` to an unsigned integer type of the size of type `type`
> + * *without* sign-extension.
> + *
> + * The unsigned cast ensures that we're not shifting a negative value,
> + * which is undefined in C. However, this limits the maximum type size
> + * of `type` to 64-bit. Generate a compile-time error if the size of
> + * `type` is larger than 64-bit.
> + */
> +#define _bt_cast_value_to_unsigned_type(type, v)                       \
> +       (sizeof(type) =3D=3D sizeof(uint8_t) ?                           =
   \
> +               (uint8_t) _bt_cast_value_to_unsigned(v) :               \
> +       sizeof(type) =3D=3D sizeof(uint16_t) ?                           =
   \
> +               (uint16_t) _bt_cast_value_to_unsigned(v) :              \
> +       sizeof(type) =3D=3D sizeof(uint32_t) ?                           =
   \
> +               (uint32_t) _bt_cast_value_to_unsigned(v) :              \
> +       sizeof(type) =3D=3D sizeof(uint64_t) ?                           =
   \
> +               (uint64_t) _bt_cast_value_to_unsigned(v) :              \
> +       _BT_BUILD_ASSERT(sizeof(v) <=3D sizeof(uint64_t)))
> +
> +/*
> + * _bt_fill_mask evaluates to a "type" integer with all bits set.
> + */
> +#define _bt_fill_mask(type)    ((type) ~(type) 0)
> +
> +/*
> + * Left shift a value `v` of `shift` bits.
> + *
> + * The type of `v` can be signed or unsigned integer.
> + * The value of `shift` must be less than the size of `v` (in bits),
> + * otherwise the behavior is undefined.
> + * Evaluates to the result of the shift operation.
> + *
> + * According to the C99 standard, left shift of a left hand-side signed
> + * type is undefined if it has a negative value or if the result cannot
> + * be represented in the result type. This bitfield header discards the
> + * bits that are left-shifted beyond the result type representation,
> + * which is the behavior of an unsigned type left shift operation.
> + * Therefore, always perform left shift on an unsigned type.
> + *
> + * This macro should not be used if `shift` can be greater or equal than
> + * the bitwidth of `v`. See `_bt_safe_lshift`.
> + */
> +#define _bt_lshift(v, shift)                                           \
> +       ((__typeof__(v)) (_bt_cast_value_to_unsigned(v) << (shift)))
> +
> +/*
> + * Generate a mask of type `type` with the `length` least significant bi=
ts
> + * cleared, and the most significant bits set.
>   */
> -#define _bt_unsigned_cast(type, v)                                     \
> -({                                                                     \
> -       (sizeof(v) < sizeof(type)) ?                                    \
> -               ((type) (v)) & ((type) (~(~(uint64_t) 0 << (sizeof(v) *
> CHAR_BIT)))) : \
> -               (type) (v);                                             \
> -})
> +#define _bt_make_mask_complement(type, length)                         \
> +       _bt_lshift(_bt_fill_mask(type), length)
>
> -#define _bt_check_max_64bit(type)                                      \
> -       char _max_64bit_assertion[sizeof(type) <=3D sizeof(uint64_t) ? 1 =
:
> -1] __attribute__((unused))
> +/*
> + * Generate a mask of type `type` with the `length` least significant bi=
ts
> + * set, and the most significant bits cleared.
> + */
> +#define _bt_make_mask(type, length)                                    \
> +       ((type) ~_bt_make_mask_complement(type, length))
> +
> +/*
> + * Right shift a value `v` of `shift` bits.
> + *
> + * The type of `v` can be signed or unsigned integer.
> + * The value of `shift` must be less than the size of `v` (in bits),
> + * otherwise the behavior is undefined.
> + * Evaluates to the result of the shift operation.
> + *
> + * According to the C99 standard, right shift of a left hand-side signed
> + * type which has a negative value is implementation defined. This
> + * bitfield header relies on the right shift implementation carrying the
> + * sign bit. If the compiler implementation has a different behavior,
> + * emulate carrying the sign bit.
> + *
> + * This macro should not be used if `shift` can be greater or equal than
> + * the bitwidth of `v`. See `_bt_safe_rshift`.
> + */
> +#if ((-1 >> 1) =3D=3D -1)
> +#define _bt_rshift(v, shift)   ((v) >> (shift))
> +#else
> +#define _bt_rshift(v, shift)                                           \
> +       ((__typeof__(v)) ((_bt_cast_value_to_unsigned(v) >> (shift)) |  \
> +               ((v) < 0 ? _bt_make_mask_complement(__typeof__(v),      \
> +                       sizeof(v) * CHAR_BIT - (shift)) : 0)))
> +#endif
> +
> +/*
> + * Right shift a signed or unsigned integer with `shift` value being an
> + * arbitrary number of bits. `v` is modified by this macro. The shift
> + * is transformed into a sequence of `_nr_partial_shifts` consecutive
> + * shift operations, each of a number of bits smaller than the bitwidth
> + * of `v`, ending with a shift of the number of left over bits.
> + */
> +#define _bt_safe_rshift(v, shift)                                      \
> +do {                                                                   \
> +       unsigned long _nr_partial_shifts =3D (shift) / (sizeof(v) * CHAR_=
BIT
> - 1); \
> +       unsigned long _leftover_bits =3D (shift) % (sizeof(v) * CHAR_BIT =
-
> 1); \
> +                                                                       \
> +       for (; _nr_partial_shifts; _nr_partial_shifts--)                \
> +               (v) =3D _bt_rshift(v, sizeof(v) * CHAR_BIT - 1);         =
 \
> +       (v) =3D _bt_rshift(v, _leftover_bits);                           =
 \
> +} while (0)
> +
> +/*
> + * Left shift a signed or unsigned integer with `shift` value being an
> + * arbitrary number of bits. `v` is modified by this macro. The shift
> + * is transformed into a sequence of `_nr_partial_shifts` consecutive
> + * shift operations, each of a number of bits smaller than the bitwidth
> + * of `v`, ending with a shift of the number of left over bits.
> + */
> +#define _bt_safe_lshift(v, shift)                                      \
> +do {                                                                   \
> +       unsigned long _nr_partial_shifts =3D (shift) / (sizeof(v) * CHAR_=
BIT
> - 1); \
> +       unsigned long _leftover_bits =3D (shift) % (sizeof(v) * CHAR_BIT =
-
> 1); \
> +                                                                       \
> +       for (; _nr_partial_shifts; _nr_partial_shifts--)                \
> +               (v) =3D _bt_lshift(v, sizeof(v) * CHAR_BIT - 1);         =
 \
> +       (v) =3D _bt_lshift(v, _leftover_bits);                           =
 \
> +} while (0)
>
>  /*
>   * bt_bitfield_write - write integer to a bitfield in native endianness
> @@ -91,7 +199,7 @@
>
>  #define _bt_bitfield_write_le(_ptr, type, _start, _length, _v)         \
>  do {                                                                   \
> -       typeof(_v) __v =3D (_v);                                         =
 \
> +       __typeof__(_v) __v =3D (_v);                                     =
 \
>         type *__ptr =3D (void *) (_ptr);                                 =
 \
>         unsigned long __start =3D (_start), __length =3D (_length);      =
   \
>         type mask, cmask;                                               \
> @@ -108,15 +216,15 @@ do {
>                       \
>                                                                         \
>         /* Trim v high bits */                                          \
>         if (__length < sizeof(__v) * CHAR_BIT)                          \
> -               __v &=3D ~((~(typeof(__v)) 0) << __length);              =
 \
> +               __v &=3D _bt_make_mask(__typeof__(__v), __length);       =
 \
>                                                                         \
>         /* We can now append v with a simple "or", shift it piece-wise */=
 \
>         this_unit =3D start_unit;                                        =
 \
>         if (start_unit =3D=3D end_unit - 1) {                            =
   \
> -               mask =3D ~((~(type) 0) << (__start % ts));               =
 \
> +               mask =3D _bt_make_mask(type, __start % ts);              =
 \
>                 if (end % ts)                                           \
> -                       mask |=3D (~(type) 0) << (end % ts);             =
 \
> -               cmask =3D (type) __v << (__start % ts);                  =
 \
> +                       mask |=3D _bt_make_mask_complement(type, end % ts=
); \
> +               cmask =3D _bt_lshift((type) (__v), __start % ts);        =
 \
>                 cmask &=3D ~mask;                                        =
 \
>                 __ptr[this_unit] &=3D mask;                              =
 \
>                 __ptr[this_unit] |=3D cmask;                             =
 \
> @@ -124,22 +232,22 @@ do {
>                       \
>         }                                                               \
>         if (__start % ts) {                                             \
>                 cshift =3D __start % ts;                                 =
 \
> -               mask =3D ~((~(type) 0) << cshift);                       =
 \
> -               cmask =3D (type) __v << cshift;                          =
 \
> +               mask =3D _bt_make_mask(type, cshift);                    =
 \
> +               cmask =3D _bt_lshift((type) (__v), cshift);              =
 \
>                 cmask &=3D ~mask;                                        =
 \
>                 __ptr[this_unit] &=3D mask;                              =
 \
>                 __ptr[this_unit] |=3D cmask;                             =
 \
> -               __v =3D _bt_piecewise_rshift(__v, ts - cshift);          =
 \
> +               _bt_safe_rshift(__v, ts - cshift);                      \
>                 __start +=3D ts - cshift;                                =
 \
>                 this_unit++;                                            \
>         }                                                               \
>         for (; this_unit < end_unit - 1; this_unit++) {                 \
>                 __ptr[this_unit] =3D (type) __v;                         =
 \
> -               __v =3D _bt_piecewise_rshift(__v, ts);                   =
 \
> +               _bt_safe_rshift(__v, ts);                               \
>                 __start +=3D ts;                                         =
 \
>         }                                                               \
>         if (end % ts) {                                                 \
> -               mask =3D (~(type) 0) << (end % ts);                      =
 \
> +               mask =3D _bt_make_mask_complement(type, end % ts);       =
 \
>                 cmask =3D (type) __v;                                    =
 \
>                 cmask &=3D ~mask;                                        =
 \
>                 __ptr[this_unit] &=3D mask;                              =
 \
> @@ -150,7 +258,7 @@ do {
>                       \
>
>  #define _bt_bitfield_write_be(_ptr, type, _start, _length, _v)         \
>  do {                                                                   \
> -       typeof(_v) __v =3D (_v);                                         =
 \
> +       __typeof__(_v) __v =3D (_v);                                     =
 \
>         type *__ptr =3D (void *) (_ptr);                                 =
 \
>         unsigned long __start =3D (_start), __length =3D (_length);      =
   \
>         type mask, cmask;                                               \
> @@ -167,15 +275,15 @@ do {
>                       \
>                                                                         \
>         /* Trim v high bits */                                          \
>         if (__length < sizeof(__v) * CHAR_BIT)                          \
> -               __v &=3D ~((~(typeof(__v)) 0) << __length);              =
 \
> +               __v &=3D _bt_make_mask(__typeof__(__v), __length);       =
 \
>                                                                         \
>         /* We can now append v with a simple "or", shift it piece-wise */=
 \
>         this_unit =3D end_unit - 1;                                      =
 \
>         if (start_unit =3D=3D end_unit - 1) {                            =
   \
> -               mask =3D ~((~(type) 0) << ((ts - (end % ts)) % ts));     =
 \
> +               mask =3D _bt_make_mask(type, (ts - (end % ts)) % ts);    =
 \
>                 if (__start % ts)                                       \
> -                       mask |=3D (~((type) 0)) << (ts - (__start % ts));=
 \
> -               cmask =3D (type) __v << ((ts - (end % ts)) % ts);        =
 \
> +                       mask |=3D _bt_make_mask_complement(type, ts -
> (__start % ts)); \
> +               cmask =3D _bt_lshift((type) (__v), (ts - (end % ts)) % ts=
); \
>                 cmask &=3D ~mask;                                        =
 \
>                 __ptr[this_unit] &=3D mask;                              =
 \
>                 __ptr[this_unit] |=3D cmask;                             =
 \
> @@ -183,22 +291,22 @@ do {
>                       \
>         }                                                               \
>         if (end % ts) {                                                 \
>                 cshift =3D end % ts;                                     =
 \
> -               mask =3D ~((~(type) 0) << (ts - cshift));                =
 \
> -               cmask =3D (type) __v << (ts - cshift);                   =
 \
> +               mask =3D _bt_make_mask(type, ts - cshift);               =
 \
> +               cmask =3D _bt_lshift((type) (__v), ts - cshift);         =
 \
>                 cmask &=3D ~mask;                                        =
 \
>                 __ptr[this_unit] &=3D mask;                              =
 \
>                 __ptr[this_unit] |=3D cmask;                             =
 \
> -               __v =3D _bt_piecewise_rshift(__v, cshift);               =
 \
> +               _bt_safe_rshift(__v, cshift);                           \
>                 end -=3D cshift;                                         =
 \
>                 this_unit--;                                            \
>         }                                                               \
>         for (; (long) this_unit >=3D (long) start_unit + 1; this_unit--) =
{ \
>                 __ptr[this_unit] =3D (type) __v;                         =
 \
> -               __v =3D _bt_piecewise_rshift(__v, ts);                   =
 \
> +               _bt_safe_rshift(__v, ts);                               \
>                 end -=3D ts;                                             =
 \
>         }                                                               \
>         if (__start % ts) {                                             \
> -               mask =3D (~(type) 0) << (ts - (__start % ts));           =
 \
> +               mask =3D _bt_make_mask_complement(type, ts - (__start %
> ts)); \
>                 cmask =3D (type) __v;                                    =
 \
>                 cmask &=3D ~mask;                                        =
 \
>                 __ptr[this_unit] &=3D mask;                              =
 \
> @@ -243,8 +351,8 @@ do {
>                       \
>
>  #define _bt_bitfield_read_le(_ptr, type, _start, _length, _vptr)       \
>  do {                                                                   \
> -       typeof(*(_vptr)) *__vptr =3D (_vptr);                            =
 \
> -       typeof(*__vptr) __v;                                            \
> +       __typeof__(*(_vptr)) *__vptr =3D (_vptr);                        =
 \
> +       __typeof__(*__vptr) __v;                                        \
>         type *__ptr =3D (void *) (_ptr);                                 =
 \
>         unsigned long __start =3D (_start), __length =3D (_length);      =
   \
>         type mask, cmask;                                               \
> @@ -252,10 +360,6 @@ do {
>                      \
>         unsigned long start_unit, end_unit, this_unit;                  \
>         unsigned long end, cshift; /* cshift is "complement shift" */   \
>                                                                         \
> -       { _bt_check_max_64bit(type); }                                  \
> -       { _bt_check_max_64bit(typeof(*_vptr)); }                        \
> -       { _bt_check_max_64bit(typeof(*_ptr)); }                         \
> -                                                                       \
>         if (!__length) {                                                \
>                 *__vptr =3D 0;                                           =
 \
>                 break;                                                  \
> @@ -266,56 +370,56 @@ do {
>                       \
>         end_unit =3D (end + (ts - 1)) / ts;                              =
 \
>                                                                         \
>         this_unit =3D end_unit - 1;                                      =
 \
> -       if (_bt_is_signed_type(typeof(__v))                             \
> -           && (__ptr[this_unit] & ((type) 1 << ((end % ts ? : ts) - 1)))=
)
> \
> -               __v =3D ~(typeof(__v)) 0;                                =
 \
> +       if (_bt_is_signed_type(__typeof__(__v))                         \
> +           && (__ptr[this_unit] & _bt_lshift((type) 1, (end % ts ? end %
> ts : ts) - 1))) \
> +               __v =3D ~(__typeof__(__v)) 0;                            =
 \
>         else                                                            \
>                 __v =3D 0;                                               =
 \
>         if (start_unit =3D=3D end_unit - 1) {                            =
   \
>                 cmask =3D __ptr[this_unit];                              =
 \
> -               cmask >>=3D (__start % ts);                              =
 \
> +               cmask =3D _bt_rshift(cmask, __start % ts);               =
 \
>                 if ((end - __start) % ts) {                             \
> -                       mask =3D ~((~(type) 0) << (end - __start));      =
 \
> +                       mask =3D _bt_make_mask(type, end - __start);     =
 \
>                         cmask &=3D mask;                                 =
 \
>                 }                                                       \
> -               __v =3D _bt_piecewise_lshift(__v, end - __start);        =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), cmask);          =
 \
> +               _bt_safe_lshift(__v, end - __start);                    \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> cmask); \
>                 *__vptr =3D __v;                                         =
 \
>                 break;                                                  \
>         }                                                               \
>         if (end % ts) {                                                 \
>                 cshift =3D end % ts;                                     =
 \
> -               mask =3D ~((~(type) 0) << cshift);                       =
 \
> +               mask =3D _bt_make_mask(type, cshift);                    =
 \
>                 cmask =3D __ptr[this_unit];                              =
 \
>                 cmask &=3D mask;                                         =
 \
> -               __v =3D _bt_piecewise_lshift(__v, cshift);               =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), cmask);          =
 \
> +               _bt_safe_lshift(__v, cshift);                           \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> cmask); \
>                 end -=3D cshift;                                         =
 \
>                 this_unit--;                                            \
>         }                                                               \
>         for (; (long) this_unit >=3D (long) start_unit + 1; this_unit--) =
{ \
> -               __v =3D _bt_piecewise_lshift(__v, ts);                   =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), __ptr[this_unit])=
;\
> +               _bt_safe_lshift(__v, ts);                               \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> __ptr[this_unit]); \
>                 end -=3D ts;                                             =
 \
>         }                                                               \
>         if (__start % ts) {                                             \
> -               mask =3D ~((~(type) 0) << (ts - (__start % ts)));        =
 \
> +               mask =3D _bt_make_mask(type, ts - (__start % ts));       =
 \
>                 cmask =3D __ptr[this_unit];                              =
 \
> -               cmask >>=3D (__start % ts);                              =
 \
> +               cmask =3D _bt_rshift(cmask, __start % ts);               =
 \
>                 cmask &=3D mask;                                         =
 \
> -               __v =3D _bt_piecewise_lshift(__v, ts - (__start % ts));  =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), cmask);          =
 \
> +               _bt_safe_lshift(__v, ts - (__start % ts));              \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> cmask); \
>         } else {                                                        \
> -               __v =3D _bt_piecewise_lshift(__v, ts);                   =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), __ptr[this_unit])=
;\
> +               _bt_safe_lshift(__v, ts);                               \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> __ptr[this_unit]); \
>         }                                                               \
>         *__vptr =3D __v;                                                 =
 \
>  } while (0)
>
>  #define _bt_bitfield_read_be(_ptr, type, _start, _length, _vptr)       \
>  do {                                                                   \
> -       typeof(*(_vptr)) *__vptr =3D (_vptr);                            =
 \
> -       typeof(*__vptr) __v;                                            \
> +       __typeof__(*(_vptr)) *__vptr =3D (_vptr);                        =
 \
> +       __typeof__(*__vptr) __v;                                        \
>         type *__ptr =3D (void *) (_ptr);                                 =
 \
>         unsigned long __start =3D (_start), __length =3D (_length);      =
   \
>         type mask, cmask;                                               \
> @@ -323,10 +427,6 @@ do {
>                      \
>         unsigned long start_unit, end_unit, this_unit;                  \
>         unsigned long end, cshift; /* cshift is "complement shift" */   \
>                                                                         \
> -       { _bt_check_max_64bit(type); }                                  \
> -       { _bt_check_max_64bit(typeof(*_vptr)); }                        \
> -       { _bt_check_max_64bit(typeof(*_ptr)); }                         \
> -                                                                       \
>         if (!__length) {                                                \
>                 *__vptr =3D 0;                                           =
 \
>                 break;                                                  \
> @@ -337,48 +437,48 @@ do {
>                       \
>         end_unit =3D (end + (ts - 1)) / ts;                              =
 \
>                                                                         \
>         this_unit =3D start_unit;                                        =
 \
> -       if (_bt_is_signed_type(typeof(__v))                             \
> -           && (__ptr[this_unit] & ((type) 1 << (ts - (__start % ts) -
> 1)))) \
> -               __v =3D ~(typeof(__v)) 0;                                =
 \
> +       if (_bt_is_signed_type(__typeof__(__v))                         \
> +           && (__ptr[this_unit] & _bt_lshift((type) 1, ts - (__start %
> ts) - 1))) \
> +               __v =3D ~(__typeof__(__v)) 0;                            =
 \
>         else                                                            \
>                 __v =3D 0;                                               =
 \
>         if (start_unit =3D=3D end_unit - 1) {                            =
   \
>                 cmask =3D __ptr[this_unit];                              =
 \
> -               cmask >>=3D (ts - (end % ts)) % ts;                      =
 \
> +               cmask =3D _bt_rshift(cmask, (ts - (end % ts)) % ts);     =
 \
>                 if ((end - __start) % ts) {                             \
> -                       mask =3D ~((~(type) 0) << (end - __start));      =
 \
> +                       mask =3D _bt_make_mask(type, end - __start);     =
 \
>                         cmask &=3D mask;                                 =
 \
>                 }                                                       \
> -               __v =3D _bt_piecewise_lshift(__v, end - __start);        =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), cmask);          =
 \
> +               _bt_safe_lshift(__v, end - __start);            \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> cmask); \
>                 *__vptr =3D __v;                                         =
 \
>                 break;                                                  \
>         }                                                               \
>         if (__start % ts) {                                             \
>                 cshift =3D __start % ts;                                 =
 \
> -               mask =3D ~((~(type) 0) << (ts - cshift));                =
 \
> +               mask =3D _bt_make_mask(type, ts - cshift);               =
 \
>                 cmask =3D __ptr[this_unit];                              =
 \
>                 cmask &=3D mask;                                         =
 \
> -               __v =3D _bt_piecewise_lshift(__v, ts - cshift);          =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), cmask);          =
 \
> +               _bt_safe_lshift(__v, ts - cshift);                      \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> cmask); \
>                 __start +=3D ts - cshift;                                =
 \
>                 this_unit++;                                            \
>         }                                                               \
>         for (; this_unit < end_unit - 1; this_unit++) {                 \
> -               __v =3D _bt_piecewise_lshift(__v, ts);                   =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), __ptr[this_unit])=
;\
> +               _bt_safe_lshift(__v, ts);                               \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> __ptr[this_unit]); \
>                 __start +=3D ts;                                         =
 \
>         }                                                               \
>         if (end % ts) {                                                 \
> -               mask =3D ~((~(type) 0) << (end % ts));                   =
 \
> +               mask =3D _bt_make_mask(type, end % ts);                  =
 \
>                 cmask =3D __ptr[this_unit];                              =
 \
> -               cmask >>=3D ts - (end % ts);                             =
 \
> +               cmask =3D _bt_rshift(cmask, ts - (end % ts));            =
 \
>                 cmask &=3D mask;                                         =
 \
> -               __v =3D _bt_piecewise_lshift(__v, end % ts);             =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), cmask);          =
 \
> +               _bt_safe_lshift(__v, end % ts);                         \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> cmask); \
>         } else {                                                        \
> -               __v =3D _bt_piecewise_lshift(__v, ts);                   =
 \
> -               __v |=3D _bt_unsigned_cast(typeof(__v), __ptr[this_unit])=
;\
> +               _bt_safe_lshift(__v, ts);                               \
> +               __v |=3D _bt_cast_value_to_unsigned_type(__typeof__(__v),
> __ptr[this_unit]); \
>         }                                                               \
>         *__vptr =3D __v;                                                 =
 \
>  } while (0)
> diff --git a/plugins/text/pretty/print.c b/plugins/text/pretty/print.c
> index 95189d5e..c36a6e81 100644
> --- a/plugins/text/pretty/print.c
> +++ b/plugins/text/pretty/print.c
> @@ -546,10 +546,10 @@ int print_integer(struct pretty_component *pretty,
>
>                 len =3D bt_field_class_integer_get_field_value_range(int_=
fc);
>                 g_string_append(pretty->string, "0b");
> -               v.u =3D _bt_piecewise_lshift(v.u, 64 - len);
> +               _bt_safe_lshift(v.u, 64 - len);
>                 for (bitnr =3D 0; bitnr < len; bitnr++) {
>                         g_string_append_printf(pretty->string, "%u", (v.u
> & (1ULL << 63)) ? 1 : 0);
> -                       v.u =3D _bt_piecewise_lshift(v.u, 1);
> +                       _bt_safe_lshift(v.u, 1);
>                 }
>                 break;
>         }
> --
> 2.11.0
>
>

--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000ae95a105891b7444
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj5NZXJnZWQgaW4gbWFzdGVyIGFuZCBzdGFibGUtMi4wLjwv
ZGl2PjxkaXY+VGhlIGZpcnN0IHBhdGNoICh0aGUgZml4KSB3YXMgYmFjay1wb3J0ZWQgdG8gc3Rh
YmxlLTEuNS48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbnlvbmUgaW50ZXJlc3RlZCBp
biB0aGUgZGlzY3Vzc2lvbiB0aGF0IGxlYWQgdG8gdjgsIHNlZSB0aGUgZm9sbG93aW5nIGdlcnJp
dCBjaGFuZ2VzOjxicj48L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9y
Zy9jL2JhYmVsdHJhY2UvKy8xMzExIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9yZXZpZXcubHR0
bmcub3JnL2MvYmFiZWx0cmFjZS8rLzEzMTE8L2E+PC9kaXY+PGRpdj48YSBocmVmPSJodHRwczov
L3Jldmlldy5sdHRuZy5vcmcvYy9iYWJlbHRyYWNlLysvMTMwNS80IiB0YXJnZXQ9Il9ibGFuayI+
aHR0cHM6Ly9yZXZpZXcubHR0bmcub3JnL2MvYmFiZWx0cmFjZS8rLzEzMDUvNDwvYT48L2Rpdj48
ZGl2PjxhIGhyZWY9Imh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9jL2JhYmVsdHJhY2UvKy8xMzA3
LzQiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3Jldmlldy5sdHRuZy5vcmcvYy9iYWJlbHRyYWNl
LysvMTMwNy80PC9hPjwvZGl2PjxkaXY+PGEgaHJlZj0iaHR0cHM6Ly9yZXZpZXcubHR0bmcub3Jn
L2MvYmFiZWx0cmFjZS8rLzEzMTgvMSIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vcmV2aWV3Lmx0
dG5nLm9yZy9jL2JhYmVsdHJhY2UvKy8xMzE4LzE8L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5UaGFua3MhPC9kaXY+PGRpdj5Kw6lyw6ltaWU8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+
PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxf
YXR0ciI+T24gVGh1LCAxNiBNYXkgMjAxOSBhdCAxNjo1OCwgTWF0aGlldSBEZXNub3llcnMgJmx0
OzxhIGhyZWY9Im1haWx0bzptYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20iIHRhcmdldD0i
X2JsYW5rIj5tYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb208L2E+Jmd0OyB3cm90ZTo8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPmJpdGZpZWxkLmggdXNlcyB0aGUgbGVmdCBzaGlmdCBvcGVyYXRvciB3aXRo
IGEgbGVmdCBvcGVyYW5kIHdoaWNoPGJyPg0KbWF5IGJlIG5lZ2F0aXZlLiBUaGUgQzk5IHN0YW5k
YXJkIHN0YXRlcyB0aGF0IHNoaWZ0aW5nIGEgbmVnYXRpdmU8YnI+DQp2YWx1ZSBpcyB1bmRlZmlu
ZWQuPGJyPg0KPGJyPg0KV2hlbiBidWlsZGluZyB3aXRoIC1Xc2hpZnQtbmVnYXRpdmUtdmFsdWUs
IHdlIGdldCB0aGlzIGdjYyB3YXJuaW5nOjxicj4NCjxicj4NCkluIGZpbGUgaW5jbHVkZWQgZnJv
bSAvaG9tZS9zbWFyY2hpL3NyYy9iYWJlbHRyYWNlL2luY2x1ZGUvYmFiZWx0cmFjZS9jdGZzZXIt
aW50ZXJuYWwuaDo0NDowLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJvbSAvaG9t
ZS9zbWFyY2hpL3NyYy9iYWJlbHRyYWNlL2N0ZnNlci9jdGZzZXIuYzo0Mjo8YnI+DQovaG9tZS9z
bWFyY2hpL3NyYy9iYWJlbHRyYWNlL2luY2x1ZGUvYmFiZWx0cmFjZS9jdGZzZXItaW50ZXJuYWwu
aDogSW4gZnVuY3Rpb24g4oCYYnRfY3Rmc2VyX3dyaXRlX3Vuc2lnbmVkX2ludOKAmTo8YnI+DQov
aG9tZS9zbWFyY2hpL3NyYy9iYWJlbHRyYWNlL2luY2x1ZGUvYmFiZWx0cmFjZS9iaXRmaWVsZC1p
bnRlcm5hbC5oOjExNjoyNDogZXJyb3I6IGxlZnQgc2hpZnQgb2YgbmVnYXRpdmUgdmFsdWUgWy1X
ZXJyb3I9c2hpZnQtbmVnYXRpdmUtdmFsdWVdPGJyPg0KwqAgwqBtYXNrID0gfigofih0eXBlKSAw
KSAmbHQ7Jmx0OyAoX19zdGFydCAlIHRzKSk7wqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIF48YnI+DQovaG9tZS9zbWFyY2hpL3NyYy9iYWJlbHRyYWNlL2luY2x1
ZGUvYmFiZWx0cmFjZS9iaXRmaWVsZC1pbnRlcm5hbC5oOjIyMjoyOiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8g4oCYX2J0X2JpdGZpZWxkX3dyaXRlX2xl4oCZPGJyPg0KwqAgX2J0X2JpdGZp
ZWxkX3dyaXRlX2xlKHB0ciwgdHlwZSwgX3N0YXJ0LCBfbGVuZ3RoLCBfdik8YnI+DQrCoCBefn5+
fn5+fn5+fn5+fn5+fn5+fn48YnI+DQovaG9tZS9zbWFyY2hpL3NyYy9iYWJlbHRyYWNlL2luY2x1
ZGUvYmFiZWx0cmFjZS9jdGZzZXItaW50ZXJuYWwuaDo0MTg6Mzogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvIOKAmGJ0X2JpdGZpZWxkX3dyaXRlX2xl4oCZPGJyPg0KwqAgwqBidF9iaXRmaWVs
ZF93cml0ZV9sZShtbWFwX2FsaWduX2FkZHIoY3Rmc2VyLSZndDtiYXNlX21tYSkgKzxicj4NCsKg
IMKgXn5+fn5+fn5+fn5+fn5+fn5+fn48YnI+DQo8YnI+DQpUaGlzIGJvaWxzIGRvd24gdG8gdGhl
IGZhY3QgdGhhdCB0aGUgZXhwcmVzc2lvbiB+KCh1aW50OF90KTApIGhhcyB0eXBlPGJyPg0KJnF1
b3Q7c2lnbmVkIGludCZxdW90Oywgd2hpY2ggaXMgdXNlZCBhcyBhbiBvcGVyYW5kIG9mIHRoZSBs
ZWZ0IHNoaWZ0LsKgIFRoaXMgaXMgZHVlPGJyPg0KdG8gdGhlIGludGVnZXIgcHJvbW90aW9uIHJ1
bGVzIG9mIEM5OSAoNi4zLjMuMSk6PGJyPg0KPGJyPg0KwqAgwqAgSWYgYW4gaW50IGNhbiByZXBy
ZXNlbnQgYWxsIHZhbHVlcyBvZiB0aGUgb3JpZ2luYWwgdHlwZSwgdGhlIHZhbHVlIGlzPGJyPg0K
wqAgwqAgY29udmVydGVkIHRvIGFuIGludDsgb3RoZXJ3aXNlLCBpdCBpcyBjb252ZXJ0ZWQgdG8g
YW4gdW5zaWduZWQgaW50Ljxicj4NCsKgIMKgIFRoZXNlIGFyZSBjYWxsZWQgdGhlIGludGVnZXIg
cHJvbW90aW9ucy4gQWxsIG90aGVyIHR5cGVzIGFyZSB1bmNoYW5nZWQ8YnI+DQrCoCDCoCBieSB0
aGUgaW50ZWdlciBwcm9tb3Rpb25zLjxicj4NCjxicj4NCldlIGFsc28gbmVlZCB0byBjYXN0IHRo
ZSByZXN1bHQgZXhwbGljaXRseSBpbnRvIHRoZSBsZWZ0IGhhbmQ8YnI+DQpzaWRlIHR5cGUgdG8g
ZGVhbCB3aXRoOjxicj4NCjxicj4NCndhcm5pbmc6IGxhcmdlIGludGVnZXIgaW1wbGljaXRseSB0
cnVuY2F0ZWQgdG8gdW5zaWduZWQgdHlwZSBbLVdvdmVyZmxvd108YnI+DQo8YnI+DQpUaGUgQzk5
IHN0YW5kYXJkIHN0YXRlcyB0aGF0IGEgcmlnaHQgc2hpZnQgaGFzIGltcGxlbWVudGF0aW9uLWRl
ZmluZWQ8YnI+DQpiZWhhdmlvciB3aGVuIHNoaWZ0aW5nIGEgc2lnbmVkIG5lZ2F0aXZlIHZhbHVl
LiBBZGQgYSBwcmVwcm9jZXNzb3IgY2hlY2s8YnI+DQp0aGF0IHRoZSBjb21waWxlciBwcm92aWRl
cyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IsIGVsc2UgcHJvdmlkZSBhbjxicj4NCmFsdGVybmF0aXZl
IGltcGxlbWVudGF0aW9uIHdoaWNoIGd1YXJhbnRlZXMgdGhlIGludGVuZGVkIGJlaGF2aW9yLjxi
cj4NCjxicj4NCkEgcHJlcHJvY2Vzc29yIGNoZWNrIGlzIGFsc28gYWRkZWQgdG8gZW5zdXJlIHRo
YXQgdGhlIGNvbXBpbGVyPGJyPg0KcmVwcmVzZW50YXRpb24gZm9yIHNpZ25lZCB2YWx1ZXMgaXMg
dHdvJiMzOTtzIGNvbXBsZW1lbnQsIHdoaWNoIGlzIGV4cGVjdGVkPGJyPg0KYnkgdGhpcyBoZWFk
ZXIuPGJyPg0KPGJyPg0KRG9jdW1lbnQgdGhhdCB0aGlzIGhlYWRlciBzdHJpY3RseSByZXNwZWN0
cyB0aGUgQzk5IHN0YW5kYXJkLCB3aXRoPGJyPg0KdGhlIGV4Y2VwdGlvbiBvZiBpdHMgdXNlIG9m
IF9fdHlwZW9mX18uPGJyPg0KPGJyPg0KQWRhcHQgdXNlIG9mIF9idF9waWVjZXdpc2VfbHNoaWZ0
IGluIHBsdWdpbnMvdGV4dC9wcmV0dHkvcHJpbnQuYzxicj4NCnRvIHRoZSBuZXcgQVBJLjxicj4N
Cjxicj4NClNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzICZsdDs8YSBocmVmPSJtYWls
dG86bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+bWF0aGll
dS5kZXNub3llcnNAZWZmaWNpb3MuY29tPC9hPiZndDs8YnI+DQpBY2tlZC1ieTogU2ltb24gTWFy
Y2hpICZsdDs8YSBocmVmPSJtYWlsdG86c2ltb24ubWFyY2hpQGVmZmljaW9zLmNvbSIgdGFyZ2V0
PSJfYmxhbmsiPnNpbW9uLm1hcmNoaUBlZmZpY2lvcy5jb208L2E+Jmd0Ozxicj4NCkNoYW5nZS1J
ZDogSTQ3ZDI2NTVjZmU2NzFiYWYwZmMxODgxMzg4M2FkZjdjZTExZGZkNmE8YnI+DQotLS08YnI+
DQpDaGFuZ2VzIHNpbmNlIHYxOjxicj4NCi0gR2VuZXJhdGUgY29tcGlsZS10aW1lIGVycm9yIGlm
IHRoZSB0eXBlIGFyZ3VtZW50IHBhc3NlZCB0bzxicj4NCsKgIF9idF91bnNpZ25lZF9jYXN0KCkg
aXMgbGFyZ2VyIHRoYW4gc2l6ZW9mKHVpbnQ2NF90KSwgdGhpczxicj4NCsKgIGFsbG93cyByZW1v
dmluZyBfYnRfY2hlY2tfbWF4XzY0Yml0LDxicj4NCi0gSW50cm9kdWNlIF9icl9maWxsX21hc2ss
IHdoaWNoIHJlcGxhY2VzIF9idF9iaXR3aXNlX25vdCw8YnI+DQotIENsYXJpZnkgX2J0X3Vuc2ln
bmVkX2Nhc3QgY29tbWVudCw8YnI+DQotIEV4cGFuZCBleHBsYW5hdGlvbiBvZiB0aGUgaXNzdWUg
d2l0aGluIHRoZSBwYXRjaCBjb21taXQgbWVzc2FnZS48YnI+DQo8YnI+DQpDaGFuZ2VzIHNpbmNl
IHYyOjxicj4NCi0gRml4IHVud2FudGVkIHNpZ24gZXh0ZW5zaW9uIHdoZW4gZ2VuZXJhdGluZyBt
YXNrcyw8YnI+DQotIEludHJvZHVjZSBtYWNybyBoZWxwZXJzIHRvIGNsYXJpZnkgY29kZTo8YnI+
DQrCoCAtIF9idF9jYXN0X3ZhbHVlX3RvX3Vuc2lnbmVkKCk8YnI+DQrCoCAtIF9idF9jYXN0X3Zh
bHVlX3RvX3Vuc2lnbmVkX3R5cGUoKSw8YnI+DQrCoCAtIF9idF9tYWtlX21hc2tfY29tcGxlbWVu
dCgpLDxicj4NCsKgIC0gX2J0X21ha2VfbWFzaygpLjxicj4NCjxicj4NCkNoYW5nZXMgc2luY2Ug
djM6PGJyPg0KLSBGaXggYWRkaXRpb25hbCBsZWZ0IHNoaWZ0IHVuZGVmaW5lZCBiZWhhdmlvci4g
SWRlbnRpZmllZCB3aXRoPGJyPg0KwqAgLWZzYW5pdGl6ZT11bmRlZmluZWQuPGJyPg0KLSBDcmVh
dGUgZmFsbGJhY2sgZm9yIHJpZ2h0IHNoaWZ0IGltcGxlbWVudGF0aW9uLWRlZmluZWQgYmVoYXZp
b3I8YnI+DQrCoCBpZiB0aGUgYmVoYXZpb3IgaXMgZm91bmQgbm90IHRvIGJlIGFzIGludGVuZGVk
LiBEZXRlY3QgdGhlIGJlaGF2aW9yPGJyPg0KwqAgd2l0aCBhIHByZXByb2Nlc3NvciBjaGVjay48
YnI+DQotIEVuc3VyZSB0aGF0IHRoZSBjb21waWxlciByZXByZXNlbnRzIHNpZ25lZCB0eXBlcyB3
aXRoIHR3byYjMzk7cyBjb21wbGVtZW50PGJyPg0KwqAgd2l0aCBhIHByZXByb2Nlc3NvciBjaGVj
ay48YnI+DQotIEFkZCBfYnRfcnNoaWZ0KCkgYW5kIF9idF9sc2hpZnQoKSBzaGlmdCBoZWxwZXJz
IHRvIHRha2UgY2FyZSBvZjxicj4NCsKgIEM5OSYjMzk7cyB1bmRlZmluZWQgYmVoYXZpb3JzIHJl
bGF0ZWQgdG8gc2hpZnRpbmcgc2lnbmVkIHR5cGVzLjxicj4NCi0gUmVtb3ZlIHN0YXRlbWVudC1l
eHByZXNzaW9ucyB0byBhbGxvdyBidWlsZGluZyB3aXRoIC1zdGQ9Yzk5Ljxicj4NCi0gVXNlIF9f
dHlwZW9mX18gaW5zdGVhZCBvZiB0eXBlb2YgdG8gYWxsb3cgYnVpbGRpbmcgd2l0aCAtc3RkPWM5
OS48YnI+DQrCoCBTdHJpY3RseSBzcGVha2luZywgdGhlIHVzZSBvZiBfX3R5cGVvZl9fIGlzIHNw
ZWNpZmljIHRvIHRoZSBjb21waWxlci48YnI+DQrCoCBUaGVyZWZvcmUsIHBvcnRpbmcgdG8gYSBz
dHJpY3QgYW5zaSBDIGNvbXBpbGVyIHdvdWxkIHJlcXVpcmUgcmVtb3Zpbmc8YnI+DQrCoCB0aG9z
ZSBfX3R5cGVvZl9fLjxicj4NCi0gUmVtb3ZlIHVzZSBvZiBnbnUgZXh0ZW5zaW9uOiByZXBsYWNl
IChhID8gOiBiKSBleHByZXNzaW9ucyBieSAoYSA/IGEgOjxicj4NCsKgIGIpIHRvIHBsZWFzZSBj
b21waWxpbmcgd2l0aCAtc3RkPWM5OSAtV3BlZGFudGljLjxicj4NCjxicj4NCkNoYW5nZXMgc2lu
Y2UgdjQ6PGJyPg0KLSBEb2N1bWVudCBzdHJpY3QgQzg5IGNvbXBsaWFuY2UsIGV4Y2VwdCBmb3Ig
dXNlIG9mIF9fdHlwZW9mX188YnI+DQrCoCBjb21waWxlci1zcGVjaWZpYyBleHRlbnNpb24uPGJy
Pg0KLSBBZGFwdCB1c2Ugb2YgX2J0X3BpZWNld2lzZV9sc2hpZnQgaW4gcGx1Z2lucy90ZXh0L3By
ZXR0eS9wcmludC5jPGJyPg0KwqAgdG8gdGhlIG5ldyBBUEkuPGJyPg0KPGJyPg0KQ2hhbmdlcyBz
aW5jZSB2NTo8YnI+DQotIEJ1bXAgc3RhbmRhcmQgY29tcGxpYW5jZSBmcm9tIEM4OSB0byBDOTks
IGJlY2F1c2Ugd2UgdXNlPGJyPg0KwqAgQzk5IHR5cGVzLmguPGJyPg0KPGJyPg0KQ2hhbmdlcyBz
aW5jZSB2Njo8YnI+DQotIEZpeCB3cm9uZyB1c2Ugb2YgX2J0X21ha2VfbWFzaygpIGluIF9idF9i
aXRmaWVsZF93cml0ZV9iZS4gU2hvdWxkPGJyPg0KwqAgYmUgX2J0X21ha2VfbWFza19jb21wbGVt
ZW50LiBDYXVnaHQgYnkgdGVzdGluZyBvbiBwb3dlcnBjLjxicj4NCjxicj4NCkNoYW5nZXMgc2lu
Y2Ugdjc6PGJyPg0KLSBTdHlsZSBmaXhlcy48YnI+DQotLS08YnI+DQrCoGluY2x1ZGUvYmFiZWx0
cmFjZS9iaXRmaWVsZC1pbnRlcm5hbC5oIHwgMzEyICsrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLTxicj4NCsKgcGx1Z2lucy90ZXh0L3ByZXR0eS9wcmludC5jwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIMKgNCArLTxicj4NCsKgMiBmaWxlcyBjaGFuZ2VkLCAyMDggaW5zZXJ0aW9ucygrKSwg
MTA4IGRlbGV0aW9ucygtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2JhYmVsdHJh
Y2UvYml0ZmllbGQtaW50ZXJuYWwuaCBiL2luY2x1ZGUvYmFiZWx0cmFjZS9iaXRmaWVsZC1pbnRl
cm5hbC5oPGJyPg0KaW5kZXggYzVkNWVjY2QuLjVlY2RlMDVlIDEwMDY0NDxicj4NCi0tLSBhL2lu
Y2x1ZGUvYmFiZWx0cmFjZS9iaXRmaWVsZC1pbnRlcm5hbC5oPGJyPg0KKysrIGIvaW5jbHVkZS9i
YWJlbHRyYWNlL2JpdGZpZWxkLWludGVybmFsLmg8YnI+DQpAQCAtMiw3ICsyLDcgQEA8YnI+DQrC
oCNkZWZpbmUgX0JBQkVMVFJBQ0VfQklURklFTERfSDxicj4NCjxicj4NCsKgLyo8YnI+DQotICog
Q29weXJpZ2h0IDIwMTAgLSBNYXRoaWV1IERlc25veWVycyAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1h
dGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdGhpZXUuZGVz
bm95ZXJzQGVmZmljaW9zLmNvbTwvYT4mZ3Q7PGJyPg0KKyAqIENvcHlyaWdodCAyMDEwLTIwMTkg
LSBNYXRoaWV1IERlc25veWVycyAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hdGhpZXUuZGVzbm95ZXJz
QGVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9z
LmNvbTwvYT4mZ3Q7PGJyPg0KwqAgKjxicj4NCsKgICogUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3Jh
bnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gb2J0YWluaW5nIGEgY29weTxicj4N
CsKgICogb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVz
ICh0aGUgJnF1b3Q7U29mdHdhcmUmcXVvdDspLCB0byBkZWFsPGJyPg0KQEAgLTI3LDQ5ICsyNywx
NTcgQEA8YnI+DQrCoCNpbmNsdWRlICZsdDtiYWJlbHRyYWNlL2NvbXBhdC9saW1pdHMtaW50ZXJu
YWwuaCZndDsgLyogQzk5IDUuMi40LjIgTnVtZXJpY2FsIGxpbWl0cyAqLzxicj4NCsKgI2luY2x1
ZGUgJmx0O2JhYmVsdHJhY2UvZW5kaWFuLWludGVybmFsLmgmZ3Q7wqAgwqAgwqAgwqAgLyogTm9u
LXN0YW5kYXJkIEJJR19FTkRJQU4sIExJVFRMRV9FTkRJQU4sIEJZVEVfT1JERVIgKi88YnI+DQo8
YnI+DQotLyogV2UgY2FuJiMzOTt0IHNoaWZ0IGEgaW50IGZyb20gMzIgYml0LCAmZ3Q7Jmd0OyAz
MiBhbmQgJmx0OyZsdDsgMzIgb24gaW50IGlzIHVuZGVmaW5lZCAqLzxicj4NCi0jZGVmaW5lIF9i
dF9waWVjZXdpc2VfcnNoaWZ0KF92LCBfc2hpZnQpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLSh7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgdHlwZW9mKF92KSBfX192ID0g
KF92KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqB0eXBlb2YoX3NoaWZ0KSBfX19zaGlmdCA9IChf
c2hpZnQpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4N
Ci3CoCDCoCDCoCDCoHVuc2lnbmVkIGxvbmcgc2IgPSAoX19fc2hpZnQpIC8gKHNpemVvZihfX192
KSAqIENIQVJfQklUIC0gMSk7wqAgXDxicj4NCi3CoCDCoCDCoCDCoHVuc2lnbmVkIGxvbmcgZmlu
YWwgPSAoX19fc2hpZnQpICUgKHNpemVvZihfX192KSAqIENIQVJfQklUIC0gMSk7IFw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0K
LcKgIMKgIMKgIMKgZm9yICg7IHNiOyBzYi0tKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBfX192ICZndDsmZ3Q7PSBzaXplb2YoX19fdikgKiBDSEFSX0JJVCAt
IDE7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgX19fdiAm
Z3Q7Jmd0Oz0gZmluYWw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLX0pPGJyPg0KLTxicj4NCi0j
ZGVmaW5lIF9idF9waWVjZXdpc2VfbHNoaWZ0KF92LCBfc2hpZnQpwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLSh7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgdHlwZW9mKF92
KSBfX192ID0gKF92KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqB0eXBlb2YoX3NoaWZ0KSBfX19z
aGlmdCA9IChfc2hpZnQpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCi3CoCDCoCDCoCDCoHVuc2lnbmVkIGxvbmcgc2IgPSAoX19fc2hpZnQpIC8gKHNp
emVvZihfX192KSAqIENIQVJfQklUIC0gMSk7wqAgXDxicj4NCi3CoCDCoCDCoCDCoHVuc2lnbmVk
IGxvbmcgZmluYWwgPSAoX19fc2hpZnQpICUgKHNpemVvZihfX192KSAqIENIQVJfQklUIC0gMSk7
IFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBcPGJyPg0KLcKgIMKgIMKgIMKgZm9yICg7IHNiOyBzYi0tKcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX192ICZsdDsmbHQ7PSBzaXplb2YoX19fdikgKiBD
SEFSX0JJVCAtIDE7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKg
IMKgX19fdiAmbHQ7Jmx0Oz0gZmluYWw7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLX0pPGJyPg0K
Ky8qPGJyPg0KKyAqIFRoaXMgaGVhZGVyIHN0cmljdGx5IGZvbGxvd3MgdGhlIEM5OSBzdGFuZGFy
ZCwgZXhjZXB0IGZvciB1c2Ugb2YgdGhlPGJyPg0KKyAqIGNvbXBpbGVyLXNwZWNpZmljIF9fdHlw
ZW9mX18uPGJyPg0KKyAqLzxicj4NCis8YnI+DQorLyo8YnI+DQorICogVGhpcyBiaXRmaWVsZCBo
ZWFkZXIgcmVxdWlyZXMgdGhlIGNvbXBpbGVyIHJlcHJlc2VudGF0aW9uIG9mIHNpZ25lZDxicj4N
CisgKiBpbnRlZ2VycyB0byBiZSB0d28mIzM5O3MgY29tcGxlbWVudC48YnI+DQorICovPGJyPg0K
KyNpZiAoLTEgIT0gfjApPGJyPg0KKyNlcnJvciAmcXVvdDtiaXRmaWVsZC5oIHJlcXVpcmVzIHRo
ZSBjb21waWxlciByZXByZXNlbnRhdGlvbiBvZiBzaWduZWQgaW50ZWdlcnMgdG8gYmUgdHdvJiMz
OTtzIGNvbXBsZW1lbnQuJnF1b3Q7PGJyPg0KKyNlbmRpZjxicj4NCjxicj4NCsKgI2RlZmluZSBf
YnRfaXNfc2lnbmVkX3R5cGUodHlwZSnCoCDCoCDCoCDCoCgodHlwZSkgLTEgJmx0OyAodHlwZSkg
MCk8YnI+DQo8YnI+DQrCoC8qPGJyPg0KLSAqIE5PVEU6IFRoZSBjYXN0IHRvICh1aW50NjRfdCkg
YmVsb3cgZW5zdXJlcyB0aGF0IHdlJiMzOTtyZSBub3QgY2FzdGluZyBhPGJyPg0KLSAqIG5lZ2F0
aXZlIHZhbHVlLCB3aGljaCBpcyB1bmRlZmluZWQgaW4gQy4gSG93ZXZlciwgdGhpcyBsaW1pdHMg
dGhlPGJyPg0KLSAqIG1heGltdW0gdHlwZSBzaXplIG9mIGB0eXBlYCBhbmQgYHZgIHRvIDY0LWJp
dC4gVGhlPGJyPg0KLSAqIF9idF9jaGVja19tYXhfNjRiaXQoKSBpcyB1c2VkIHRvIGNoZWNrIHRo
YXQgdGhlIHVzZXJzIG9mIHRoaXMgaGVhZGVyPGJyPg0KLSAqIGRvIG5vdCB1c2UgdHlwZXMgd2l0
aCBhIHNpemUgZ3JlYXRlciB0aGFuIDY0LWJpdC48YnI+DQorICogUHJvZHVjZSBhIGJ1aWxkLXRp
bWUgZXJyb3IgaWYgdGhlIGNvbmRpdGlvbiBgY29uZGAgaXMgbm9uLXplcm8uPGJyPg0KKyAqIEV2
YWx1YXRlcyBhcyBhIHNpemVfdCBleHByZXNzaW9uLjxicj4NCisgKi88YnI+DQorI2RlZmluZSBf
QlRfQlVJTERfQVNTRVJUKGNvbmQpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgc2l6ZW9mKHN0cnVjdCB7IGludCBmOigy
ICogISEoY29uZCkgLSAxKTsgfSk8YnI+DQorPGJyPg0KKy8qPGJyPg0KKyAqIENhc3QgdmFsdWUg
YHZgIHRvIGFuIHVuc2lnbmVkIGludGVnZXIgb2YgdGhlIHNhbWUgc2l6ZSBhcyBgdmAuPGJyPg0K
KyAqLzxicj4NCisjZGVmaW5lIF9idF9jYXN0X3ZhbHVlX3RvX3Vuc2lnbmVkKHYpwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDC
oCDCoChzaXplb2YodikgPT0gc2l6ZW9mKHVpbnQ4X3QpID8gKHVpbnQ4X3QpICh2KSA6wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgc2l6ZW9mKHYpID09IHNpemVv
Zih1aW50MTZfdCkgPyAodWludDE2X3QpICh2KSA6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCivCoCDCoCDCoCDCoHNpemVvZih2KSA9PSBzaXplb2YodWludDMyX3QpID8gKHVpbnQzMl90
KSAodikgOsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqBzaXplb2Yo
dikgPT0gc2l6ZW9mKHVpbnQ2NF90KSA/ICh1aW50NjRfdCkgKHYpIDrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgX0JUX0JVSUxEX0FTU0VSVChzaXplb2YodikgJmx0
Oz0gc2l6ZW9mKHVpbnQ2NF90KSkpPGJyPg0KKzxicj4NCisvKjxicj4NCisgKiBDYXN0IHZhbHVl
IGB2YCB0byBhbiB1bnNpZ25lZCBpbnRlZ2VyIHR5cGUgb2YgdGhlIHNpemUgb2YgdHlwZSBgdHlw
ZWA8YnI+DQorICogKndpdGhvdXQqIHNpZ24tZXh0ZW5zaW9uLjxicj4NCisgKjxicj4NCisgKiBU
aGUgdW5zaWduZWQgY2FzdCBlbnN1cmVzIHRoYXQgd2UmIzM5O3JlIG5vdCBzaGlmdGluZyBhIG5l
Z2F0aXZlIHZhbHVlLDxicj4NCisgKiB3aGljaCBpcyB1bmRlZmluZWQgaW4gQy4gSG93ZXZlciwg
dGhpcyBsaW1pdHMgdGhlIG1heGltdW0gdHlwZSBzaXplPGJyPg0KKyAqIG9mIGB0eXBlYCB0byA2
NC1iaXQuIEdlbmVyYXRlIGEgY29tcGlsZS10aW1lIGVycm9yIGlmIHRoZSBzaXplIG9mPGJyPg0K
KyAqIGB0eXBlYCBpcyBsYXJnZXIgdGhhbiA2NC1iaXQuPGJyPg0KKyAqLzxicj4NCisjZGVmaW5l
IF9idF9jYXN0X3ZhbHVlX3RvX3Vuc2lnbmVkX3R5cGUodHlwZSwgdinCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAoc2l6ZW9mKHR5cGUpID09IHNp
emVvZih1aW50OF90KSA/wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCh1aW50OF90KSBfYnRfY2FzdF92YWx1
ZV90b191bnNpZ25lZCh2KSA6wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKg
IMKgc2l6ZW9mKHR5cGUpID09IHNpemVvZih1aW50MTZfdCkgP8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAo
dWludDE2X3QpIF9idF9jYXN0X3ZhbHVlX3RvX3Vuc2lnbmVkKHYpIDrCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgc2l6ZW9mKHR5cGUpID09IHNpemVvZih1aW50MzJfdCkg
P8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAodWludDMyX3QpIF9idF9jYXN0X3ZhbHVlX3RvX3Vuc2lnbmVk
KHYpIDrCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgc2l6ZW9mKHR5cGUp
ID09IHNpemVvZih1aW50NjRfdCkgP8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAodWludDY0X3QpIF9idF9j
YXN0X3ZhbHVlX3RvX3Vuc2lnbmVkKHYpIDrCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8Kg
IMKgIMKgIMKgX0JUX0JVSUxEX0FTU0VSVChzaXplb2YodikgJmx0Oz0gc2l6ZW9mKHVpbnQ2NF90
KSkpPGJyPg0KKzxicj4NCisvKjxicj4NCisgKiBfYnRfZmlsbF9tYXNrIGV2YWx1YXRlcyB0byBh
ICZxdW90O3R5cGUmcXVvdDsgaW50ZWdlciB3aXRoIGFsbCBiaXRzIHNldC48YnI+DQorICovPGJy
Pg0KKyNkZWZpbmUgX2J0X2ZpbGxfbWFzayh0eXBlKcKgIMKgICgodHlwZSkgfih0eXBlKSAwKTxi
cj4NCis8YnI+DQorLyo8YnI+DQorICogTGVmdCBzaGlmdCBhIHZhbHVlIGB2YCBvZiBgc2hpZnRg
IGJpdHMuPGJyPg0KKyAqPGJyPg0KKyAqIFRoZSB0eXBlIG9mIGB2YCBjYW4gYmUgc2lnbmVkIG9y
IHVuc2lnbmVkIGludGVnZXIuPGJyPg0KKyAqIFRoZSB2YWx1ZSBvZiBgc2hpZnRgIG11c3QgYmUg
bGVzcyB0aGFuIHRoZSBzaXplIG9mIGB2YCAoaW4gYml0cyksPGJyPg0KKyAqIG90aGVyd2lzZSB0
aGUgYmVoYXZpb3IgaXMgdW5kZWZpbmVkLjxicj4NCisgKiBFdmFsdWF0ZXMgdG8gdGhlIHJlc3Vs
dCBvZiB0aGUgc2hpZnQgb3BlcmF0aW9uLjxicj4NCisgKjxicj4NCisgKiBBY2NvcmRpbmcgdG8g
dGhlIEM5OSBzdGFuZGFyZCwgbGVmdCBzaGlmdCBvZiBhIGxlZnQgaGFuZC1zaWRlIHNpZ25lZDxi
cj4NCisgKiB0eXBlIGlzIHVuZGVmaW5lZCBpZiBpdCBoYXMgYSBuZWdhdGl2ZSB2YWx1ZSBvciBp
ZiB0aGUgcmVzdWx0IGNhbm5vdDxicj4NCisgKiBiZSByZXByZXNlbnRlZCBpbiB0aGUgcmVzdWx0
IHR5cGUuIFRoaXMgYml0ZmllbGQgaGVhZGVyIGRpc2NhcmRzIHRoZTxicj4NCisgKiBiaXRzIHRo
YXQgYXJlIGxlZnQtc2hpZnRlZCBiZXlvbmQgdGhlIHJlc3VsdCB0eXBlIHJlcHJlc2VudGF0aW9u
LDxicj4NCisgKiB3aGljaCBpcyB0aGUgYmVoYXZpb3Igb2YgYW4gdW5zaWduZWQgdHlwZSBsZWZ0
IHNoaWZ0IG9wZXJhdGlvbi48YnI+DQorICogVGhlcmVmb3JlLCBhbHdheXMgcGVyZm9ybSBsZWZ0
IHNoaWZ0IG9uIGFuIHVuc2lnbmVkIHR5cGUuPGJyPg0KKyAqPGJyPg0KKyAqIFRoaXMgbWFjcm8g
c2hvdWxkIG5vdCBiZSB1c2VkIGlmIGBzaGlmdGAgY2FuIGJlIGdyZWF0ZXIgb3IgZXF1YWwgdGhh
bjxicj4NCisgKiB0aGUgYml0d2lkdGggb2YgYHZgLiBTZWUgYF9idF9zYWZlX2xzaGlmdGAuPGJy
Pg0KKyAqLzxicj4NCisjZGVmaW5lIF9idF9sc2hpZnQodiwgc2hpZnQpwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0K
K8KgIMKgIMKgIMKgKChfX3R5cGVvZl9fKHYpKSAoX2J0X2Nhc3RfdmFsdWVfdG9fdW5zaWduZWQo
dikgJmx0OyZsdDsgKHNoaWZ0KSkpPGJyPg0KKzxicj4NCisvKjxicj4NCisgKiBHZW5lcmF0ZSBh
IG1hc2sgb2YgdHlwZSBgdHlwZWAgd2l0aCB0aGUgYGxlbmd0aGAgbGVhc3Qgc2lnbmlmaWNhbnQg
Yml0czxicj4NCisgKiBjbGVhcmVkLCBhbmQgdGhlIG1vc3Qgc2lnbmlmaWNhbnQgYml0cyBzZXQu
PGJyPg0KwqAgKi88YnI+DQotI2RlZmluZSBfYnRfdW5zaWduZWRfY2FzdCh0eXBlLCB2KcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4N
Ci0oe8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4N
Ci3CoCDCoCDCoCDCoChzaXplb2YodikgJmx0OyBzaXplb2YodHlwZSkpID/CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgKCh0eXBlKSAodikpICZhbXA7ICgodHlwZSkgKH4ofih1aW50NjRfdCkg
MCAmbHQ7Jmx0OyAoc2l6ZW9mKHYpICogQ0hBUl9CSVQpKSkpIDogXDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCh0eXBlKSAodik7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLX0pPGJyPg0KKyNkZWZp
bmUgX2J0X21ha2VfbWFza19jb21wbGVtZW50KHR5cGUsIGxlbmd0aCnCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqBfYnRfbHNoaWZ0KF9idF9m
aWxsX21hc2sodHlwZSksIGxlbmd0aCk8YnI+DQo8YnI+DQotI2RlZmluZSBfYnRfY2hlY2tfbWF4
XzY0Yml0KHR5cGUpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoGNoYXIgX21heF82NGJpdF9hc3NlcnRpb25b
c2l6ZW9mKHR5cGUpICZsdDs9IHNpemVvZih1aW50NjRfdCkgPyAxIDogLTFdIF9fYXR0cmlidXRl
X18oKHVudXNlZCkpPGJyPg0KKy8qPGJyPg0KKyAqIEdlbmVyYXRlIGEgbWFzayBvZiB0eXBlIGB0
eXBlYCB3aXRoIHRoZSBgbGVuZ3RoYCBsZWFzdCBzaWduaWZpY2FudCBiaXRzPGJyPg0KKyAqIHNl
dCwgYW5kIHRoZSBtb3N0IHNpZ25pZmljYW50IGJpdHMgY2xlYXJlZC48YnI+DQorICovPGJyPg0K
KyNkZWZpbmUgX2J0X21ha2VfbWFzayh0eXBlLCBsZW5ndGgpwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCgodHlw
ZSkgfl9idF9tYWtlX21hc2tfY29tcGxlbWVudCh0eXBlLCBsZW5ndGgpKTxicj4NCis8YnI+DQor
Lyo8YnI+DQorICogUmlnaHQgc2hpZnQgYSB2YWx1ZSBgdmAgb2YgYHNoaWZ0YCBiaXRzLjxicj4N
CisgKjxicj4NCisgKiBUaGUgdHlwZSBvZiBgdmAgY2FuIGJlIHNpZ25lZCBvciB1bnNpZ25lZCBp
bnRlZ2VyLjxicj4NCisgKiBUaGUgdmFsdWUgb2YgYHNoaWZ0YCBtdXN0IGJlIGxlc3MgdGhhbiB0
aGUgc2l6ZSBvZiBgdmAgKGluIGJpdHMpLDxicj4NCisgKiBvdGhlcndpc2UgdGhlIGJlaGF2aW9y
IGlzIHVuZGVmaW5lZC48YnI+DQorICogRXZhbHVhdGVzIHRvIHRoZSByZXN1bHQgb2YgdGhlIHNo
aWZ0IG9wZXJhdGlvbi48YnI+DQorICo8YnI+DQorICogQWNjb3JkaW5nIHRvIHRoZSBDOTkgc3Rh
bmRhcmQsIHJpZ2h0IHNoaWZ0IG9mIGEgbGVmdCBoYW5kLXNpZGUgc2lnbmVkPGJyPg0KKyAqIHR5
cGUgd2hpY2ggaGFzIGEgbmVnYXRpdmUgdmFsdWUgaXMgaW1wbGVtZW50YXRpb24gZGVmaW5lZC4g
VGhpczxicj4NCisgKiBiaXRmaWVsZCBoZWFkZXIgcmVsaWVzIG9uIHRoZSByaWdodCBzaGlmdCBp
bXBsZW1lbnRhdGlvbiBjYXJyeWluZyB0aGU8YnI+DQorICogc2lnbiBiaXQuIElmIHRoZSBjb21w
aWxlciBpbXBsZW1lbnRhdGlvbiBoYXMgYSBkaWZmZXJlbnQgYmVoYXZpb3IsPGJyPg0KKyAqIGVt
dWxhdGUgY2FycnlpbmcgdGhlIHNpZ24gYml0Ljxicj4NCisgKjxicj4NCisgKiBUaGlzIG1hY3Jv
IHNob3VsZCBub3QgYmUgdXNlZCBpZiBgc2hpZnRgIGNhbiBiZSBncmVhdGVyIG9yIGVxdWFsIHRo
YW48YnI+DQorICogdGhlIGJpdHdpZHRoIG9mIGB2YC4gU2VlIGBfYnRfc2FmZV9yc2hpZnRgLjxi
cj4NCisgKi88YnI+DQorI2lmICgoLTEgJmd0OyZndDsgMSkgPT0gLTEpPGJyPg0KKyNkZWZpbmUg
X2J0X3JzaGlmdCh2LCBzaGlmdCnCoCDCoCgodikgJmd0OyZndDsgKHNoaWZ0KSk8YnI+DQorI2Vs
c2U8YnI+DQorI2RlZmluZSBfYnRfcnNoaWZ0KHYsIHNoaWZ0KcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDC
oCDCoCDCoCgoX190eXBlb2ZfXyh2KSkgKChfYnRfY2FzdF92YWx1ZV90b191bnNpZ25lZCh2KSAm
Z3Q7Jmd0OyAoc2hpZnQpKSB8wqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCgodikg
Jmx0OyAwID8gX2J0X21ha2VfbWFza19jb21wbGVtZW50KF9fdHlwZW9mX18odikswqAgwqAgwqAg
XDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNpemVvZih2KSAqIENI
QVJfQklUIC0gKHNoaWZ0KSkgOiAwKSkpPGJyPg0KKyNlbmRpZjxicj4NCis8YnI+DQorLyo8YnI+
DQorICogUmlnaHQgc2hpZnQgYSBzaWduZWQgb3IgdW5zaWduZWQgaW50ZWdlciB3aXRoIGBzaGlm
dGAgdmFsdWUgYmVpbmcgYW48YnI+DQorICogYXJiaXRyYXJ5IG51bWJlciBvZiBiaXRzLiBgdmAg
aXMgbW9kaWZpZWQgYnkgdGhpcyBtYWNyby4gVGhlIHNoaWZ0PGJyPg0KKyAqIGlzIHRyYW5zZm9y
bWVkIGludG8gYSBzZXF1ZW5jZSBvZiBgX25yX3BhcnRpYWxfc2hpZnRzYCBjb25zZWN1dGl2ZTxi
cj4NCisgKiBzaGlmdCBvcGVyYXRpb25zLCBlYWNoIG9mIGEgbnVtYmVyIG9mIGJpdHMgc21hbGxl
ciB0aGFuIHRoZSBiaXR3aWR0aDxicj4NCisgKiBvZiBgdmAsIGVuZGluZyB3aXRoIGEgc2hpZnQg
b2YgdGhlIG51bWJlciBvZiBsZWZ0IG92ZXIgYml0cy48YnI+DQorICovPGJyPg0KKyNkZWZpbmUg
X2J0X3NhZmVfcnNoaWZ0KHYsIHNoaWZ0KcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorZG8ge8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoHVuc2lnbmVkIGxvbmcg
X25yX3BhcnRpYWxfc2hpZnRzID0gKHNoaWZ0KSAvIChzaXplb2YodikgKiBDSEFSX0JJVCAtIDEp
OyBcPGJyPg0KK8KgIMKgIMKgIMKgdW5zaWduZWQgbG9uZyBfbGVmdG92ZXJfYml0cyA9IChzaGlm
dCkgJSAoc2l6ZW9mKHYpICogQ0hBUl9CSVQgLSAxKTsgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqBmb3Ig
KDsgX25yX3BhcnRpYWxfc2hpZnRzOyBfbnJfcGFydGlhbF9zaGlmdHMtLSnCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHYpID0gX2J0X3JzaGlm
dCh2LCBzaXplb2YodikgKiBDSEFSX0JJVCAtIDEpO8KgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAg
wqAgwqAgwqAodikgPSBfYnRfcnNoaWZ0KHYsIF9sZWZ0b3Zlcl9iaXRzKTvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK30gd2hpbGUgKDApPGJyPg0KKzxi
cj4NCisvKjxicj4NCisgKiBMZWZ0IHNoaWZ0IGEgc2lnbmVkIG9yIHVuc2lnbmVkIGludGVnZXIg
d2l0aCBgc2hpZnRgIHZhbHVlIGJlaW5nIGFuPGJyPg0KKyAqIGFyYml0cmFyeSBudW1iZXIgb2Yg
Yml0cy4gYHZgIGlzIG1vZGlmaWVkIGJ5IHRoaXMgbWFjcm8uIFRoZSBzaGlmdDxicj4NCisgKiBp
cyB0cmFuc2Zvcm1lZCBpbnRvIGEgc2VxdWVuY2Ugb2YgYF9ucl9wYXJ0aWFsX3NoaWZ0c2AgY29u
c2VjdXRpdmU8YnI+DQorICogc2hpZnQgb3BlcmF0aW9ucywgZWFjaCBvZiBhIG51bWJlciBvZiBi
aXRzIHNtYWxsZXIgdGhhbiB0aGUgYml0d2lkdGg8YnI+DQorICogb2YgYHZgLCBlbmRpbmcgd2l0
aCBhIHNoaWZ0IG9mIHRoZSBudW1iZXIgb2YgbGVmdCBvdmVyIGJpdHMuPGJyPg0KKyAqLzxicj4N
CisjZGVmaW5lIF9idF9zYWZlX2xzaGlmdCh2LCBzaGlmdCnCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK2RvIHvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqB1bnNp
Z25lZCBsb25nIF9ucl9wYXJ0aWFsX3NoaWZ0cyA9IChzaGlmdCkgLyAoc2l6ZW9mKHYpICogQ0hB
Ul9CSVQgLSAxKTsgXDxicj4NCivCoCDCoCDCoCDCoHVuc2lnbmVkIGxvbmcgX2xlZnRvdmVyX2Jp
dHMgPSAoc2hpZnQpICUgKHNpemVvZih2KSAqIENIQVJfQklUIC0gMSk7IFw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKg
IMKgIMKgZm9yICg7IF9ucl9wYXJ0aWFsX3NoaWZ0czsgX25yX3BhcnRpYWxfc2hpZnRzLS0pwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCh2KSA9
IF9idF9sc2hpZnQodiwgc2l6ZW9mKHYpICogQ0hBUl9CSVQgLSAxKTvCoCDCoCDCoCDCoCDCoCBc
PGJyPg0KK8KgIMKgIMKgIMKgKHYpID0gX2J0X2xzaGlmdCh2LCBfbGVmdG92ZXJfYml0cyk7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCit9IHdoaWxlICgw
KTxicj4NCjxicj4NCsKgLyo8YnI+DQrCoCAqIGJ0X2JpdGZpZWxkX3dyaXRlIC0gd3JpdGUgaW50
ZWdlciB0byBhIGJpdGZpZWxkIGluIG5hdGl2ZSBlbmRpYW5uZXNzPGJyPg0KQEAgLTkxLDcgKzE5
OSw3IEBAPGJyPg0KPGJyPg0KwqAjZGVmaW5lIF9idF9iaXRmaWVsZF93cml0ZV9sZShfcHRyLCB0
eXBlLCBfc3RhcnQsIF9sZW5ndGgsIF92KcKgIMKgIMKgIMKgIMKgXDxicj4NCsKgZG8ge8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDC
oHR5cGVvZihfdikgX192ID0gKF92KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgX190eXBlb2Zf
XyhfdikgX192ID0gKF92KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgdHlwZSAqX19wdHIgPSAodm9pZCAq
KSAoX3B0cik7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgXDxicj4NCsKgIMKgIMKgIMKgIHVuc2lnbmVkIGxvbmcgX19zdGFydCA9IChfc3RhcnQpLCBf
X2xlbmd0aCA9IChfbGVuZ3RoKTvCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCB0eXBl
IG1hc2ssIGNtYXNrO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCkBAIC0xMDgsMTUgKzIxNiwxNSBAQCBk
byB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+
DQrCoCDCoCDCoCDCoCAvKiBUcmltIHYgaGlnaCBiaXRzICovwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKg
IMKgIGlmIChfX2xlbmd0aCAmbHQ7IHNpemVvZihfX3YpICogQ0hBUl9CSVQpwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oF9fdiAmYW1wOz0gfigofih0eXBlb2YoX192KSkgMCkgJmx0OyZsdDsgX19sZW5ndGgpO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiAmYW1w
Oz0gX2J0X21ha2VfbWFzayhfX3R5cGVvZl9fKF9fdiksIF9fbGVuZ3RoKTvCoCDCoCDCoCDCoCBc
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4NCsKgIMKgIMKgIMKgIC8qIFdlIGNhbiBub3cgYXBwZW5kIHYgd2l0aCBhIHNpbXBsZSAm
cXVvdDtvciZxdW90Oywgc2hpZnQgaXQgcGllY2Utd2lzZSAqLyBcPGJyPg0KwqAgwqAgwqAgwqAg
dGhpc191bml0ID0gc3RhcnRfdW5pdDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCBpZiAoc3RhcnRf
dW5pdCA9PSBlbmRfdW5pdCAtIDEpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXNrID0gfigofih0
eXBlKSAwKSAmbHQ7Jmx0OyAoX19zdGFydCAlIHRzKSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sgPSBfYnRfbWFrZV9tYXNrKHR5cGUs
IF9fc3RhcnQgJSB0cyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaWYgKGVuZCAlIHRzKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sgfD0gKH4odHlwZSkgMCkgJmx0OyZsdDsgKGVuZCAlIHRz
KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY21h
c2sgPSAodHlwZSkgX192ICZsdDsmbHQ7IChfX3N0YXJ0ICUgdHMpO8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1h
c2sgfD0gX2J0X21ha2VfbWFza19jb21wbGVtZW50KHR5cGUsIGVuZCAlIHRzKTsgXDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNtYXNrID0gX2J0X2xzaGlmdCgodHlwZSkgKF9fdiksIF9f
c3RhcnQgJSB0cyk7wqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Y21hc2sgJmFtcDs9IH5tYXNrO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9f
cHRyW3RoaXNfdW5pdF0gJmFtcDs9IG1hc2s7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19wdHJbdGhp
c191bml0XSB8PSBjbWFzazvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPg0KQEAgLTEyNCwyMiArMjMyLDIyIEBAIGRvIHvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgfcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIGlmIChfX3N0
YXJ0ICUgdHMpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjc2hp
ZnQgPSBfX3N0YXJ0ICUgdHM7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sgPSB+KCh+KHR5
cGUpIDApICZsdDsmbHQ7IGNzaGlmdCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNtYXNrID0gKHR5cGUpIF9fdiAmbHQ7
Jmx0OyBjc2hpZnQ7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWFzayA9IF9idF9tYWtlX21hc2sodHlwZSwgY3No
aWZ0KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjbWFzayA9IF9idF9sc2hpZnQoKHR5cGUpIChfX3YpLCBjc2hpZnQpO8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNtYXNrICZh
bXA7PSB+bWFzazvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX3B0clt0aGlz
X3VuaXRdICZhbXA7PSBtYXNrO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9fcHRyW3RoaXNfdW5pdF0g
fD0gY21hc2s7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiA9IF9idF9waWVjZXdpc2VfcnNoaWZ0KF9f
diwgdHMgLSBjc2hpZnQpO8KgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoF9idF9zYWZlX3JzaGlmdChfX3YsIHRzIC0gY3NoaWZ0KTvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19zdGFydCAr
PSB0cyAtIGNzaGlmdDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0aGlzX3VuaXQrKzvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPg0KwqAgwqAgwqAgwqAgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCsKgIMKgIMKgIMKgIGZvciAoOyB0aGlzX3VuaXQgJmx0OyBlbmRfdW5pdCAtIDE7
IHRoaXNfdW5pdCsrKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgX19wdHJbdGhpc191bml0XSA9ICh0eXBlKSBfX3Y7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oF9fdiA9IF9idF9waWVjZXdpc2VfcnNoaWZ0KF9fdiwgdHMpO8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfYnRfc2FmZV9yc2hpZnQo
X192LCB0cyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19zdGFydCArPSB0czvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0K
wqAgwqAgwqAgwqAgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4N
CsKgIMKgIMKgIMKgIGlmIChlbmQgJSB0cykge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sgPSAofih0eXBlKSAwKSAmbHQ7Jmx0OyAoZW5kICUgdHMp
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG1hc2sgPSBfYnRfbWFrZV9tYXNrX2NvbXBsZW1lbnQodHlwZSwgZW5kICUgdHMp
O8KgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbWFzayA9ICh0eXBl
KSBfX3Y7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY21hc2sgJmFtcDs9IH5tYXNrO8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9fcHRyW3RoaXNfdW5pdF0gJmFtcDs9
IG1hc2s7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJy
Pg0KQEAgLTE1MCw3ICsyNTgsNyBAQCBkbyB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCjxicj4NCsKgI2RlZmluZSBfYnRfYml0ZmllbGRf
d3JpdGVfYmUoX3B0ciwgdHlwZSwgX3N0YXJ0LCBfbGVuZ3RoLCBfdinCoCDCoCDCoCDCoCDCoFw8
YnI+DQrCoGRvIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8
YnI+DQotwqAgwqAgwqAgwqB0eXBlb2YoX3YpIF9fdiA9IChfdik7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDC
oCDCoCDCoF9fdHlwZW9mX18oX3YpIF9fdiA9IChfdik7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIHR5cGUg
Kl9fcHRyID0gKHZvaWQgKikgKF9wdHIpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCB1bnNpZ25lZCBsb25nIF9fc3Rh
cnQgPSAoX3N0YXJ0KSwgX19sZW5ndGggPSAoX2xlbmd0aCk7wqAgwqAgwqAgwqAgwqBcPGJyPg0K
wqAgwqAgwqAgwqAgdHlwZSBtYXNrLCBjbWFzazvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQpAQCAtMTY3
LDE1ICsyNzUsMTUgQEAgZG8ge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgLyogVHJpbSB2IGhpZ2ggYml0cyAqL8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQrCoCDCoCDCoCDCoCBpZiAoX19sZW5ndGggJmx0OyBzaXplb2YoX192KSAqIENIQVJf
QklUKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBfX3YgJmFtcDs9IH4oKH4odHlwZW9mKF9fdikpIDApICZsdDsmbHQ7
IF9fbGVuZ3RoKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBfX3YgJmFtcDs9IF9idF9tYWtlX21hc2soX190eXBlb2ZfXyhfX3YpLCBfX2xlbmd0
aCk7wqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCAvKiBXZSBjYW4gbm93IGFwcGVuZCB2
IHdpdGggYSBzaW1wbGUgJnF1b3Q7b3ImcXVvdDssIHNoaWZ0IGl0IHBpZWNlLXdpc2UgKi8gXDxi
cj4NCsKgIMKgIMKgIMKgIHRoaXNfdW5pdCA9IGVuZF91bml0IC0gMTvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDC
oCDCoCBpZiAoc3RhcnRfdW5pdCA9PSBlbmRfdW5pdCAtIDEpIHvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBtYXNrID0gfigofih0eXBlKSAwKSAmbHQ7Jmx0OyAoKHRzIC0gKGVuZCAlIHRzKSkgJSB0cykp
O8KgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXNrID0gX2J0X21ha2Vf
bWFzayh0eXBlLCAodHMgLSAoZW5kICUgdHMpKSAlIHRzKTvCoCDCoCDCoFw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBpZiAoX19zdGFydCAlIHRzKcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sgfD0gKH4oKHR5cGUpIDApKSAmbHQ7Jmx0OyAodHMg
LSAoX19zdGFydCAlIHRzKSk7IFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbWFzayA9
ICh0eXBlKSBfX3YgJmx0OyZsdDsgKCh0cyAtIChlbmQgJSB0cykpICUgdHMpO8KgIMKgIMKgIMKg
IMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sgfD0gX2J0
X21ha2VfbWFza19jb21wbGVtZW50KHR5cGUsIHRzIC0gKF9fc3RhcnQgJSB0cykpOyBcPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY21hc2sgPSBfYnRfbHNoaWZ0KCh0eXBlKSAoX192KSwg
KHRzIC0gKGVuZCAlIHRzKSkgJSB0cyk7IFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBj
bWFzayAmYW1wOz0gfm1hc2s7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19w
dHJbdGhpc191bml0XSAmYW1wOz0gbWFzazvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX3B0clt0aGlz
X3VuaXRdIHw9IGNtYXNrO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFw8YnI+DQpAQCAtMTgzLDIyICsyOTEsMjIgQEAgZG8ge8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCB9wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgaWYgKGVuZCAl
IHRzKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3No
aWZ0ID0gZW5kICUgdHM7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sgPSB+KCh+
KHR5cGUpIDApICZsdDsmbHQ7ICh0cyAtIGNzaGlmdCkpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNtYXNrID0gKHR5cGUpIF9fdiAmbHQ7
Jmx0OyAodHMgLSBjc2hpZnQpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXNrID0gX2J0X21ha2VfbWFzayh0eXBlLCB0cyAtIGNz
aGlmdCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGNtYXNrID0gX2J0X2xzaGlmdCgodHlwZSkgKF9fdiksIHRzIC0gY3NoaWZ0KTvCoCDCoCDC
oCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY21hc2sgJmFtcDs9IH5tYXNr
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9fcHRyW3RoaXNfdW5pdF0gJmFt
cDs9IG1hc2s7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19wdHJbdGhpc191bml0XSB8PSBjbWFzazvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgX192ID0gX2J0X3BpZWNld2lzZV9yc2hpZnQoX192LCBjc2hpZnQp
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBf
YnRfc2FmZV9yc2hpZnQoX192LCBjc2hpZnQpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVuZCAtPSBjc2hpZnQ7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRoaXNfdW5pdC0tO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQrCoCDCoCDCoCDCoCB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBcPGJyPg0KwqAgwqAgwqAgwqAgZm9yICg7IChsb25nKSB0aGlzX3VuaXQgJmd0Oz0gKGxvbmcp
IHN0YXJ0X3VuaXQgKyAxOyB0aGlzX3VuaXQtLSkgeyBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgX19wdHJbdGhpc191bml0XSA9ICh0eXBlKSBfX3Y7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiA9IF9i
dF9waWVjZXdpc2VfcnNoaWZ0KF9fdiwgdHMpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfYnRfc2FmZV9yc2hpZnQoX192LCB0cyk7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZW5kIC09IHRzO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDC
oCDCoCB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAg
wqAgwqAgaWYgKF9fc3RhcnQgJSB0cykge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG1hc2sgPSAofih0eXBlKSAwKSAmbHQ7Jmx0OyAodHMgLSAoX19zdGFydCAlIHRz
KSk7wqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sg
PSBfYnRfbWFrZV9tYXNrX2NvbXBsZW1lbnQodHlwZSwgdHMgLSAoX19zdGFydCAlIHRzKSk7IFw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbWFzayA9ICh0eXBlKSBfX3Y7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgY21hc2sgJmFtcDs9IH5tYXNrO8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIF9fcHRyW3RoaXNfdW5pdF0gJmFtcDs9IG1hc2s7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KQEAgLTI0Myw4ICsz
NTEsOCBAQCBkbyB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgXDxicj4NCjxicj4NCsKgI2RlZmluZSBfYnRfYml0ZmllbGRfcmVhZF9sZShfcHRyLCB0
eXBlLCBfc3RhcnQsIF9sZW5ndGgsIF92cHRyKcKgIMKgIMKgIMKgXDxicj4NCsKgZG8ge8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDC
oHR5cGVvZigqKF92cHRyKSkgKl9fdnB0ciA9IChfdnB0cik7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgdHlwZW9mKCpfX3ZwdHIp
IF9fdjvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgX190eXBlb2ZfXygqKF92cHRyKSkgKl9f
dnB0ciA9IChfdnB0cik7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJy
Pg0KK8KgIMKgIMKgIMKgX190eXBlb2ZfXygqX192cHRyKSBfX3Y7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKg
IMKgIHR5cGUgKl9fcHRyID0gKHZvaWQgKikgKF9wdHIpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCB1bnNpZ25lZCBs
b25nIF9fc3RhcnQgPSAoX3N0YXJ0KSwgX19sZW5ndGggPSAoX2xlbmd0aCk7wqAgwqAgwqAgwqAg
wqBcPGJyPg0KwqAgwqAgwqAgwqAgdHlwZSBtYXNrLCBjbWFzazvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
DQpAQCAtMjUyLDEwICszNjAsNiBAQCBkbyB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgdW5zaWduZWQgbG9uZyBzdGFy
dF91bml0LCBlbmRfdW5pdCwgdGhpc191bml0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQrCoCDCoCDCoCDCoCB1bnNpZ25lZCBsb25nIGVuZCwgY3NoaWZ0OyAvKiBjc2hpZnQgaXMg
JnF1b3Q7Y29tcGxlbWVudCBzaGlmdCZxdW90OyAqL8KgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqB7
IF9idF9jaGVja19tYXhfNjRiaXQodHlwZSk7IH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgeyBfYnRfY2hlY2tfbWF4
XzY0Yml0KHR5cGVvZigqX3ZwdHIpKTsgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFw8YnI+DQotwqAgwqAgwqAgwqB7IF9idF9jaGVja19tYXhfNjRiaXQodHlwZW9mKCpfcHRy
KSk7IH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAg
wqAgwqAgaWYgKCFfX2xlbmd0aCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAqX192cHRyID0gMDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgYnJlYWs7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCkBAIC0yNjYsNTYgKzM3MCw1NiBA
QCBkbyB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCsKgIMKgIMKgIMKgIGVuZF91bml0ID0gKGVuZCArICh0cyAtIDEpKSAvIHRzO8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDC
oCB0aGlzX3VuaXQgPSBlbmRfdW5pdCAtIDE7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgaWYgKF9idF9p
c19zaWduZWRfdHlwZSh0eXBlb2YoX192KSnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAmYW1wOyZhbXA7IChfX3B0clt0
aGlzX3VuaXRdICZhbXA7ICgodHlwZSkgMSAmbHQ7Jmx0OyAoKGVuZCAlIHRzID8gOiB0cykgLSAx
KSkpKSBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX192ID0gfih0eXBlb2YoX192KSkg
MDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
DQorwqAgwqAgwqAgwqBpZiAoX2J0X2lzX3NpZ25lZF90eXBlKF9fdHlwZW9mX18oX192KSnCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAmYW1wOyZhbXA7IChfX3B0clt0aGlzX3VuaXRdICZhbXA7IF9idF9sc2hpZnQoKHR5cGUpIDEs
IChlbmQgJSB0cyA/IGVuZCAlIHRzIDogdHMpIC0gMSkpKSBcPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgX192ID0gfihfX3R5cGVvZl9fKF9fdikpIDA7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgZWxzZcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX3Yg
PSAwO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCBpZiAoc3RhcnRfdW5pdCA9PSBl
bmRfdW5pdCAtIDEpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbWFzayA9IF9fcHRyW3RoaXNfdW5p
dF07wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY21hc2sgJmd0OyZndDs9IChfX3N0YXJ0ICUgdHMpO8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGNtYXNrID0gX2J0X3JzaGlmdChjbWFzaywgX19zdGFydCAlIHRz
KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
aWYgKChlbmQgLSBfX3N0YXJ0KSAlIHRzKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
bWFzayA9IH4oKH4odHlwZSkgMCkgJmx0OyZsdDsgKGVuZCAtIF9fc3RhcnQpKTvCoCDCoCDCoCDC
oFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXNrID0gX2J0X21h
a2VfbWFzayh0eXBlLCBlbmQgLSBfX3N0YXJ0KTvCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY21hc2sgJmFtcDs9IG1hc2s7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBfX3YgPSBfYnRfcGllY2V3aXNlX2xzaGlmdChfX3YsIGVuZCAtIF9fc3RhcnQp
O8KgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiB8PSBfYnRf
dW5zaWduZWRfY2FzdCh0eXBlb2YoX192KSwgY21hc2spO8KgIMKgIMKgIMKgIMKgIMKgXDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9idF9zYWZlX2xzaGlmdChfX3YsIGVuZCAtIF9fc3Rh
cnQpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBfX3YgfD0gX2J0X2Nhc3RfdmFsdWVfdG9fdW5zaWduZWRfdHlwZShfX3R5cGVvZl9f
KF9fdiksIGNtYXNrKTsgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICpfX3ZwdHIgPSBf
X3Y7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgaWYgKGVuZCAlIHRzKSB7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3NoaWZ0ID0gZW5kICUgdHM7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sgPSB+KCh+KHR5cGUpIDApICZsdDsmbHQ7IGNz
aGlmdCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoG1hc2sgPSBfYnRfbWFrZV9tYXNrKHR5cGUsIGNzaGlmdCk7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Y21hc2sgPSBfX3B0clt0aGlzX3VuaXRdO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNtYXNrICZhbXA7
PSBtYXNrO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX3YgPSBfYnRfcGll
Y2V3aXNlX2xzaGlmdChfX3YsIGNzaGlmdCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiB8PSBfYnRfdW5zaWduZWRfY2FzdCh0eXBlb2Yo
X192KSwgY21hc2spO8KgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoF9idF9zYWZlX2xzaGlmdChfX3YsIGNzaGlmdCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX192IHw9IF9i
dF9jYXN0X3ZhbHVlX3RvX3Vuc2lnbmVkX3R5cGUoX190eXBlb2ZfXyhfX3YpLCBjbWFzayk7IFw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbmQgLT0gY3NoaWZ0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0aGlzX3VuaXQtLTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAg
wqAgwqAgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKg
IMKgIMKgIGZvciAoOyAobG9uZykgdGhpc191bml0ICZndDs9IChsb25nKSBzdGFydF91bml0ICsg
MTsgdGhpc191bml0LS0pIHsgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiA9IF9i
dF9waWVjZXdpc2VfbHNoaWZ0KF9fdiwgdHMpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX3YgfD0gX2J0X3Vuc2lnbmVkX2Nhc3Qo
dHlwZW9mKF9fdiksIF9fcHRyW3RoaXNfdW5pdF0pO1w8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBfYnRfc2FmZV9sc2hpZnQoX192LCB0cyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX192IHw9
IF9idF9jYXN0X3ZhbHVlX3RvX3Vuc2lnbmVkX3R5cGUoX190eXBlb2ZfXyhfX3YpLCBfX3B0clt0
aGlzX3VuaXRdKTsgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVuZCAtPSB0czvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIGlmIChfX3N0YXJ0ICUgdHMpIHvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXNrID0gfigofih0eXBlKSAwKSAmbHQ7
Jmx0OyAodHMgLSAoX19zdGFydCAlIHRzKSkpO8KgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoG1hc2sgPSBfYnRfbWFrZV9tYXNrKHR5cGUsIHRzIC0gKF9fc3RhcnQg
JSB0cykpO8KgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbWFzayA9
IF9fcHRyW3RoaXNfdW5pdF07wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY21hc2sgJmd0OyZndDs9IChf
X3N0YXJ0ICUgdHMpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNtYXNrID0gX2J0X3JzaGlmdChjbWFz
aywgX19zdGFydCAlIHRzKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgY21hc2sgJmFtcDs9IG1hc2s7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoF9fdiA9IF9idF9waWVjZXdpc2VfbHNoaWZ0KF9fdiwgdHMgLSAoX19zdGFy
dCAlIHRzKSk7wqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX192IHw9IF9idF91
bnNpZ25lZF9jYXN0KHR5cGVvZihfX3YpLCBjbWFzayk7wqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX2J0X3NhZmVfbHNoaWZ0KF9fdiwgdHMgLSAoX19zdGFy
dCAlIHRzKSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoF9fdiB8PSBfYnRfY2FzdF92YWx1ZV90b191bnNpZ25lZF90eXBlKF9fdHlwZW9mX18oX192
KSwgY21hc2spOyBcPGJyPg0KwqAgwqAgwqAgwqAgfSBlbHNlIHvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX192ID0gX2J0X3BpZWNld2lz
ZV9sc2hpZnQoX192LCB0cyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiB8PSBfYnRfdW5zaWduZWRfY2FzdCh0eXBlb2YoX192
KSwgX19wdHJbdGhpc191bml0XSk7XDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9idF9z
YWZlX2xzaGlmdChfX3YsIHRzKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX3YgfD0gX2J0X2Nhc3Rf
dmFsdWVfdG9fdW5zaWduZWRfdHlwZShfX3R5cGVvZl9fKF9fdiksIF9fcHRyW3RoaXNfdW5pdF0p
OyBcPGJyPg0KwqAgwqAgwqAgwqAgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCsKgIMKgIMKgIMKgICpfX3ZwdHIgPSBfX3Y7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCsKgfSB3aGlsZSAoMCk8YnI+DQo8YnI+DQrCoCNkZWZpbmUgX2J0X2JpdGZpZWxkX3JlYWRf
YmUoX3B0ciwgdHlwZSwgX3N0YXJ0LCBfbGVuZ3RoLCBfdnB0cinCoCDCoCDCoCDCoFw8YnI+DQrC
oGRvIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQot
wqAgwqAgwqAgwqB0eXBlb2YoKihfdnB0cikpICpfX3ZwdHIgPSAoX3ZwdHIpO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoHR5cGVv
ZigqX192cHRyKSBfX3Y7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoF9fdHlwZW9mX18oKihf
dnB0cikpICpfX3ZwdHIgPSAoX3ZwdHIpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoF9fdHlwZW9mX18oKl9fdnB0cikgX192O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+
DQrCoCDCoCDCoCDCoCB0eXBlICpfX3B0ciA9ICh2b2lkICopIChfcHRyKTvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAg
dW5zaWduZWQgbG9uZyBfX3N0YXJ0ID0gKF9zdGFydCksIF9fbGVuZ3RoID0gKF9sZW5ndGgpO8Kg
IMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIHR5cGUgbWFzaywgY21hc2s7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBcPGJyPg0KQEAgLTMyMywxMCArNDI3LDYgQEAgZG8ge8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIHVuc2lnbmVk
IGxvbmcgc3RhcnRfdW5pdCwgZW5kX3VuaXQsIHRoaXNfdW5pdDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgdW5zaWduZWQgbG9uZyBlbmQsIGNzaGlmdDsgLyog
Y3NoaWZ0IGlzICZxdW90O2NvbXBsZW1lbnQgc2hpZnQmcXVvdDsgKi/CoCDCoFw8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKg
IMKgIMKgIMKgeyBfYnRfY2hlY2tfbWF4XzY0Yml0KHR5cGUpOyB9wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoHsgX2J0
X2NoZWNrX21heF82NGJpdCh0eXBlb2YoKl92cHRyKSk7IH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgeyBfYnRfY2hlY2tfbWF4XzY0Yml0KHR5
cGVvZigqX3B0cikpOyB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj4NCsKgIMKgIMKgIMKgIGlmICghX19sZW5ndGgpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKl9fdnB0ciA9IDA7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGJyZWFrO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQpAQCAtMzM3LDQ4
ICs0MzcsNDggQEAgZG8ge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCBlbmRfdW5pdCA9IChlbmQgKyAodHMgLSAxKSkgLyB0
czvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0K
wqAgwqAgwqAgwqAgdGhpc191bml0ID0gc3RhcnRfdW5pdDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAg
wqBpZiAoX2J0X2lzX3NpZ25lZF90eXBlKHR5cGVvZihfX3YpKcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCZhbXA7JmFt
cDsgKF9fcHRyW3RoaXNfdW5pdF0gJmFtcDsgKCh0eXBlKSAxICZsdDsmbHQ7ICh0cyAtIChfX3N0
YXJ0ICUgdHMpIC0gMSkpKSkgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiA9IH4o
dHlwZW9mKF9fdikpIDA7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgaWYgKF9idF9pc19zaWduZWRfdHlwZShfX3R5cGVv
Zl9fKF9fdikpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgJmFtcDsmYW1wOyAoX19wdHJbdGhpc191bml0XSAmYW1wOyBfYnRfbHNo
aWZ0KCh0eXBlKSAxLCB0cyAtIChfX3N0YXJ0ICUgdHMpIC0gMSkpKSBcPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgX192ID0gfihfX3R5cGVvZl9fKF9fdikpIDA7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgZWxzZcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBfX3YgPSAwO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCBpZiAoc3RhcnRfdW5p
dCA9PSBlbmRfdW5pdCAtIDEpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbWFzayA9IF9fcHRyW3Ro
aXNfdW5pdF07wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY21hc2sgJmd0OyZndDs9ICh0cyAtIChlbmQg
JSB0cykpICUgdHM7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY21hc2sgPSBfYnRfcnNoaWZ0KGNtYXNrLCAodHMgLSAoZW5k
ICUgdHMpKSAlIHRzKTvCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYg
KChlbmQgLSBfX3N0YXJ0KSAlIHRzKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWFz
ayA9IH4oKH4odHlwZSkgMCkgJmx0OyZsdDsgKGVuZCAtIF9fc3RhcnQpKTvCoCDCoCDCoCDCoFw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXNrID0gX2J0X21ha2Vf
bWFzayh0eXBlLCBlbmQgLSBfX3N0YXJ0KTvCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgY21hc2sgJmFtcDs9IG1hc2s7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBfX3YgPSBfYnRfcGllY2V3aXNlX2xzaGlmdChfX3YsIGVuZCAtIF9fc3RhcnQpO8Kg
IMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiB8PSBfYnRfdW5z
aWduZWRfY2FzdCh0eXBlb2YoX192KSwgY21hc2spO8KgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9idF9zYWZlX2xzaGlmdChfX3YsIGVuZCAtIF9fc3RhcnQp
O8KgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX3YgfD0g
X2J0X2Nhc3RfdmFsdWVfdG9fdW5zaWduZWRfdHlwZShfX3R5cGVvZl9fKF9fdiksIGNtYXNrKTsg
XDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICpfX3ZwdHIgPSBfX3Y7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrC
oCDCoCDCoCDCoCB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0K
wqAgwqAgwqAgwqAgaWYgKF9fc3RhcnQgJSB0cykge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGNzaGlmdCA9IF9fc3RhcnQgJSB0czvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgbWFzayA9IH4oKH4odHlwZSkgMCkgJmx0OyZsdDsgKHRzIC0gY3NoaWZ0KSk7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWFzayA9
IF9idF9tYWtlX21hc2sodHlwZSwgdHMgLSBjc2hpZnQpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbWFzayA9IF9fcHRyW3RoaXNfdW5pdF07
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgY21hc2sgJmFtcDs9IG1hc2s7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoF9fdiA9IF9idF9waWVjZXdpc2VfbHNoaWZ0KF9fdiwgdHMgLSBj
c2hpZnQpO8KgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9f
diB8PSBfYnRfdW5zaWduZWRfY2FzdCh0eXBlb2YoX192KSwgY21hc2spO8KgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9idF9zYWZlX2xzaGlmdChfX3YsIHRz
IC0gY3NoaWZ0KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgX192IHw9IF9idF9jYXN0X3ZhbHVlX3RvX3Vuc2lnbmVkX3R5cGUo
X190eXBlb2ZfXyhfX3YpLCBjbWFzayk7IFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBf
X3N0YXJ0ICs9IHRzIC0gY3NoaWZ0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRoaXNfdW5pdCsr
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCB9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgZm9yICg7IHRoaXNfdW5pdCAmbHQ7IGVuZF91
bml0IC0gMTsgdGhpc191bml0KyspIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX3YgPSBfYnRfcGllY2V3aXNlX2xzaGlmdChfX3YsIHRz
KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgX192IHw9IF9idF91bnNpZ25lZF9jYXN0KHR5cGVvZihfX3YpLCBfX3B0clt0aGlzX3Vu
aXRdKTtcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX2J0X3NhZmVfbHNoaWZ0KF9fdiwg
dHMpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fdiB8PSBfYnRfY2FzdF92YWx1ZV90b191bnNpZ25l
ZF90eXBlKF9fdHlwZW9mX18oX192KSwgX19wdHJbdGhpc191bml0XSk7IFw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBfX3N0YXJ0ICs9IHRzO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCB9
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAg
aWYgKGVuZCAlIHRzKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgbWFzayA9IH4oKH4odHlwZSkgMCkgJmx0OyZsdDsgKGVuZCAlIHRzKSk7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hc2sg
PSBfYnRfbWFrZV9tYXNrKHR5cGUsIGVuZCAlIHRzKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjbWFzayA9IF9fcHRyW3RoaXNfdW5p
dF07wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY21hc2sgJmd0OyZndDs9IHRzIC0gKGVuZCAlIHRzKTvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgY21hc2sgPSBfYnRfcnNoaWZ0KGNtYXNrLCB0cyAtIChlbmQgJSB0
cykpO8KgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNt
YXNrICZhbXA7PSBtYXNrO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX3Yg
PSBfYnRfcGllY2V3aXNlX2xzaGlmdChfX3YsIGVuZCAlIHRzKTvCoCDCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX192IHw9IF9idF91bnNpZ25lZF9jYXN0
KHR5cGVvZihfX3YpLCBjbWFzayk7wqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgX2J0X3NhZmVfbHNoaWZ0KF9fdiwgZW5kICUgdHMpO8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9f
diB8PSBfYnRfY2FzdF92YWx1ZV90b191bnNpZ25lZF90eXBlKF9fdHlwZW9mX18oX192KSwgY21h
c2spOyBcPGJyPg0KwqAgwqAgwqAgwqAgfSBlbHNlIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX192ID0gX2J0X3BpZWNld2lzZV9sc2hp
ZnQoX192LCB0cyk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoF9fdiB8PSBfYnRfdW5zaWduZWRfY2FzdCh0eXBlb2YoX192KSwgX19w
dHJbdGhpc191bml0XSk7XDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9idF9zYWZlX2xz
aGlmdChfX3YsIHRzKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX3YgfD0gX2J0X2Nhc3RfdmFsdWVf
dG9fdW5zaWduZWRfdHlwZShfX3R5cGVvZl9fKF9fdiksIF9fcHRyW3RoaXNfdW5pdF0pOyBcPGJy
Pg0KwqAgwqAgwqAgwqAgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj4NCsKgIMKgIMKgIMKgICpfX3ZwdHIgPSBfX3Y7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKg
fSB3aGlsZSAoMCk8YnI+DQpkaWZmIC0tZ2l0IGEvcGx1Z2lucy90ZXh0L3ByZXR0eS9wcmludC5j
IGIvcGx1Z2lucy90ZXh0L3ByZXR0eS9wcmludC5jPGJyPg0KaW5kZXggOTUxODlkNWUuLmMzNmE2
ZTgxIDEwMDY0NDxicj4NCi0tLSBhL3BsdWdpbnMvdGV4dC9wcmV0dHkvcHJpbnQuYzxicj4NCisr
KyBiL3BsdWdpbnMvdGV4dC9wcmV0dHkvcHJpbnQuYzxicj4NCkBAIC01NDYsMTAgKzU0NiwxMCBA
QCBpbnQgcHJpbnRfaW50ZWdlcihzdHJ1Y3QgcHJldHR5X2NvbXBvbmVudCAqcHJldHR5LDxicj4N
Cjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxlbiA9IGJ0X2ZpZWxkX2NsYXNzX2ludGVn
ZXJfZ2V0X2ZpZWxkX3ZhbHVlX3JhbmdlKGludF9mYyk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZ19zdHJpbmdfYXBwZW5kKHByZXR0eS0mZ3Q7c3RyaW5nLCAmcXVvdDswYiZxdW90Oyk7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdi51ID0gX2J0X3BpZWNld2lzZV9sc2hpZnQo
di51LCA2NCAtIGxlbik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX2J0X3NhZmVfbHNo
aWZ0KHYudSwgNjQgLSBsZW4pOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZvciAoYml0
bnIgPSAwOyBiaXRuciAmbHQ7IGxlbjsgYml0bnIrKykgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYocHJldHR5LSZndDtzdHJp
bmcsICZxdW90OyV1JnF1b3Q7LCAodi51ICZhbXA7ICgxVUxMICZsdDsmbHQ7IDYzKSkgPyAxIDog
MCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdi51ID0gX2J0X3Bp
ZWNld2lzZV9sc2hpZnQodi51LCAxKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBfYnRfc2FmZV9sc2hpZnQodi51LCAxKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KwqAgwqAgwqAg
wqAgfTxicj4NCi0tIDxicj4NCjIuMTEuMDxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48
YnIgY2xlYXI9ImFsbCI+PGJyPi0tIDxicj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWwtbV8t
NjMwOTc1OTQzMjIxMzY3NjIxNWdtYWlsLW1fLTUzNjUxODE2MjA5MjI0NTIwNTRnbWFpbF9zaWdu
YXR1cmUiPkrDqXLDqW1pZSBHYWxhcm5lYXU8YnI+RWZmaWNpT1MgSW5jLjxicj48YSBocmVmPSJo
dHRwOi8vd3d3LmVmZmljaW9zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cuZWZmaWNp
b3MuY29tPC9hPjwvZGl2Pg0K
--000000000000ae95a105891b7444--

--===============1827548165829402597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1827548165829402597==--
