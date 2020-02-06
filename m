From: Simon Marchi <simark@simark.ca>
Subject: Re: [PATCH v2 lttng-ust] Introduce vtracef
Date: Wed, 5 Feb 2020 21:55:13 -0500
Message-ID: <ab61c9c5-679b-4b4a-ddc9-b3559b633a1a@simark.ca>
References: <20200205233640.21765-1-maxime.roussinbelanger@gmail.com>
 <266d72f8-cf50-151d-4960-b443bbf2e2f6@simark.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 48Cjhz0ZqFz2CCD
 for <lttng-dev@lists.lttng.org>; Wed,  5 Feb 2020 21:55:14 -0500 (EST)
In-Reply-To: <266d72f8-cf50-151d-4960-b443bbf2e2f6@simark.ca>
Content-Language: en-US-large
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>, lttng-dev@lists.lttng.org, champagne.guillaume.c@gmail.com
List-Id: lttng-dev@lists.lttng.org

On 2020-02-05 8:17 p.m., Simon Marchi wrote:
> On 2020-02-05 6:36 p.m., Maxime Roussin-Belanger wrote:
>> vtracef accepts a va_list argument to simplify tracing
>> functions which use a va_list
>>
>> Here's an example from wpa_supplicant that I wanted to
>> trace:
>>
>> void wpa_debug(int level, const char* fmt, ...) {
>>
>>     va_list ap;
>>     va_start(ap, fmt);
>>
>>     ...
>>     // The call I want to easily trace with vtracef
>>     vprintf(fmt, ap);
>>
>>     ...
>>     va_end(ap);
>> }
>>
>> wpa_debug is used a fair amount and it would be annoying to
>> replace all the wpa_debug calls with tracef.
>>
>> With vtracef, it simplifies the find and replace effort by
>> only changing it at one place.
>>
>> Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
>> ---
>> Changes in v2:
>> 	- Add man page
>> 	- Add an example
>> 	- Remove ifdef to guard against systemtap not having va_list
>>
>> doc/examples/demo-tracef/Makefile       | 14 +++++-
>>  doc/examples/demo-tracef/demo-vtracef.c | 58 +++++++++++++++++++++++++
>>  doc/man/tracef-tracelog-limitations.txt |  3 ++
>>  doc/man/tracef.3.txt                    | 15 ++++---
>>  include/lttng/tracef.h                  |  8 ++++
>>  liblttng-ust/tracef.c                   | 18 +++++---
>>  6 files changed, 101 insertions(+), 15 deletions(-)
>>  create mode 100644 doc/examples/demo-tracef/demo-vtracef.c
>>
>> diff --git a/doc/examples/demo-tracef/Makefile b/doc/examples/demo-tracef/Makefile
>> index ee207843..809aac19 100644
>> --- a/doc/examples/demo-tracef/Makefile
>> +++ b/doc/examples/demo-tracef/Makefile
>> @@ -20,18 +20,28 @@ LIBS = -ldl -llttng-ust	# On Linux
>>  LOCAL_CPPFLAGS += -I.
>>  AM_V_P := :
>>  
>> -all: demo-tracef
>> +all: demo-tracef demo-vtracef
>>  
>>  demo-tracef.o: demo-tracef.c
>>  	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
>>  		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
>>  		$(CFLAGS) -c -o $@ $<
>>  
>>  demo-tracef: demo-tracef.o
>>  	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
>>  		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
>>  		-o $@ $< $(LIBS)
>>  
>> +demo-vtracef.o: demo-vtracef.c
>> +	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
>> +		$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(AM_CFLAGS) $(AM_CPPFLAGS) \
>> +		$(CFLAGS) -c -o $@ $<
>> +
>> +demo-vtracef: demo-vtracef.o
>> +	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
>> +		$(CC) $(LDFLAGS) $(AM_CFLAGS) $(AM_LDFLAGS) $(CFLAGS) \
>> +		-o $@ $< $(LIBS)
>> +
>>  .PHONY: clean
>>  clean:
>> -	rm -f *.o *.a demo-tracef
>> +	rm -f *.o *.a demo-tracef demo-vtracef
>> diff --git a/doc/examples/demo-tracef/demo-vtracef.c b/doc/examples/demo-tracef/demo-vtracef.c
>> new file mode 100644
>> index 00000000..8eaccf61
>> --- /dev/null
>> +++ b/doc/examples/demo-tracef/demo-vtracef.c
>> @@ -0,0 +1,58 @@
>> +/*
>> + * Copyright (C) 2020  Maxime Roussin-Belanger
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; version 2.1 of
>> + * the License.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
>> + */
>> +
>> +#include <stdarg.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +
>> +#include <lttng/tracef.h>
>> +
>> +
>> +void print_debug(const char* msg, ...) {
>> +	va_list ap;
>> +	va_start(ap, msg);
>> +
>> +	vtracef(msg, ap);
>> +
>> +	va_end(ap);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	int i;
>> +	int delay = 0;
>> +	const char *str = "mystring test";
>> +	long l = 0x42;
>> +
>> +	if (argc == 2)
>> +		delay = atoi(argv[1]);
>> +
>> +	fprintf(stderr, "Demo program starting.\n");
>> +
>> +	sleep(delay);
>> +
>> +	fprintf(stderr, "Tracing... ");
>> +
>> +	for (i = 0; i < 5; i++)
>> +	{
>> +		print_debug("This is a \"%s\" formatted %d event %lx", str, i, l);
>> +	}
>> +	fprintf(stderr, " done.\n");
>> +	return 0;
>> +}
>> diff --git a/doc/man/tracef-tracelog-limitations.txt b/doc/man/tracef-tracelog-limitations.txt
>> index a9491903..ad4130dd 100644
>> --- a/doc/man/tracef-tracelog-limitations.txt
>> +++ b/doc/man/tracef-tracelog-limitations.txt
>> @@ -21,4 +21,7 @@ Thus, +{macro-name}()+ is useful for quick prototyping and debugging, but
>>  should not be considered for any permanent/serious application
>>  instrumentation.
>>  
>> ++v{macro-name}()+ does not have a `STAP_PROBEV()` call, because `STAP_PROBEV()`
>> +does not support `va_list`. If you need it, you should emit this call yourself.
>> +
> 
> This file, as its name implies, is shared between the tracef and tracelog man pages,
> because those two presumably have the same limitations.
> 
> I would therefore probably just add the new text in the LIMITATIONS section of the
> tracef man page, after the inclusion of tracef-tracelog-limitations.txt.  Unless
> you want to also want to implement vtracelog :).
> 
> The other problem is that the "xmlto" command causes the resulting file to be named
> "tracef,_vtracef.3".  That's due to the command name (in the NAME section to end up
> there in the intermediary XML:
> 
>   <refname>tracef, vtracef</refname>
> 
> and that is used by that XSL:
> 
>   docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> 
> to define the filename.
> 
> This has two consequences:
> 
> - doing `make` again rebuilds the file, as the expected output file `tracef.3` is nowhere
>   to be found.
> - doing `make install` fails.
> 
> I'm not too sure how to fix that nicely.  I think the end result we want is for the file to
> still be named "tracef.3" and for "vtracef.3" to be a symlink to it.  This is how the variants of
> printf (which all point to the same man page) are set up:
> 
> -rw-r--r-- 1 root root 9.3K Feb  2  2018 /usr/share/man/man3/printf.3.gz
> lrwxrwxrwx 1 root root   11 Feb  2  2018 /usr/share/man/man3/snprintf.3.gz -> printf.3.gz
> 
> I haven't found a way to force xmlto to use tracef.3 as its output file (please feel free to take
> a look).  We could always put an explicit rule with "mv tracef,_vtracef.3 tracef.3" in it to work
> around it, but let's try to find something cleaner.
> 
> For the symlink, I suppose we can define an explicit rule that uses $(LN_S).
> 
> Simon

Ok, so I poked Phil the doc guy about this, and he spotted that the problem is actually in the
asciidoc -> docbook conversion.  He provided the patch provided below.  I'll try to clean up
that patch and send it formally to the list tomorrow, but I thought I'd send it to you now so
you won't lose time trying to figure this out.

With it, the XML file generated by asciidoc from tracef.3.txt (with your patch applied) contains:

<refnamediv>
    <refname>tracef</refname>
    <refname>vtracef</refname>
    <refpurpose>LTTng-UST printf(3)-like interface</refpurpose>
</refnamediv>

And the resulting filename of the docbook -> man page conversion (the xmlto step) is just tracef.3,
since the XSL takes the value of the first refname.  This step also magically generates a vtracef.3,
which contains:

  .so tracef.3

... which just includes the content of tracef.3 when you do `man 3 vtracef`.  So that's perfect.

All there is left is to adjust the Makefile to:

- teach it that vtracef.3 is built from trace.3.xml (the command `make vtracef.3` should work)
- `make clean` cleans vtracef.3
- `make install` installs vtracef.3

Simon


From a8c8a25becc18135fda6045da3892e91aa12f795 Mon Sep 17 00:00:00 2001
From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Wed, 5 Feb 2020 21:33:32 -0500
Subject: [PATCH] Fix: generation of man pages with multiple refnames

---
 doc/man/Makefile.am   |  6 ++++--
 doc/man/asciidoc.conf | 20 --------------------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/doc/man/Makefile.am b/doc/man/Makefile.am
index f562bfd13a66..14aa4be7c82d 100644
--- a/doc/man/Makefile.am
+++ b/doc/man/Makefile.am
@@ -58,8 +58,10 @@ xmlto_verbose_0 = @echo "  XMLTO     " $@;

 # Tools to execute:
 ADOC = $(asciidoc_verbose)$(ASCIIDOC) -f $(ASCIIDOC_CONF) -d manpage \
-	-a lttng_version="$(PACKAGE_VERSION)" \
-	-a lttng_ust_register_timeout="@LTTNG_UST_DEFAULT_CONSTRUCTOR_TIMEOUT_MS@"
+	-a lttng_ust_register_timeout="@LTTNG_UST_DEFAULT_CONSTRUCTOR_TIMEOUT_MS@" \
+	-a mansource="LTTng" \
+	-a manmanual="LTTng Manual" \
+	-a manversion="$(PACKAGE_VERSION)"

 ADOC_DOCBOOK = $(ADOC) -b docbook
 XTO = $(xmlto_verbose)$(XMLTO) -m $(XSL_FILE) man
diff --git a/doc/man/asciidoc.conf b/doc/man/asciidoc.conf
index e3c8016dc3ff..b3c8709d5ead 100644
--- a/doc/man/asciidoc.conf
+++ b/doc/man/asciidoc.conf
@@ -57,23 +57,3 @@ ifdef::backend-docbook[]
 NOT
 endif::backend-docbook[]
 endif::doctype-manpage[]
-
-# configure XML man page header
-ifdef::doctype-manpage[]
-ifdef::backend-docbook[]
-[header]
-template::[header-declarations]
-<refentry>
-<refmeta>
-<refentrytitle>{mantitle}</refentrytitle>
-<manvolnum>{manvolnum}</manvolnum>
-<refmiscinfo class="source">LTTng</refmiscinfo>
-<refmiscinfo class="version">{lttng_version}</refmiscinfo>
-<refmiscinfo class="manual">LTTng Manual</refmiscinfo>
-</refmeta>
-<refnamediv>
-  <refname>{manname}</refname>
-  <refpurpose>{manpurpose}</refpurpose>
-</refnamediv>
-endif::backend-docbook[]
-endif::doctype-manpage[]
-- 
2.25.0
