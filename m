From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 2/4] Tests: Add helper	functions
 for printing status and test banner
Date: Fri, 21 Sep 2012 12:30:47 -0400
Message-ID: <505C9637.4050507__18612.5734974214$1348245076$gmane$org@efficios.com>
References: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
	<1348178720-24610-2-git-send-email-christian.babeux@efficios.com>
	<20120921022014.GD22861@Krystal> <20120921022328.GF22861@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TF67v-0004fY-KJ
	for lttng-dev@lists.lttng.org; Fri, 21 Sep 2012 12:30:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 39535187227
	for <lttng-dev@lists.lttng.org>; Fri, 21 Sep 2012 12:33:37 -0400 (EDT)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NaFQh7FLjPaP for <lttng-dev@lists.lttng.org>;
	Fri, 21 Sep 2012 12:33:34 -0400 (EDT)
Received: from 127.0.0.1 (cable-13.246.173-198.electronicbox.net
	[173.246.13.198])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 6B25F187225
	for <lttng-dev@lists.lttng.org>; Fri, 21 Sep 2012 12:33:34 -0400 (EDT)
In-Reply-To: <20120921022328.GF22861@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Agreed on the string param to test_banner()

David

Mathieu Desnoyers:
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
>> * Christian Babeux (christian.babeux@efficios.com) wrote:
>>> Add three new printing functions:
>>> 
>>> print_ok: Print the OK status with optional color support. 
>>> print_fail: Print the FAIL status with optional color support. 
>>> print_test_banner: Print a test banner of the test
>>> description.
>>> 
>>> e.g.: sometest.sh: TEST_DESC="A really useful test" [...] 
>>> source $TESTDIR/utils.sh print_test_banner
> 
> oh, wait...
> 
> could print_test_banner take the string (or variable) to print as 
> parameter ? e.g.
> 
> print_test_banner($TEST_DESC)
> 
> So some typical use-cases could simply pass the banner string as 
> parameter.. ?
> 
> Thanks,
> 
> Mathieu
> 
>>> [...] print_ok print_fail [...]
>>> 
>>> $ ./sometest.sh ---------------------- A really useful test 
>>> ---------------------- OK FAIL
>>> 
>>> Signed-off-by: Christian Babeux
>>> <christian.babeux@efficios.com>
>> 
>> Looks good to me!
>> 
>> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> 
>>> --- tests/utils.sh | 33 +++++++++++++++++++++++++++++++++ 1
>>> file changed, 33 insertions(+)
>>> 
>>> diff --git a/tests/utils.sh b/tests/utils.sh index
>>> 42b18e3..2670de3 100644 --- a/tests/utils.sh +++
>>> b/tests/utils.sh @@ -25,6 +25,39 @@ KERNEL_MAJOR_VERSION=2 
>>> KERNEL_MINOR_VERSION=6 KERNEL_PATCHLEVEL_VERSION=27
>>> 
>>> +function print_ok () +{ +	# Check if we are a terminal +	if [
>>> -t 1 ]; then +		echo -e "\e[1;32mOK\e[0m" +	else +		echo -e
>>> "OK" +	fi +} + +function print_fail () +{ +	# Check if we are a
>>> terminal +	if [ -t 1 ]; then +		echo -e "\e[1;31mFAIL\e[0m" +
>>> else +		echo -e "FAIL" +	fi +} + +function print_test_banner
>>> () +{ +	# Rely on the global TEST_DESC to be set +	if [ -n
>>> "$TEST_DESC" ]; then +		count=$((${#TEST_DESC}+2)) +
>>> str=$(printf "%${count}s"); +		echo -e "\n" +		echo -e ${str//
>>> /-} +		echo -e " $TEST_DESC " +		echo -e ${str// /-} +	fi +} + 
>>> function validate_kernel_version () { kern_version=($(uname -r
>>> | awk -F. '{ printf("%d.%d.%d\n",$1,$2,$3); }' | tr '.' '\n')) 
>>> -- 1.7.12
>>> 
>>> 
>>> _______________________________________________ lttng-dev
>>> mailing list lttng-dev@lists.lttng.org 
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> 
>> -- Mathieu Desnoyers Operating System Efficiency R&D Consultant 
>> EfficiOS Inc. http://www.efficios.com
>> 
>> _______________________________________________ lttng-dev mailing
>> list lttng-dev@lists.lttng.org 
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQXJY3AAoJEELoaioR9I02bFAH/0pstQvLB2x0HvJtPQKut9SV
/dZsjHii/aTo+IjqVjLynXb85kZ1hTUuozX1GsUKw+zc6OOHji1Mr5dmFewRkNZD
igJxj5zL1LpVEI1gLgjqs6Slfe05jAr1ggQkPiyjzSE2kFp8307LRwtkwEqnJYvr
JOS2LQ4Ga6NU+LDtsDTowoLC/76IRbAFvooCM4xbaN9u9ypDPj8QvIRagAiFFl4j
SqsH8Y+tpI4262Z/3Veg1Ty7iBl5BG0HgcJjWnC9avjAKuMKx6AlY5+MqX9ksJ+T
Kh7uMUcGhjrsyO2SY4AofeERJwQPcLOFmOLWKk0vUzywfgVJewbLVEZieILAVfs=
=n7Le
-----END PGP SIGNATURE-----
