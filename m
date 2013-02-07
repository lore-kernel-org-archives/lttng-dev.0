From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace 1/1] Converted the unit tests
	to	the TAP format and moved the bitfield test
Date: Thu, 7 Feb 2013 12:45:26 -0500
Message-ID: <20130207174526.GA6632__4190.89050633392$1360259181$gmane$org@Krystal>
References: <1360257924-7460-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U3VXN-0001Ko-UC
	for lttng-dev@lists.lttng.org; Thu, 07 Feb 2013 12:45:30 -0500
Content-Disposition: inline
In-Reply-To: <1360257924-7460-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

some somments:

please use the present for your subject and patch description:

converted -> convert
moved -> move

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  tests/Makefile.am         |   4 -
>  tests/lib/Makefile.am     |   7 +-
>  tests/lib/runall.sh       |   5 +-
>  tests/lib/test-bitfield.c | 331 +++++++++++++++++++++++++++++++++++++++++
>  tests/lib/test-seeks.c    |   1 -
>  tests/runall.sh           |  97 +++++-------
>  tests/test-bitfield.c     | 371 ----------------------------------------=
------
>  7 files changed, 379 insertions(+), 437 deletions(-)
>  create mode 100644 tests/lib/test-bitfield.c
>  delete mode 100644 tests/test-bitfield.c
> =

> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 47891e9..816fa66 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -2,10 +2,6 @@ AM_CFLAGS =3D $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
>  =

>  SUBDIRS =3D lib
>  =

> -noinst_PROGRAMS =3D test-bitfield
> -
> -test_bitfield_SOURCES =3D test-bitfield.c
> -
>  EXTRA_DIST =3D runall.sh ctf-traces/**
>  =

>  check-am:
> diff --git a/tests/lib/Makefile.am b/tests/lib/Makefile.am
> index e9e264b..1e3d80f 100644
> --- a/tests/lib/Makefile.am
> +++ b/tests/lib/Makefile.am
> @@ -8,9 +8,14 @@ test_seeks_LDADD =3D libtestcommon.a \
>  	$(top_builddir)/lib/libbabeltrace.la \
>  	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la
>  =

> -noinst_PROGRAMS =3D test-seeks
> +test_bitfield_LDADD =3D libtestcommon.a \
> +	$(top_builddir)/lib/libbabeltrace.la \
> +	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la

why LDADD those libs for test_bitfield ?

> +
> +noinst_PROGRAMS =3D test-seeks test-bitfield
>  =

>  test_seeks_SOURCES =3D test-seeks.c
> +test_bitfield_SOURCES =3D test-bitfield.c
>  =

>  EXTRA_DIST =3D README.tap runall.sh
>  =

> diff --git a/tests/lib/runall.sh b/tests/lib/runall.sh
> index 34503bb..b5522ad 100755
> --- a/tests/lib/runall.sh
> +++ b/tests/lib/runall.sh
> @@ -3,4 +3,7 @@
>  # With a trace than contains empty packets
>  ./test-seeks ../ctf-traces/succeed/wk-heartbeat-u/ 1351532897586558519 1=
351532897591331194
>  # With a bigger trace
> -./test-seeks ../ctf-traces/succeed/lttng-modules-2.0-pre5/ 6133417452423=
4 61336381998396
> \ No newline at end of file
> +./test-seeks ../ctf-traces/succeed/lttng-modules-2.0-pre5/ 6133417452423=
4 61336381998396
> +
> +# run bitfield tests
> +./test-bitfield
> diff --git a/tests/lib/test-bitfield.c b/tests/lib/test-bitfield.c
> new file mode 100644
> index 0000000..58f0b5e
> --- /dev/null
> +++ b/tests/lib/test-bitfield.c
> @@ -0,0 +1,331 @@
> +/*
> + * test-bitfield.c
> + *
> + * BabelTrace - bitfield test program
> + *
> + * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; under version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, write to the Free Software Foundation, Inc=
.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#define _GNU_SOURCE
> +#include <babeltrace/bitfield.h>
> +#include <time.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include "tap.h"
> +
> +unsigned int glob;
> +
> +/*
> + * This function is only declared to show the size of a bitfield write in
> + * objdump.
> + */
> +void fct(void)
> +{
> +	bt_bitfield_write(&glob, unsigned int, 12, 15, 0x12345678);
> +}
> +
> +/* Test array size, in bytes */
> +#define TEST_LEN 128
> +#define NR_TESTS 10
> +#define TYPES_CNT 5
> +
> +unsigned int srcrand;
> +
> +#if defined(__i386) || defined(__x86_64)
> +
> +static inline int fls(int x)
> +{
> +	int r;
> +	asm("bsrl %1,%0\n\t"
> +		"cmovzl %2,%0"
> +		: "=3D&r" (r) : "rm" (x), "rm" (-1));
> +	return r + 1;
> +}
> +
> +#elif defined(__PPC__)
> +
> +static __inline__ int fls(unsigned int x)
> +{
> +	int lz;
> +
> +	asm ("cntlzw %0,%1" : "=3Dr" (lz) : "r" (x));
> +	return 32 - lz;
> +}
> +
> +#else
> +
> +static int fls(unsigned int x)
> +{
> +	int r =3D 32;
> +
> +	if (!x)
> +		return 0;
> +	if (!(x & 0xFFFF0000U)) {
> +		x <<=3D 16;
> +		r -=3D 16;
> +	}
> +	if (!(x & 0xFF000000U)) {
> +		x <<=3D 8;
> +		r -=3D 8;
> +	}
> +	if (!(x & 0xF0000000U)) {
> +		x <<=3D 4;
> +		r -=3D 4;
> +	}
> +	if (!(x & 0xC0000000U)) {
> +		x <<=3D 2;
> +		r -=3D 2;
> +	}
> +	if (!(x & 0x80000000U)) {
> +		x <<=3D 1;
> +		r -=3D 1;
> +	}
> +	return r;
> +}
> +
> +#endif
> +
> +#define print_byte_array(c, len)	\
> +do {					\
> +	unsigned long i;		\
> +					\
> +	for (i =3D 0; i < (len); i++) {	\
> +		printf("0x%X", (c)[i]);	\
> +		if (i !=3D (len) - 1)	\
> +			printf(" ");	\
> +	}				\
> +	printf("\n");			\
> +} while (0)
> +
> +#define init_byte_array(c, len, val)	\
> +do {					\
> +	unsigned long i;		\
> +					\
> +	for (i =3D 0; i < (len); i++)	\
> +		(c)[i] =3D (val);		\
> +} while (0)
> +
> +int run_test_unsigned()

is it me or the "(void") went away ? Even though C++ accepts this, it is
not good in C, as this is the same as "int run_test_unsigned(...)".

Please move the bitfield test into tests/lib/ in a separate patch,
without changing any code within the file.

Thanks,

Mathieu

> +{
> +	unsigned int src, nrbits;
> +	union {
> +		unsigned char c[TEST_LEN];
> +		unsigned short s[TEST_LEN/sizeof(unsigned short)];
> +		unsigned int i[TEST_LEN/sizeof(unsigned int)];
> +		unsigned long l[TEST_LEN/sizeof(unsigned long)];
> +		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
> +	} target;
> +	unsigned long long readval;
> +	unsigned int s, l;
> +	int err =3D 0;
> +
> +	src =3D srcrand;
> +	nrbits =3D fls(src);
> +
> +	for (s =3D 0; s < CHAR_BIT * TEST_LEN; s++) {
> +		for (l =3D nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
> +			init_byte_array(target.c, TEST_LEN, 0xFF);
> +			bt_bitfield_write(target.c, unsigned char, s, l, src);
> +			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			init_byte_array(target.c, TEST_LEN, 0xFF);
> +			bt_bitfield_write(target.s, unsigned short, s, l, src);
> +			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			init_byte_array(target.c, TEST_LEN, 0xFF);
> +			bt_bitfield_write(target.i, unsigned int, s, l, src);
> +			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			init_byte_array(target.c, TEST_LEN, 0xFF);
> +			bt_bitfield_write(target.l, unsigned long, s, l, src);
> +			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			init_byte_array(target.c, TEST_LEN, 0xFF);
> +			bt_bitfield_write(target.ll, unsigned long long, s, l, src);
> +			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			if (err) {
> +				goto end;
> +			}
> +		}
> +	}
> +end:
> +	ok(err =3D=3D 0, "Writing and reading back 0x%X, unsigned", src);
> +	if (err) {
> +		printf("# Failed with start=3D%i and length=3D%i\n", s, l);
> +	}
> +	return err;
> +}
> +
> +int run_test_signed()
> +{
> +	int src, nrbits;
> +	union {
> +		signed char c[TEST_LEN];
> +		short s[TEST_LEN/sizeof(short)];
> +		int i[TEST_LEN/sizeof(int)];
> +		long l[TEST_LEN/sizeof(long)];
> +		long long ll[TEST_LEN/sizeof(long long)];
> +	} target;
> +	long long readval;
> +	unsigned int s, l;
> +	int err =3D 0;
> +
> +	src =3D srcrand;
> +	if (src & 0x80000000U)
> +		nrbits =3D fls(~src) + 1;	/* Find least significant bit conveying sign=
 */
> +	else
> +		nrbits =3D fls(src) + 1;	/* Keep sign at 0 */
> +
> +	for (s =3D 0; s < CHAR_BIT * TEST_LEN; s++) {
> +		for (l =3D nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
> +			init_byte_array(target.c, TEST_LEN, 0x0);
> +			bt_bitfield_write(target.c, signed char, s, l, src);
> +			bt_bitfield_read(target.c, signed char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			init_byte_array(target.c, TEST_LEN, 0x0);
> +			bt_bitfield_write(target.s, short, s, l, src);
> +			bt_bitfield_read(target.c, signed char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			init_byte_array(target.c, TEST_LEN, 0x0);
> +			bt_bitfield_write(target.i, int, s, l, src);
> +			bt_bitfield_read(target.c, signed char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			init_byte_array(target.c, TEST_LEN, 0x0);
> +			bt_bitfield_write(target.l, long, s, l, src);
> +			bt_bitfield_read(target.c, signed char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			init_byte_array(target.c, TEST_LEN, 0x0);
> +			bt_bitfield_write(target.ll, long long, s, l, src);
> +			bt_bitfield_read(target.c, signed char, s, l, &readval);
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			if (err) {
> +				goto end;
> +			}
> +		}
> +	}
> +end:
> +	ok(err =3D=3D 0, "Writing and reading back 0x%X, signed", src);
> +	if (err) {
> +		printf("#Failed with start=3D%i and length=3D%i\n", s, l);
> +	}
> +	return err;
> +}
> +
> +void run_test(void)
> +{
> +	int i;
> +	plan_tests(NR_TESTS * 2 + 6);
> +
> +	srand(time(NULL));
> +
> +	srcrand =3D 0;
> +	run_test_unsigned();
> +	srcrand =3D 0;
> +	run_test_signed();
> +
> +	srcrand =3D 1;
> +	run_test_unsigned();
> +
> +	srcrand =3D ~0U;
> +	run_test_unsigned();
> +
> +	srcrand =3D -1;
> +	run_test_signed();
> +
> +	srcrand =3D (int)0x80000000U;
> +	run_test_signed();
> +
> +	for (i =3D 0; i < NR_TESTS; i++) {
> +		srcrand =3D rand();
> +		run_test_unsigned();
> +		run_test_signed();
> +	}
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	if (argc > 1) {
> +		/* Run interactive tests */
> +		unsigned long src;
> +		unsigned int shift, len;
> +		union {
> +			unsigned char c[8];
> +			unsigned short s[4];
> +			unsigned int i[2];
> +			unsigned long l[2];
> +			unsigned long long ll[1];
> +		} target;
> +		unsigned long long readval;
> +
> +		src =3D atoi(argv[1]);
> +		if (argc > 2)
> +			shift =3D atoi(argv[2]);
> +		else
> +			shift =3D 12;
> +		if (argc > 3)
> +			len =3D atoi(argv[3]);
> +		else
> +			len =3D 40;
> +
> +		init_byte_array(target.c, 8, 0xFF);
> +		bt_bitfield_write(target.c, unsigned char, shift, len, src);
> +		printf("bytewise\n");
> +		print_byte_array(target.c, 8);
> +
> +		init_byte_array(target.c, 8, 0xFF);
> +		bt_bitfield_write(target.s, unsigned short, shift, len, src);
> +		printf("shortwise\n");
> +		print_byte_array(target.c, 8);
> +
> +		init_byte_array(target.c, 8, 0xFF);
> +		bt_bitfield_write(target.i, unsigned int, shift, len, src);
> +		printf("intwise\n");
> +		print_byte_array(target.c, 8);
> +
> +		init_byte_array(target.c, 8, 0xFF);
> +		bt_bitfield_write(target.l, unsigned long, shift, len, src);
> +		printf("longwise\n");
> +		print_byte_array(target.c, 8);
> +
> +		init_byte_array(target.c, 8, 0xFF);
> +		bt_bitfield_write(target.ll, unsigned long long, shift, len, src);
> +		printf("lluwise\n");
> +		print_byte_array(target.c, 8);
> +
> +		bt_bitfield_read(target.c, unsigned char, shift, len, &readval);
> +		printf("read: %llX\n", readval);
> +		print_byte_array(target.c, 8);
> +
> +		return 0;
> +	}
> +
> +	/* Run tap-formated tests */
> +	run_test();
> +	return exit_status();
> +}
> diff --git a/tests/lib/test-seeks.c b/tests/lib/test-seeks.c
> index 47bb42e..61f1e2b 100644
> --- a/tests/lib/test-seeks.c
> +++ b/tests/lib/test-seeks.c
> @@ -225,7 +225,6 @@ int main(int argc, char **argv)
>  =

>  	if (argc < 4) {
>  		plan_skip_all("Invalid arguments: need a trace path and the start and =
last timestamp");
> -
>  	}
>  =

>  	/* Parse arguments (Trace, begin timestamp) */
> diff --git a/tests/runall.sh b/tests/runall.sh
> index b2af656..68dac01 100755
> --- a/tests/runall.sh
> +++ b/tests/runall.sh
> @@ -5,44 +5,20 @@ DIR=3D$(readlink -f ${TESTDIR})
>  BABELTRACE_BIN=3D${DIR}/../converter/babeltrace
>  CTF_TRACES=3D${DIR}/ctf-traces
>  =

> -function print_ok ()
> +function test_check_success ()
>  {
> -	# Check if we are a terminal
> -	if [ -t 1 ]; then
> -		echo -e "\e[1;32mOK\e[0m"
> -	else
> -		echo -e "OK"
> -	fi
> -}
> -
> -function print_fail ()
> -{
> -	# Check if we are a terminal
> -	if [ -t 1 ]; then
> -		echo -e "\e[1;31mFAIL\e[0m"
> -	else
> -		echo -e "FAIL"
> -	fi
> -}
> -
> -function test_check ()
> -{
> -	if [ $? -ne 0 ] ; then
> -		print_fail
> +	if [ $? -ne 0 ]; then
>  		return 1
>  	else
> -		print_ok
>  		return 0
>  	fi
>  }
>  =

>  function test_check_fail ()
>  {
> -	if [ $? -ne 1 ] ; then
> -		print_fail
> +	if [ $? -eq 0 ]; then
>  		return 1
>  	else
> -		print_ok
>  		return 0
>  	fi
>  }
> @@ -53,45 +29,48 @@ function run_babeltrace ()
>  	return $?
>  }
>  =

> -echo -e "Running test-bitfield..."
> -./test-bitfield
> -test_check
> -if [ $? -ne 0 ]; then
> -	exit 1
> -fi
> -
> -#run babeltrace expects success
> -echo -e "Running babeltrace without argument..."
> -run_babeltrace
> -test_check
> -if [ $? -ne 0 ]; then
> -	exit 1
> -fi
> -
> -for a in ${CTF_TRACES}/succeed/*; do
> -	echo -e "Running babeltrace for trace ${a}..."
> -	run_babeltrace ${a}
> -	test_check
> -	if [ $? -ne 0 ]; then
> +function print_test_result ()
> +{
> +	if [ $# -ne 3 ]; then
> +		echo "Invalid arguments provided"
>  		exit 1
>  	fi
> -done
>  =

> -#run babeltrace expects failure
> -echo -e "Running babeltrace with bogus argument..."
> +	if [ ${2} -eq 0 ]; then
> +		echo -n "ok"
> +	else
> +		echo -n "not ok"
> +	fi
> +	echo -e " "${1}" - "${3}
> +}
> +
> +successTraces=3D(${CTF_TRACES}/succeed/*)
> +failTraces=3D(${CTF_TRACES}/fail/*)
> +testCount=3D$((2 + ${#successTraces[@]} + ${#failTraces[@]}))
> +
> +currentTestIndex=3D1
> +echo -e 1..${testCount}
> +
> +#run babeltrace, expects success
> +run_babeltrace
> +test_check_success
> +print_test_result $((currentTestIndex++)) $? "Running babeltrace without=
 arguments"
> +
> +#run babeltrace with a bogus argument, expects failure
>  run_babeltrace --bogusarg
>  test_check_fail
> -if [ $? -ne 0 ]; then
> -	exit 1
> -fi
> +print_test_result $((currentTestIndex++)) $? "Running babeltrace with a =
bogus argument"
> +
> +for tracePath in ${successTraces[@]}; do
> +	run_babeltrace ${tracePath}
> +	test_check_success
> +	print_test_result $((currentTestIndex++)) $? "Running babeltrace with t=
race ${tracePath}"
> +done
>  =

> -for a in ${CTF_TRACES}/fail/*; do
> -	echo -e "Running babeltrace for trace ${a}..."
> -	run_babeltrace ${a}
> +for tracePath in ${failTraces[@]}; do
> +	run_babeltrace ${tracePath}
>  	test_check_fail
> -	if [ $? -ne 0 ]; then
> -		exit 1
> -	fi
> +	print_test_result $((currentTestIndex++)) $? "Running babeltrace with t=
race ${tracePath}"
>  done
>  =

>  exit 0
> diff --git a/tests/test-bitfield.c b/tests/test-bitfield.c
> deleted file mode 100644
> index 3bf7568..0000000
> --- a/tests/test-bitfield.c
> +++ /dev/null
> @@ -1,371 +0,0 @@
> -/*
> - * test-bitfield.c
> - *
> - * BabelTrace - bitfield test program
> - *
> - * Copyright 2010 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; under version 2 of the License.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License alo=
ng
> - * with this program; if not, write to the Free Software Foundation, Inc=
.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - */
> -
> -#define _GNU_SOURCE
> -#include <babeltrace/bitfield.h>
> -#include <time.h>
> -#include <stdlib.h>
> -#include <stdio.h>
> -
> -unsigned int glob;
> -
> -/*
> - * This function is only declared to show the size of a bitfield write in
> - * objdump.
> - */
> -void fct(void)
> -{
> -	bt_bitfield_write(&glob, unsigned int, 12, 15, 0x12345678);
> -}
> -
> -/* Test array size, in bytes */
> -#define TEST_LEN 128
> -#define NR_TESTS 10
> -
> -unsigned int srcrand;
> -
> -#if defined(__i386) || defined(__x86_64)
> -
> -static inline int fls(int x)
> -{
> -	int r;
> -	asm("bsrl %1,%0\n\t"
> -	    "cmovzl %2,%0"
> -	    : "=3D&r" (r) : "rm" (x), "rm" (-1));
> -	return r + 1;
> -}
> -
> -#elif defined(__PPC__)
> -
> -static __inline__ int fls(unsigned int x)
> -{
> -	int lz;
> -
> -	asm ("cntlzw %0,%1" : "=3Dr" (lz) : "r" (x));
> -	return 32 - lz;
> -}
> -
> -#else
> -
> -static int fls(unsigned int x)
> -{
> -	int r =3D 32;
> -
> -	if (!x)
> -		return 0;
> -	if (!(x & 0xFFFF0000U)) {
> -		x <<=3D 16;
> -		r -=3D 16;
> -	}
> -	if (!(x & 0xFF000000U)) {
> -		x <<=3D 8;
> -		r -=3D 8;
> -	}
> -	if (!(x & 0xF0000000U)) {
> -		x <<=3D 4;
> -		r -=3D 4;
> -	}
> -	if (!(x & 0xC0000000U)) {
> -		x <<=3D 2;
> -		r -=3D 2;
> -	}
> -	if (!(x & 0x80000000U)) {
> -		x <<=3D 1;
> -		r -=3D 1;
> -	}
> -	return r;
> -}
> -
> -#endif
> -
> -#define print_byte_array(c, len)	\
> -do {					\
> -	unsigned long i;		\
> -					\
> -	for (i =3D 0; i < (len); i++) {	\
> -		printf("0x%X", (c)[i]);	\
> -		if (i !=3D (len) - 1)	\
> -			printf(" ");	\
> -	}				\
> -	printf("\n");			\
> -} while (0)
> -
> -#define init_byte_array(c, len, val)	\
> -do {					\
> -	unsigned long i;		\
> -					\
> -	for (i =3D 0; i < (len); i++)	\
> -		(c)[i] =3D (val);		\
> -} while (0)
> -
> -int run_test_unsigned(void)
> -{
> -	unsigned int src, nrbits;
> -	union {
> -		unsigned char c[TEST_LEN];
> -		unsigned short s[TEST_LEN/sizeof(unsigned short)];
> -		unsigned int i[TEST_LEN/sizeof(unsigned int)];
> -		unsigned long l[TEST_LEN/sizeof(unsigned long)];
> -		unsigned long long ll[TEST_LEN/sizeof(unsigned long long)];
> -	} target;
> -	unsigned long long readval;
> -	unsigned int s, l;
> -	int err =3D 0;
> -
> -	printf("Running unsigned test with 0x%X\n", srcrand);
> -
> -	src =3D srcrand;
> -	nrbits =3D fls(src);
> -
> -	for (s =3D 0; s < CHAR_BIT * TEST_LEN; s++) {
> -		for (l =3D nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
> -			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.c, unsigned char, s, l, src);
> -			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (bytewise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -
> -			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.s, unsigned short, s, l, src);
> -			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (shortwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -
> -			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.i, unsigned int, s, l, src);
> -			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (intwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -
> -			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.l, unsigned long, s, l, src);
> -			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (longwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -
> -			init_byte_array(target.c, TEST_LEN, 0xFF);
> -			bt_bitfield_write(target.ll, unsigned long long, s, l, src);
> -			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (longlongwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -		}
> -	}
> -	if (!err)
> -		printf("Success!\n");
> -	else
> -		printf("Failed!\n");
> -	return err;
> -}
> -
> -int run_test_signed(void)
> -{
> -	int src, nrbits;
> -	union {
> -		signed char c[TEST_LEN];
> -		short s[TEST_LEN/sizeof(short)];
> -		int i[TEST_LEN/sizeof(int)];
> -		long l[TEST_LEN/sizeof(long)];
> -		long long ll[TEST_LEN/sizeof(long long)];
> -	} target;
> -	long long readval;
> -	unsigned int s, l;
> -	int err =3D 0;
> -
> -	printf("Running signed test with 0x%X\n", srcrand);
> -
> -	src =3D srcrand;
> -	if (src & 0x80000000U)
> -		nrbits =3D fls(~src) + 1;	/* Find least significant bit conveying sign=
 */
> -	else
> -		nrbits =3D fls(src) + 1;	/* Keep sign at 0 */
> -
> -	for (s =3D 0; s < 8 * TEST_LEN; s++) {
> -		for (l =3D nrbits; l < (8 * TEST_LEN) - s; l++) {
> -			init_byte_array(target.c, TEST_LEN, 0x0);
> -			bt_bitfield_write(target.c, signed char, s, l, src);
> -			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (bytewise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -
> -			init_byte_array(target.c, TEST_LEN, 0x0);
> -			bt_bitfield_write(target.s, short, s, l, src);
> -			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (shortwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -
> -			init_byte_array(target.c, TEST_LEN, 0x0);
> -			bt_bitfield_write(target.i, int, s, l, src);
> -			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (intwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -
> -			init_byte_array(target.c, TEST_LEN, 0x0);
> -			bt_bitfield_write(target.l, long, s, l, src);
> -			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (longwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -
> -			init_byte_array(target.c, TEST_LEN, 0x0);
> -			bt_bitfield_write(target.ll, long long, s, l, src);
> -			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (longlongwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> -		}
> -	}
> -	if (!err)
> -		printf("Success!\n");
> -	else
> -		printf("Failed!\n");
> -	return err;
> -}
> -
> -int run_test(void)
> -{
> -	int err =3D 0;
> -	int i;
> -
> -	srand(time(NULL));
> -
> -	srcrand =3D 0;
> -	err |=3D run_test_unsigned();
> -	srcrand =3D 0;
> -	err |=3D run_test_signed();
> -	srcrand =3D 1;
> -	err |=3D run_test_unsigned();
> -	srcrand =3D ~0U;
> -	err |=3D run_test_unsigned();
> -	srcrand =3D -1;
> -	err |=3D run_test_signed();
> -	srcrand =3D (int)0x80000000U;
> -	err |=3D run_test_signed();
> -
> -	for (i =3D 0; i < NR_TESTS; i++) {
> -		srcrand =3D rand();
> -		err |=3D run_test_unsigned();
> -		err |=3D run_test_signed();
> -	}
> -	return err;
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	unsigned long src;
> -	unsigned int shift, len;
> -	int ret;
> -	union {
> -		unsigned char c[8];
> -		unsigned short s[4];
> -		unsigned int i[2];
> -		unsigned long l[2];
> -		unsigned long long ll[1];
> -	} target;
> -	unsigned long long readval;
> -
> -	if (argc > 1)
> -		src =3D atoi(argv[1]);
> -	else
> -		src =3D 0x12345678;
> -	if (argc > 2)
> -		shift =3D atoi(argv[2]);
> -	else
> -		shift =3D 12;
> -	if (argc > 3)
> -		len =3D atoi(argv[3]);
> -	else
> -		len =3D 40;
> -
> -	target.i[0] =3D 0xFFFFFFFF;
> -	target.i[1] =3D 0xFFFFFFFF;
> -	bt_bitfield_write(target.c, unsigned char, shift, len, src);
> -	printf("bytewise\n");
> -	print_byte_array(target.c, 8);
> -
> -	target.i[0] =3D 0xFFFFFFFF;
> -	target.i[1] =3D 0xFFFFFFFF;
> -	bt_bitfield_write(target.s, unsigned short, shift, len, src);
> -	printf("shortwise\n");
> -	print_byte_array(target.c, 8);
> -
> -	target.i[0] =3D 0xFFFFFFFF;
> -	target.i[1] =3D 0xFFFFFFFF;
> -	bt_bitfield_write(target.i, unsigned int, shift, len, src);
> -	printf("intwise\n");
> -	print_byte_array(target.c, 8);
> -
> -	target.i[0] =3D 0xFFFFFFFF;
> -	target.i[1] =3D 0xFFFFFFFF;
> -	bt_bitfield_write(target.l, unsigned long, shift, len, src);
> -	printf("longwise\n");
> -	print_byte_array(target.c, 8);
> -
> -	target.i[0] =3D 0xFFFFFFFF;
> -	target.i[1] =3D 0xFFFFFFFF;
> -	bt_bitfield_write(target.ll, unsigned long long, shift, len, src);
> -	printf("lluwise\n");
> -	print_byte_array(target.c, 8);
> -
> -	bt_bitfield_read(target.c, unsigned char, shift, len, &readval);
> -	printf("read: %llX\n", readval);
> -
> -	ret =3D run_test();
> -
> -	return ret;
> -}
> -- =

> 1.8.1.1
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
