From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace 2/2] Convert the unit tests
	to	the TAP format
Date: Thu, 7 Feb 2013 17:34:09 -0500
Message-ID: <20130207223409.GB10074__13233.2351211973$1360276494$gmane$org@Krystal>
References: <20130207174526.GA6632@Krystal>
	<1360273253-12401-1-git-send-email-jeremie.galarneau@efficios.com>
	<1360273253-12401-2-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U3a2l-0003Zm-P0
	for lttng-dev@lists.lttng.org; Thu, 07 Feb 2013 17:34:11 -0500
Content-Disposition: inline
In-Reply-To: <1360273253-12401-2-git-send-email-jeremie.galarneau@efficios.com>
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

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  tests/lib/Makefile.am     |   2 +
>  tests/lib/test-bitfield.c | 242 +++++++++++++++++++---------------------=
------
>  tests/runall.sh           |  88 +++++++----------
>  3 files changed, 139 insertions(+), 193 deletions(-)
> =

> diff --git a/tests/lib/Makefile.am b/tests/lib/Makefile.am
> index 0613beb..01831de 100644
> --- a/tests/lib/Makefile.am
> +++ b/tests/lib/Makefile.am
> @@ -8,6 +8,8 @@ test_seeks_LDADD =3D libtestcommon.a \
>  	$(top_builddir)/lib/libbabeltrace.la \
>  	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la
>  =

> +test_bitfield_LDADD =3D libtestcommon.a
> +
>  noinst_PROGRAMS =3D test-seeks test-bitfield
>  =

>  test_seeks_SOURCES =3D test-seeks.c
> diff --git a/tests/lib/test-bitfield.c b/tests/lib/test-bitfield.c
> index 3bf7568..9b8e737 100644
> --- a/tests/lib/test-bitfield.c
> +++ b/tests/lib/test-bitfield.c
> @@ -25,6 +25,8 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  =

> +#include "tap.h"
> +
>  unsigned int glob;
>  =

>  /*
> @@ -130,8 +132,6 @@ int run_test_unsigned(void)
>  	unsigned int s, l;
>  	int err =3D 0;
>  =

> -	printf("Running unsigned test with 0x%X\n", srcrand);
> -
>  	src =3D srcrand;
>  	nrbits =3D fls(src);
>  =

> @@ -140,58 +140,38 @@ int run_test_unsigned(void)
>  			init_byte_array(target.c, TEST_LEN, 0xFF);
>  			bt_bitfield_write(target.c, unsigned char, s, l, src);
>  			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (bytewise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);

we seem to be losing a lot of information with this change. Is it
possible to keep this info with the transition to TAP when an error is
detected ?

Thanks,

Mathieu

> -				err =3D 1;
> -			}
> +			err =3D readval !=3D src ? 1 : err;
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
>  			bt_bitfield_write(target.s, unsigned short, s, l, src);
>  			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (shortwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> +			err =3D readval !=3D src ? 1 : err;
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
>  			bt_bitfield_write(target.i, unsigned int, s, l, src);
>  			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (intwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> +			err =3D readval !=3D src ? 1 : err;
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
>  			bt_bitfield_write(target.l, unsigned long, s, l, src);
>  			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (longwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> +			err =3D readval !=3D src ? 1 : err;
>  =

>  			init_byte_array(target.c, TEST_LEN, 0xFF);
>  			bt_bitfield_write(target.ll, unsigned long long, s, l, src);
>  			bt_bitfield_read(target.c, unsigned char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (longlongwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			if (err) {
> +				goto end;
>  			}
>  		}
>  	}
> -	if (!err)
> -		printf("Success!\n");
> -	else
> -		printf("Failed!\n");
> +end:
> +	ok(err =3D=3D 0, "Writing and reading back 0x%X, unsigned", src);
> +	if (err) {
> +		printf("# Failed with start=3D%i and length=3D%i\n", s, l);
> +	}
>  	return err;
>  }
>  =

> @@ -209,163 +189,141 @@ int run_test_signed(void)
>  	unsigned int s, l;
>  	int err =3D 0;
>  =

> -	printf("Running signed test with 0x%X\n", srcrand);
> -
>  	src =3D srcrand;
>  	if (src & 0x80000000U)
>  		nrbits =3D fls(~src) + 1;	/* Find least significant bit conveying sign=
 */
>  	else
>  		nrbits =3D fls(src) + 1;	/* Keep sign at 0 */
>  =

> -	for (s =3D 0; s < 8 * TEST_LEN; s++) {
> -		for (l =3D nrbits; l < (8 * TEST_LEN) - s; l++) {
> +	for (s =3D 0; s < CHAR_BIT * TEST_LEN; s++) {
> +		for (l =3D nrbits; l < (CHAR_BIT * TEST_LEN) - s; l++) {
>  			init_byte_array(target.c, TEST_LEN, 0x0);
>  			bt_bitfield_write(target.c, signed char, s, l, src);
>  			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (bytewise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> +			err =3D readval !=3D src ? 1 : err;
>  =

>  			init_byte_array(target.c, TEST_LEN, 0x0);
>  			bt_bitfield_write(target.s, short, s, l, src);
>  			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (shortwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> +			err =3D readval !=3D src ? 1 : err;
>  =

>  			init_byte_array(target.c, TEST_LEN, 0x0);
>  			bt_bitfield_write(target.i, int, s, l, src);
>  			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (intwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> +			err =3D readval !=3D src ? 1 : err;
>  =

>  			init_byte_array(target.c, TEST_LEN, 0x0);
>  			bt_bitfield_write(target.l, long, s, l, src);
>  			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (longwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> -			}
> +			err =3D readval !=3D src ? 1 : err;
>  =

>  			init_byte_array(target.c, TEST_LEN, 0x0);
>  			bt_bitfield_write(target.ll, long long, s, l, src);
>  			bt_bitfield_read(target.c, signed char, s, l, &readval);
> -			if (readval !=3D src) {
> -				printf("Error (longlongwise) src %X read %llX shift %d len %d\n",
> -				       src, readval, s, l);
> -				print_byte_array(target.c, TEST_LEN);
> -				err =3D 1;
> +			err =3D readval !=3D src ? 1 : err;
> +
> +			if (err) {
> +				goto end;
>  			}
>  		}
>  	}
> -	if (!err)
> -		printf("Success!\n");
> -	else
> -		printf("Failed!\n");
> +end:
> +	ok(err =3D=3D 0, "Writing and reading back 0x%X, signed", src);
> +	if (err) {
> +		printf("#Failed with start=3D%i and length=3D%i\n", s, l);
> +	}
>  	return err;
>  }
>  =

> -int run_test(void)
> +void run_test(void)
>  {
> -	int err =3D 0;
>  	int i;
> +	plan_tests(NR_TESTS * 2 + 6);
>  =

>  	srand(time(NULL));
>  =

>  	srcrand =3D 0;
> -	err |=3D run_test_unsigned();
> +	run_test_unsigned();
>  	srcrand =3D 0;
> -	err |=3D run_test_signed();
> +	run_test_signed();
> +
>  	srcrand =3D 1;
> -	err |=3D run_test_unsigned();
> +	run_test_unsigned();
> +
>  	srcrand =3D ~0U;
> -	err |=3D run_test_unsigned();
> +	run_test_unsigned();
> +
>  	srcrand =3D -1;
> -	err |=3D run_test_signed();
> +	run_test_signed();
> +
>  	srcrand =3D (int)0x80000000U;
> -	err |=3D run_test_signed();
> +	run_test_signed();
>  =

>  	for (i =3D 0; i < NR_TESTS; i++) {
>  		srcrand =3D rand();
> -		err |=3D run_test_unsigned();
> -		err |=3D run_test_signed();
> +		run_test_unsigned();
> +		run_test_signed();
>  	}
> -	return err;
>  }
>  =

>  int main(int argc, char **argv)
>  {
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
>  =

> -	if (argc > 1)
>  		src =3D atoi(argv[1]);
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
>  }
> diff --git a/tests/runall.sh b/tests/runall.sh
> index 9e0bdca..c10e88a 100755
> --- a/tests/runall.sh
> +++ b/tests/runall.sh
> @@ -5,44 +5,20 @@ DIR=3D$(readlink -f ${TESTDIR})
>  BABELTRACE_BIN=3D${DIR}/../converter/babeltrace
>  CTF_TRACES=3D${DIR}/ctf-traces
>  =

> -function print_ok ()
> -{
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
> +function test_check_success ()
>  {
>  	if [ $? -ne 0 ] ; then
> -		print_fail
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
> +	if [ $? -eq 0 ] ; then
>  		return 1
>  	else
> -		print_ok
>  		return 0
>  	fi
>  }
> @@ -53,38 +29,48 @@ function run_babeltrace ()
>  	return $?
>  }
>  =

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
> +	if [ $# -ne 3 ] ; then
> +		echo "Invalid arguments provided"
>  		exit 1
>  	fi
> -done
>  =

> -#run babeltrace expects failure
> -echo -e "Running babeltrace with bogus argument..."
> +	if [ ${2} -eq 0 ] ; then
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
