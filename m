From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [PATCH lttng-tools 0/2] Configure fixes for
	cross-compilation
Date: Thu, 09 Aug 2012 10:01:36 -0400
Message-ID: <5023C2C0.5050000__49352.124965708$1344520952$gmane$org@polymtl.ca>
References: <cover.1344025572.git.christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1SzTJ0-0002VW-6z
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 10:01:42 -0400
In-Reply-To: <cover.1344025572.git.christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Merged!

Christian Babeux:
> Hi all,
> 
> Here are a few fixes to the configure.ac script to accomodate 
> cross-compilation of lttng-tools.
> 
> Patch 1:
> 
> Same fix that was merged in lttng-ust to fix libtool.m4 on target 
> where link_all_deplibs = no.
> 
> Patch 2:
> 
> Fix an issue encountered when cross-compiling. The configure
> script simply fails saying it cannot find the lttng-ust-ctl library
> even thought the proper "-L/path/to/ust" is specified in $LDFLAGS. 
> The AC_CHECK_LIB test fails because it can't find the libraries
> that liblttng-ust-ctl depends on. The fix is to specify the
> dependents libraries (liburcu-{common,bp,cds}) in the
> other-lib-case of AC_CHECK_LIB.
> 
> Thanks,
> 
> Christian
> 
> Christian Babeux (2): Fix: Libtool fails to find dependent
> libraries when cross-compiling lttng-tools Fix: Missing libs
> dependencies in configure check for lttng-ust-ctl
> 
> configure.ac | 38 +++++++++++++++++++++++++++++++++----- 1 file
> changed, 33 insertions(+), 5 deletions(-)
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQI8K9AAoJEELoaioR9I02GYoIALy1oupw5BbMgfNV5i/gyPrf
3ywUW+s0/Ltl+H4L6hOUq4daUTyUpt+Tla9bBNiP+HXkRX7rxjMnePjN2lk8QJR6
4lW1fWD7IlUNwQkVzKNZh+fv3xu4QyIiWd9zaEmMWIFwibaAcV8yzaI4ZkdrkHXX
r+b2nVeGScx2kamwj5B/CWXr+FLovsstGEdKUy2KmJZ7A9eLg4G4Eyn8R3U7Sn5m
X3t04liPawiZ6g8NTVQiw+O2vBs6ngdklj5DTQ1v4vLb/a2IwPPEnHjrznV1Np6A
T1ONQex+063MYdxp6a0948pXx2X1jBEgeESphoew/Go15LQqgkUBFZHTye3kKdI=
=GgYi
-----END PGP SIGNATURE-----
