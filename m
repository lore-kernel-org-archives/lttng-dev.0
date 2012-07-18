From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] relayd fix missing option --help
Date: Wed, 18 Jul 2012 11:57:16 -0400
Message-ID: <5006DCDC.2040304__10119.6234733381$1342627072$gmane$org@efficios.com>
References: <CAGDH53ktFTHBeFDHQ+6uQSNsLeFVF+7QYD-RPjzdDVMjQUUkJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SrWcp-0002Zg-2N
	for lttng-dev@lists.lttng.org; Wed, 18 Jul 2012 11:57:19 -0400
In-Reply-To: <CAGDH53ktFTHBeFDHQ+6uQSNsLeFVF+7QYD-RPjzdDVMjQUUkJA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hmmm... this patch does not apply with "git am"...

I'll probably simply merge it my self since it's pretty trivial ;)

Cheers!
David

Christian Babeux:
> Fix missing getopt_long option for --help in relayd.
> 
> diff --git a/src/bin/lttng-relayd/main.c
> b/src/bin/lttng-relayd/main.c index 338341d..acc6ca8 100644 ---
> a/src/bin/lttng-relayd/main.c +++ b/src/bin/lttng-relayd/main.c @@
> -120,6 +120,7 @@ int parse_args(int argc, char **argv) {
> "data-port", 1, 0, 'D' }, { "daemonize", 0, 0, 'd' }, { "output",
> 1, 0, 'o' }, +              { "help", 0, 0, 'h' }, { "verbose", 0,
> 0, 'v' }, { NULL, 0, 0, 0 } };
> 
> _______________________________________________ lttng-dev mailing
> list lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQBtzcAAoJEELoaioR9I02n/wIAKk2PgjPtiM5MkWUqcUECXMp
STwxHFCltUVqV9JSM+11qKN5OTPHELp9N/GvHuJFhB9CrdSn+dN9hBrzec7/eqlX
nQEMgFQV8gyshZg3HjjrTghYxGcnhxYyZx8Kjq0KlGngSOoAoNh5/fOrlrg2e8+H
t/TCxFyGy1RbrJ9kMm5Ta4c4/FLJN34ajtiuFSX/bXjCAF+zEpXtHCBfUDV5fF/a
nK+dVTfy/Bo65JtDUNptQmHzz6lffakNiZEqmynkPXG+i9eVsRB8/tSn8bx/EfVo
HCaWLfz69UQMl378+b8gZLi45hSR/76WENabXVjE9F8t8a9gYmPwvlWNTYwteVE=
=No56
-----END PGP SIGNATURE-----
