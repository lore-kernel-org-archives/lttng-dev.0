From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RFC v3 lttng-tools] New testpoint
	mechanism	to instrument LTTng binaries for testing purpose
Date: Mon, 17 Sep 2012 11:25:29 -0400
Message-ID: <20120917152529.GB8071__24498.5351375819$1347895567$gmane$org@Krystal>
References: <1347396978-4661-1-git-send-email-christian.babeux@efficios.com>
	<1347649230-21489-1-git-send-email-christian.babeux@efficios.com>
	<1347649230-21489-2-git-send-email-christian.babeux@efficios.com>
	<50573905.9070106@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TDdCW-0002Wi-Bb
	for lttng-dev@lists.lttng.org; Mon, 17 Sep 2012 11:25:32 -0400
Content-Disposition: inline
In-Reply-To: <50573905.9070106@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Hoy,
> 
> This looks good. However, I can _not_ merge it upstream for now. I
> will at least need a testpoint library example in the git tree to test
> it and make sure it does not break releases.

good point! We need at least one example user.

> 
> Cheers!
> David
> 
> Christian Babeux:
> > This commit introduce two new macros: TESTPOINT_DECL(name) and 
> > testpoint(name).
> > 
> > Here a quick example that show how to use the testpoint mechanism:
> > 
> > file: main.c
> > 
> > /* Testpoint declaration */ TESTPOINT_DECL(interesting_function)
> > 
> > void interesting_function(void) { testpoint(interesting_function); 
> > /* Some processing that can fail */ ... }
> > 
> > int main(int argc, char *argv[]) { interesting_function(); ... 
> > printf("End"); }
> > 
> > file: testpoint.c void __testpoint_interesting_function(void) { 
> > printf("In testpoint of interesting function!"); }
> > 
> > Compile: gcc -o test main.c gcc -fPIC -shared -o testpoint.so
> > testpoint.c
> > 
> > Run:
> >> ./test
> > End
> >> export LTTNG_TESTPOINT_ENABLE=1 LD_PRELOAD=testpoint.so ./test
> > In testpoint of interesting function! End
> >> export LTTNG_TESTPOINT_ENABLE=0 LD_PRELOAD=testpoint.so ./test
> > End
> > 
> > The testpoint mechanism is triggered via the preloading of a
> > shared object containing the appropriate testpoint symbols and by
> > setting the LTTNG_TESTPOINT_ENABLE environment variable.
> > 
> > The check on this environment variable is done on the application
> > startup with the help of a constructor (lttng_testpoint_check)
> > which toggle a global state variable indicating whether or not the
> > testpoints should be activated.
> > 
> > When enabled, the testpoint() macro calls an underlying wrapper
> > specific to the testpoint and simply try to lookup the testpoint
> > symbol via a dlsym() call.
> > 
> > When disabled, the testpoint() call will only incur an additionnal
> > test per testpoint on a global variable. This performance 'hit'
> > should be acceptable for production use.
> > 
> > The testpoint mechanism should be *always on*. It can be
> > explicitly disabled via CFLAGS="-DNTESTPOINT" in a way similar to
> > NDEBUG and assert().
> > 
> > Signed-off-by: Christian Babeux <christian.babeux@efficios.com> 
> > --- configure.ac                     |  1 + src/common/Makefile.am
> > |  2 +- src/common/testpoint/Makefile.am |  6 ++++ 
> > src/common/testpoint/testpoint.c | 64
> > ++++++++++++++++++++++++++++++++++ src/common/testpoint/testpoint.h
> > | 74 ++++++++++++++++++++++++++++++++++++++++ 5 files changed, 146
> > insertions(+), 1 deletion(-) create mode 100644
> > src/common/testpoint/Makefile.am create mode 100644
> > src/common/testpoint/testpoint.c create mode 100644
> > src/common/testpoint/testpoint.h
> > 
> > diff --git a/configure.ac b/configure.ac index 7687280..8e61115
> > 100644 --- a/configure.ac +++ b/configure.ac @@ -275,6 +275,7 @@
> > AC_CONFIG_FILES([ src/common/sessiond-comm/Makefile 
> > src/common/compat/Makefile src/common/relayd/Makefile +
> > src/common/testpoint/Makefile src/lib/Makefile 
> > src/lib/lttng-ctl/Makefile src/lib/lttng-ctl/filter/Makefile diff
> > --git a/src/common/Makefile.am b/src/common/Makefile.am index
> > ca48153..889b04e 100644 --- a/src/common/Makefile.am +++
> > b/src/common/Makefile.am @@ -1,6 +1,6 @@ AM_CPPFLAGS =
> > 
> > -SUBDIRS = compat hashtable kernel-ctl sessiond-comm relayd
> > kernel-consumer ust-consumer +SUBDIRS = compat hashtable kernel-ctl
> > sessiond-comm relayd kernel-consumer ust-consumer testpoint
> > 
> > AM_CFLAGS = -fno-strict-aliasing
> > 
> > diff --git a/src/common/testpoint/Makefile.am
> > b/src/common/testpoint/Makefile.am new file mode 100644 index
> > 0000000..7d3df16 --- /dev/null +++
> > b/src/common/testpoint/Makefile.am @@ -0,0 +1,6 @@ +AM_CPPFLAGS = 
> > + +noinst_LTLIBRARIES = libtestpoint.la + +libtestpoint_la_SOURCES
> > = testpoint.h testpoint.c +libtestpoint_la_LIBADD = -ldl diff --git
> > a/src/common/testpoint/testpoint.c
> > b/src/common/testpoint/testpoint.c new file mode 100644 index
> > 0000000..3d01a03 --- /dev/null +++
> > b/src/common/testpoint/testpoint.c @@ -0,0 +1,64 @@ +/* + *
> > Copyright (C) 2012 - Christian Babeux
> > <christian.babeux@efficios.com> + * + * This program is free
> > software; you can redistribute it and/or modify + * it under the
> > terms of the GNU General Public License, version 2 only, + * as
> > published by the Free Software Foundation. + * + * This program is
> > distributed in the hope that it will be useful, but WITHOUT + * ANY
> > WARRANTY; without even the implied warranty of MERCHANTABILITY or +
> > * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > License for + * more details. + * + * You should have received a
> > copy of the GNU General Public License along + * with this program;
> > if not, write to the Free Software Foundation, Inc., + * 51
> > Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA. + */ + 
> > +#ifndef NTESTPOINT + +#define _GNU_SOURCE /* for RTLD_DEFAULT GNU
> > extension */ + +#include <dlfcn.h>  /* for dlsym   */ +#include
> > <stdlib.h> /* for getenv  */ +#include <string.h> /* for strncmp
> > */ + +#include "testpoint.h" + +/* Environment variable used to
> > enable the testpoints facilities. */ +static const char
> > *lttng_testpoint_env_var = "LTTNG_TESTPOINT_ENABLE"; + +/*
> > Testpoint toggle flag */ +int lttng_testpoint_activated; + +/* + *
> > Toggle the support for testpoints on the application startup. + */ 
> > +static void __attribute__((constructor))
> > lttng_testpoint_check(void) +{ +	char *testpoint_env_val = NULL; + 
> > +	testpoint_env_val = getenv(lttng_testpoint_env_var); +	if
> > (testpoint_env_val != NULL +	    && (strncmp(testpoint_env_val,
> > "1", 1) == 0)) { +		lttng_testpoint_activated = 1; +	} +} + +/* + *
> > Lookup a symbol by name. + * + * Return the address where the
> > symbol is loaded + * or NULL if the symbol was not found. + */ 
> > +void *lttng_testpoint_lookup(const char *name) +{ +	if (!name) { +
> > return NULL; +	} + +	return dlsym(RTLD_DEFAULT, name); +} + +#endif
> > /* NTESTPOINT */ + diff --git a/src/common/testpoint/testpoint.h
> > b/src/common/testpoint/testpoint.h new file mode 100644 index
> > 0000000..2925b0a --- /dev/null +++
> > b/src/common/testpoint/testpoint.h @@ -0,0 +1,74 @@ +/* + *
> > Copyright (C) 2012 - Christian Babeux
> > <christian.babeux@efficios.com> + * + * This program is free
> > software; you can redistribute it and/or modify + * it under the
> > terms of the GNU General Public License, version 2 only, + * as
> > published by the Free Software Foundation. + * + * This program is
> > distributed in the hope that it will be useful, but WITHOUT + * ANY
> > WARRANTY; without even the implied warranty of MERCHANTABILITY or +
> > * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > License for + * more details. + * + * You should have received a
> > copy of the GNU General Public License along + * with this program;
> > if not, write to the Free Software Foundation, Inc., + * 51
> > Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA. + */ + 
> > +#ifdef NTESTPOINT + +#define testpoint(name) +#define
> > TESTPOINT_DECL(name) + +#else /* NTESTPOINT */ + +#include <urcu.h>
> > /* for caa_likely/unlikely */ + +extern int
> > lttng_testpoint_activated; + +void *lttng_testpoint_lookup(const
> > char *name); + +/* + * Testpoint is only active if the global + *
> > lttng_testpoint_activated flag is set. + */ +#define
> > testpoint(name)					\ +	do {							\ +		if
> > (caa_unlikely(lttng_testpoint_activated)) {	\ +
> > __testpoint_##name##_wrapper();		\ +		}						\ +	} while (0) + +/* 
> > + * One wrapper per testpoint is generated. This is to keep track +
> > * of the symbol lookup status and the corresponding function + *
> > pointer, if any. + */ +#define _TESTPOINT_DECL(_name)						\ +
> > static inline void __testpoint_##_name##_wrapper(void)		\ +	{
> > \ +		static void (*tp)(void);				\ +		static int found;					\ +
> > const char *tp_name = "__testpoint_" #_name;		\ +									\ +		if
> > (tp) {						\ +			tp();						\ +		} else {						\ +			if (!found) {
> > \ +				tp = lttng_testpoint_lookup(tp_name);	\ +				if (tp) {				\ 
> > +					found = 1;			\ +					tp();				\ +				} else {				\ +
> > found = -1;			\ +				}					\ +			}						\ +		}							\ +	} + +/*
> > Testpoint declaration */ +#define TESTPOINT_DECL(name)	\ +
> > _TESTPOINT_DECL(name) + +#endif /* NTESTPOINT */ +
> -----BEGIN PGP SIGNATURE-----
> 
> iQEcBAEBCgAGBQJQVzkBAAoJEELoaioR9I02oW8IAKePOQ5iMOVARGniB6xLtWeD
> 6yEc5dh+sh8kjR/Vl+of9Qi0GC/4nLzQeDes15UJgeMGK/aMl30PDtlUO0JHdYAO
> HZoZpOi+TrX++4n0D7nU92XBAL6trDcMDzh+Dk+YMdVTgJiKcmZd0zXwD7wg8P5y
> AaQ6ZhlKelNe/p5T2TZKTO4Vk5Pkz4tm2DiH62wkOUEhjk1OK5j2jYArKWHefoh1
> lAyLHqYbq5jYH/i+c8XUsGBRlb7pvc+3fcFV26AFIxt1A9oZ33k1geHY9VDQ5vVc
> fyovQjtR+OQmLFW4ifXsVb7RVSJCEosjlYnjK0LkyKEyb7DwjALwxArPNYy5i1E=
> =42G8
> -----END PGP SIGNATURE-----
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
