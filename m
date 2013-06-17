From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-ust] Fix: Check g++ version before
	compiling
Date: Mon, 17 Jun 2013 17:06:40 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD1314240A__31932.841303251$1371488943$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Uocui-0002gQ-Q0
	for lttng-dev@lists.lttng.org; Mon, 17 Jun 2013 13:08:20 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
   1. Re: [PATCH lttng-ust] Fix: Check g++ version before compiling
      'hello.cxx' test (Christian Babeux)
   2. Re: [PATCH lttng-ust] Fix: Check g++ version	before	compiling
      'hello.cxx' test (Mathieu Desnoyers)
----------------------------------------------------------------------
Message: 1
Date: Sat, 15 Jun 2013 14:31:09 -0400

Checking specific version numbers might be a bit counterproductive (e.g. wh=
at if some embedded platform as a GCC 4.7 with designated initializer expli=
citly patched out?).

Going forward, I think checking for the designated initializer feature via =
a small C++ testfile is more in line with the Autoconf philosophy.
Also, we should conditionally disable the compilation of the tracepoint pro=
bes requiring designated initializers if not supported.

Thanks,
Christian
------------------------------
Message: 2
Date: Sat, 15 Jun 2013 14:37:26 -0400

Moreover, the documentation and patches should take LLVM into account.

Thanks,
Mathieu
------------------------------------------------------------
   The lttng-ust (2.2.0-rc2-27 6e266bf) errors that arise with g++ 4.6 (g++=
 4.7 is not distributed on Ubuntu yet) are:

make[3]: Entering directory `/home/daniel/Documents/lttng-ust-6e266bf/tests=
/hello.cxx'
  CXX    hello.o
  CXX    tp.o
In file included from ../../include/lttng/ust-tracepoint-event.h:206:0,
                 from ../../include/lttng/tracepoint-event.h:62,
                 from ust_tests_hello.h:64,
                 from tp.cpp:26:
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
In file included from ../../include/lttng/ust-tracepoint-event.h:634:0,
                 from ../../include/lttng/tracepoint-event.h:62,
                 from ust_tests_hello.h:64,
                 from tp.cpp:26:
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:31:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: error: expected primary-expression before '.' t=
oken
././ust_tests_hello.h:53:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
././ust_tests_hello.h:53:1: warning: extended initializer lists only availa=
ble with -std=3Dc++0x or -std=3Dgnu++0x [enabled by default]
In file included from ../../include/lttng/tracepoint-event.h:62:0,
                 from ust_tests_hello.h:64,
                 from tp.cpp:26:
../../include/lttng/ust-tracepoint-event.h:662:2: error: expected primary-e=
xpression before '.' token
../../include/lttng/ust-tracepoint-event.h:663:2: error: expected primary-e=
xpression before '.' token
../../include/lttng/ust-tracepoint-event.h:664:2: error: expected primary-e=
xpression before '.' token
../../include/lttng/ust-tracepoint-event.h:665:2: error: expected primary-e=
xpression before '.' token
../../include/lttng/ust-tracepoint-event.h:665:23: warning: extended initia=
lizer lists only available with -std=3Dc++0x or -std=3Dgnu++0x [enabled by =
default]
../../include/lttng/ust-tracepoint-event.h:666:2: error: expected primary-e=
xpression before '.' token
../../include/lttng/ust-tracepoint-event.h:666:33: warning: extended initia=
lizer lists only available with -std=3Dc++0x or -std=3Dgnu++0x [enabled by =
default]
../../include/lttng/ust-tracepoint-event.h:667:2: error: expected primary-e=
xpression before '.' token
../../include/lttng/ust-tracepoint-event.h:668:2: error: expected primary-e=
xpression before '.' token
../../include/lttng/ust-tracepoint-event.h:669:2: error: expected primary-e=
xpression before '.' token
make[3]: *** [tp.o] Error 1
make[3]: Leaving directory `/home/daniel/Documents/lttng-ust-6e266bf/tests/=
hello.cxx'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/daniel/Documents/lttng-ust-6e266bf/tests'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/daniel/Documents/lttng-ust-6e266bf'
make: *** [all] Error 2

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
