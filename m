From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace 1/1] Fix: test_bitfield: buffer
 overrun accesses
Date: Tue, 21 May 2019 16:15:53 -0400
Message-ID: <20190521201552.GA18700__31249.8703411379$1558469774$gmane$org@gmail.com>
References: <20190518202523.23618-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by lists.lttng.org (Postfix) with ESMTPS id 457n8F2B0Gz10VH
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 16:15:56 -0400 (EDT)
Received: by mail-qk1-f196.google.com with SMTP id w25so20813qkj.11
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 13:15:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190518202523.23618-1-mathieu.desnoyers@efficios.com>
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
Cc: simon.marchi@efficios.com, jgalar@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.0.

Thanks!
J=E9r=E9mie

On Sat, May 18, 2019 at 04:25:23PM -0400, Mathieu Desnoyers wrote:
> This issue is due to a type mismatch between union member vs type passed
> as parameter to the macros as found by Coverity:
> =

> ** CID 1401409:  Memory - corruptions  (OVERRUN)
> /tests/lib/test_bitfield.c: 450 in run_test_signed_write()
> =

> Issue introduced by commit 0675eb8c07 "Extend test_bitfield coverage"
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Change-Id: I14c9d69011b369e5dc8be4305ac8bf32cc86d3dd
> ---
>  tests/lib/test_bitfield.c | 64 +++++++++++++++++++++++------------------=
------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> =

> diff --git a/tests/lib/test_bitfield.c b/tests/lib/test_bitfield.c
> index 5ba566f6..bc61e118 100644
> --- a/tests/lib/test_bitfield.c
> +++ b/tests/lib/test_bitfield.c
> @@ -285,32 +285,32 @@ void run_test_unsigned_read(unsigned int src_ui, un=
signed long long src_ull)
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.s, unsigned char, s, l, src_ui);
> -			bt_bitfield_read(target.c, unsigned short, s, l, &readval_ui);
> +			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
> +			bt_bitfield_read(target.s, unsigned short, s, l, &readval_ui);
>  			if (check_result(src_ui, readval_ui, target.c, unsigned short,
>  					s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.i, unsigned char, s, l, src_ui);
> -			bt_bitfield_read(target.c, unsigned int, s, l, &readval_ui);
> +			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
> +			bt_bitfield_read(target.i, unsigned int, s, l, &readval_ui);
>  			if (check_result(src_ui, readval_ui, target.c, unsigned int,
>  					s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.l, unsigned char, s, l, src_ui);
> -			bt_bitfield_read(target.c, unsigned long, s, l, &readval_ui);
> +			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
> +			bt_bitfield_read(target.l, unsigned long, s, l, &readval_ui);
>  			if (check_result(src_ui, readval_ui, target.c, unsigned long,
>  					s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.ll, unsigned char, s, l, src_ui);
> -			bt_bitfield_read(target.c, unsigned long long, s, l, &readval_ui);
> +			bt_bitfield_write(target.c, unsigned char, s, l, src_ui);
> +			bt_bitfield_read(target.ll, unsigned long long, s, l, &readval_ui);
>  			if (check_result(src_ui, readval_ui, target.c, unsigned long long,
>  					s, l, UNSIGNED_INT_READ_TEST_DESC_FMT_STR)) {
>  				return;
> @@ -333,32 +333,32 @@ void run_test_unsigned_read(unsigned int src_ui, un=
signed long long src_ull)
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.s, unsigned char, s, l, src_ull);
> -			bt_bitfield_read(target.c, unsigned short, s, l, &readval_ull);
> +			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
> +			bt_bitfield_read(target.s, unsigned short, s, l, &readval_ull);
>  			if (check_result(src_ull, readval_ull, target.c, unsigned short,
>  					s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.i, unsigned char, s, l, src_ull);
> -			bt_bitfield_read(target.c, unsigned int, s, l, &readval_ull);
> +			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
> +			bt_bitfield_read(target.i, unsigned int, s, l, &readval_ull);
>  			if (check_result(src_ull, readval_ull, target.c, unsigned int,
>  					s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.l, unsigned char, s, l, src_ull);
> -			bt_bitfield_read(target.c, unsigned long, s, l, &readval_ull);
> +			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
> +			bt_bitfield_read(target.l, unsigned long, s, l, &readval_ull);
>  			if (check_result(src_ull, readval_ull, target.c, unsigned long,
>  					s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.ll, unsigned char, s, l, src_ull);
> -			bt_bitfield_read(target.c, unsigned long long, s, l, &readval_ull);
> +			bt_bitfield_write(target.c, unsigned char, s, l, src_ull);
> +			bt_bitfield_read(target.ll, unsigned long long, s, l, &readval_ull);
>  			if (check_result(src_ull, readval_ull, target.c, unsigned long long,
>  					s, l, UNSIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
>  				return;
> @@ -520,32 +520,32 @@ void run_test_signed_read(int src_i, long long src_=
ll)
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.s, signed char, s, l, src_i);
> -			bt_bitfield_read(target.c, short, s, l, &readval_i);
> +			bt_bitfield_write(target.c, signed char, s, l, src_i);
> +			bt_bitfield_read(target.s, short, s, l, &readval_i);
>  			if (check_result(src_i, readval_i, target.c, short,
>  					s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.i, signed char, s, l, src_i);
> -			bt_bitfield_read(target.c, int, s, l, &readval_i);
> +			bt_bitfield_write(target.c, signed char, s, l, src_i);
> +			bt_bitfield_read(target.i, int, s, l, &readval_i);
>  			if (check_result(src_i, readval_i, target.c, int,
>  					s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.l, signed char, s, l, src_i);
> -			bt_bitfield_read(target.c, long, s, l, &readval_i);
> +			bt_bitfield_write(target.c, signed char, s, l, src_i);
> +			bt_bitfield_read(target.l, long, s, l, &readval_i);
>  			if (check_result(src_i, readval_i, target.c, long,
>  					s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.ll, signed char, s, l, src_i);
> -			bt_bitfield_read(target.c, long long, s, l, &readval_i);
> +			bt_bitfield_write(target.c, signed char, s, l, src_i);
> +			bt_bitfield_read(target.ll, long long, s, l, &readval_i);
>  			if (check_result(src_i, readval_i, target.c, long long,
>  					s, l, SIGNED_INT_READ_TEST_DESC_FMT_STR)) {
>  				return;
> @@ -571,32 +571,32 @@ void run_test_signed_read(int src_i, long long src_=
ll)
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.s, signed char, s, l, src_ll);
> -			bt_bitfield_read(target.c, short, s, l, &readval_ll);
> +			bt_bitfield_write(target.c, signed char, s, l, src_ll);
> +			bt_bitfield_read(target.s, short, s, l, &readval_ll);
>  			if (check_result(src_ll, readval_ll, target.c, short,
>  					s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.i, signed char, s, l, src_ll);
> -			bt_bitfield_read(target.c, int, s, l, &readval_ll);
> +			bt_bitfield_write(target.c, signed char, s, l, src_ll);
> +			bt_bitfield_read(target.i, int, s, l, &readval_ll);
>  			if (check_result(src_ll, readval_ll, target.c, int,
>  					s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.l, signed char, s, l, src_ll);
> -			bt_bitfield_read(target.c, long, s, l, &readval_ll);
> +			bt_bitfield_write(target.c, signed char, s, l, src_ll);
> +			bt_bitfield_read(target.l, long, s, l, &readval_ll);
>  			if (check_result(src_ll, readval_ll, target.c, long,
>  					s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
>  				return;
>  			}
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.ll, signed char, s, l, src_ll);
> -			bt_bitfield_read(target.c, long long, s, l, &readval_ll);
> +			bt_bitfield_write(target.c, signed char, s, l, src_ll);
> +			bt_bitfield_read(target.ll, long long, s, l, &readval_ll);
>  			if (check_result(src_ll, readval_ll, target.c, long long,
>  					s, l, SIGNED_LONG_LONG_READ_TEST_DESC_FMT_STR)) {
>  				return;
> -- =

> 2.11.0
> =
