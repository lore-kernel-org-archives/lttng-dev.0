From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building	patches.
Date: Mon, 26 Aug 2013 11:11:47 -0400
Message-ID: <20130826151147.GA16659__33764.9425179281$1377529968$gmane$org@Krystal>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
	<CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
	<20130824175909.GA12409@Krystal>
	<CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og@mail.gmail.com>
	<CAD7SSK7_sNYZE5knPEJuJwnj+OXmpcXg1EGGThnT4HW5+s5+KQ@mail.gmail.com>
	<20130826162407.1996f085@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VDySN-0006WM-M3
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 11:11:57 -0400
Content-Disposition: inline
In-Reply-To: <20130826162407.1996f085@skate>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Thomas Petazzoni (thomas.petazzoni@free-electrons.com) wrote:
> Dear Jimmy Durand Wesolowski,
> 
> On Mon, 26 Aug 2013 09:43:49 +0200, Jimmy Durand Wesolowski wrote:
> 
> > Here is a quick test, without any of my modifications. I had to pass both
> > CFLAGS and LDFLAGS to "./configure", as said earlier, which can be
> > considered
> > a normal process:
> > CFLAGS="-I<URCU_BUILD_PATH>/include" \
> >   CPPFLAGS="-I<URCU_BUILD_PATH>/include" \
> >   LDFLAGS="-L<URCU_BUILD_PATH>/lib" \
> >   ./configure --prefix=${PWD}/build
> 
> As said previously, if you're cross-compiling, doing
> --prefix=${PWD}/build is completely wrong. --prefix is the directory
> where the software will be located when executed on the target, not the
> location where the software will be installed when doing 'make install'.
> 
> Please document yourself on the difference between --prefix at
> configure time and DESTDIR at install time.

There appears to be a problem introduced recently by the new
doc/examples in lttng-ust.

If I make uninstall both userspace RCU and UST from my system, then:

(urcu)
./configure --with-sysroot=/tmp/test
make clean
make
DESTDIR=/tmp/test make install

(lttng-ust)
LDFLAGS=-L/tmp/test/usr/local/lib CPPFLAGS=-I/tmp/test/usr/local/include \
                ./configure --with-sysroot=/tmp/test
make clean
make

The last make fails with:

for subdir in easy-ust demo gen-tp hello-static-lib; do \
		cd $subdir && make AM_CPPFLAGS="-I../../../include/" AM_LDFLAGS='-L../../../liblttng-ust/.libs/ -Wl,-rpath="/home/compudj/git/lttng-ust/doc/examples/../../liblttng-ust/.libs/"' LTTNG_GEN_TP_PATH="../../../tools/"  all; cd ..; \
	done
make[4]: Entering directory `/home/compudj/git/lttng-ust/doc/examples/easy-ust'
gcc  -I.  -I../../../include/ \
		 -c -o sample.o sample.c
In file included from ../../../include/lttng/tracepoint.h:29:0,
                 from sample_component_provider.h:62,
                 from sample.c:31:
../../../include/lttng/tracepoint-rcu.h:26:27: fatal error: urcu/compiler.h: No such file or directory
compilation terminated.
make[4]: *** [sample.o] Error 1
make[4]: Leaving directory `/home/compudj/git/lttng-ust/doc/examples/easy-ust'
make[4]: Entering directory `/home/compudj/git/lttng-ust/doc/examples/demo'

The following patch fixes part of the problem:

diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
index 8c4901b..d26e520 100644
--- a/doc/examples/Makefile.am
+++ b/doc/examples/Makefile.am
@@ -45,7 +45,7 @@ all-local:
 		done; \
 	fi
 	for subdir in $(SUBDIRS_PROXY); do \
-		cd $$subdir && $(MAKE) AM_CPPFLAGS="-I../../../include/" AM_LDFLAGS='-L../../../liblttng-ust/.libs/ -Wl,-rpath="$(PWD)/../../liblttng-ust/.libs/"' LTTNG_GEN_TP_PATH="../../../tools/" $(AM_MAKEFLAGS) all; cd ..; \
+		cd $$subdir && $(MAKE) AM_CPPFLAGS="$(CPPFLAGS) -I../../../include/" AM_LDFLAGS='$(LDFLAGS) -L../../../liblttng-ust/.libs/ -Wl,-rpath="$(PWD)/../../liblttng-ust/.libs/"' LTTNG_GEN_TP_PATH="../../../tools/" $(AM_MAKEFLAGS) all; cd ..; \
 	done
 
 clean-local:

Now I just have to figure out how to teach lttng-gen-tp about CPPFLAGS
:-/

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
