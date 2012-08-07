From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH] Cleanup: Remove misplaced config.h include
Date: Tue, 07 Aug 2012 10:46:36 -0400
Message-ID: <50212A4C.3030002__37201.6794667163$1344350821$gmane$org@efficios.com>
References: <20120807144318.GA30155@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Syl3P-00061Y-VQ
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 10:46:40 -0400
In-Reply-To: <20120807144318.GA30155@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Merged! Thx

Mathieu Desnoyers:
> config.h should _always_ be included first, before system headers,
> to ensure coherent size_t across the file.
> 
> We force the config.h inclusion by the compiler, so this is not an
> issue (configure.ac: DEFAULT_INCLUDES="-I\$(top_srcdir)
> -I\$(top_builddir) -I\$(top_builddir)/src
> -I\$(top_builddir)/include -include config.h"), but let's remove
> this misleading line of code.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
> --- diff --git a/src/common/hashtable/rculfhash.c
> b/src/common/hashtable/rculfhash.c index 776f9f3..423d186 100644 
> --- a/src/common/hashtable/rculfhash.c +++
> b/src/common/hashtable/rculfhash.c @@ -157,7 +157,6 @@ #include
> <stdint.h> #include <string.h>
> 
> -#include "config.h" #include <urcu.h> #include <urcu-call-rcu.h> 
> #include <urcu/arch.h>
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQISpMAAoJEELoaioR9I02IkMH/ilFqFAfZEUcKcheR6ZI0Nco
DrL8gyfVIJYcxQFUyduqSsc1vSOtqzlyF3OvyyfHgJBo1HilODrqRBJP5/ZBflDz
DgKkk46c2e3lrSm8pfjHgRDVPiPhTd+axyVjZ/dyGvrMvcPcjLH/QS/tEF1ziXP6
urVW4FT515fXUUYRPyd5K+ooWArlxwQTxExwpayHUqI8VmHHs9fqxjOB7YnkRhyl
vpoQSzyiHsjCPvk1YJoTeC1p5BJmy8YckkwUhNgxgiuuPUMDfhWMoUC76oj2AAR0
TM7m9NgjpdAOEr5TAXFhFJVb8FNaH7nuymiXD/o0aF0/k9ko5vBP5Tdo6RV3xGI=
=c0ji
-----END PGP SIGNATURE-----
