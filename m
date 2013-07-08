From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Babeltrace PATCH 03/23] Add MinGW implementation
	of UUID	functions
Date: Mon, 8 Jul 2013 10:12:26 -0400
Message-ID: <20130708141226.GD22703__48631.2196277597$1373292773$gmane$org@Krystal>
References: <009B25148989C6458484484699278506E5382EED@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwCB2-0005MO-Jy
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 10:12:28 -0400
Content-Disposition: inline
In-Reply-To: <009B25148989C6458484484699278506E5382EED@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged as:

commit 9d1e7de0dd0572e8071e0bd620c1c569e8b5396b
Author: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Date:   Mon Jul 8 10:01:44 2013 -0400

    Add MinGW implementation of UUID functions
    
    Add implementation of the UUID functions for MinGW.
    The Windows UUID standard has a different endian from what we expect,
    so also do endian conversion for the UUID data types as needed.
    Add the MinGW implementation file to the build system.
    In configure.ac, assume that MinGW UUID functions exist.
    
    [ Edit by Mathieu Desnoyers: coding style fixes, use strncmp rather than
      strcmp. Use already existing defines rather than hardcoded integers. ]
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

* Ikaheimonen, JP (jp_ikaheimonen@mentor.com) wrote:
> Add implementation of the UUID functions for MinGW.
> The Windows UUID standard has a different endian from what we expect,
> so also do endian conversion for the UUID data types as needed.
> Add the MinGW implementation file to the build system.
> In configure.ac, assume that MinGW UUID functions exist.
> ---
>  Makefile.am                      |  2 +-
>  compat/Makefile.am               | 12 ++++++
>  compat/compat_uuid.c             | 80 ++++++++++++++++++++++++++++++++++++++++
>  configure.ac                     |  6 ++-
>  converter/Makefile.am            |  4 +-
>  include/babeltrace/compat/uuid.h | 39 ++++++++++++++++++--
>  lib/Makefile.am                  |  3 +-
>  7 files changed, 138 insertions(+), 8 deletions(-)
>  create mode 100644 compat/Makefile.am
>  create mode 100644 compat/compat_uuid.c
> 
> diff --git a/Makefile.am b/Makefile.am
> index b25b58f..cdfad5a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -2,7 +2,7 @@ AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
>  
>  ACLOCAL_AMFLAGS = -I m4
>  
> -SUBDIRS = include types lib formats converter tests doc extras
> +SUBDIRS = include types compat lib formats converter tests doc extras
>  
>  dist_doc_DATA = ChangeLog LICENSE mit-license.txt gpl-2.0.txt \
>  		std-ext-lib.txt
> diff --git a/compat/Makefile.am b/compat/Makefile.am
> new file mode 100644
> index 0000000..79be1c8
> --- /dev/null
> +++ b/compat/Makefile.am
> @@ -0,0 +1,12 @@
> +AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
> +
> +lib_LTLIBRARIES = libcompat.la
> +
> +libcompat_la_SOURCES =
> +
> +libcompat_la_LDFLAGS = \
> +	-Wl,--no-as-needed
> +
> +if BABELTRACE_BUILD_WITH_MINGW
> +libcompat_la_SOURCES += compat_uuid.c
> +endif
> diff --git a/compat/compat_uuid.c b/compat/compat_uuid.c
> new file mode 100644
> index 0000000..585436c
> --- /dev/null
> +++ b/compat/compat_uuid.c
> @@ -0,0 +1,80 @@
> +/* This file is only built under MINGW32 */
> +
> +#include <windows.h>
> +#include <stdlib.h>
> +#include <babeltrace/compat/uuid.h>
> +
> +static void fix_uuid_endian(unsigned char * ptr)
> +{
> +	unsigned char tmp;
> +
> +	/* MinGW does not provide byteswap - implement our own version. */
> +	#define SWAP(p, i, j) tmp=*(p+i);*(p+i)=*(p+j);*(p+j)=tmp;
> +
> +	SWAP(ptr, 0, 3)
> +	SWAP(ptr, 1, 2)
> +	SWAP(ptr, 4, 5)
> +	SWAP(ptr, 6, 7)
> +}
> +
> +int compat_uuid_generate(unsigned char *uuid_out)
> +{
> +	RPC_STATUS status;
> +
> +	status = UuidCreate((struct UUID *)uuid_out);
> +	if (status == RPC_S_OK)
> +		return 0;
> +	else
> +		return -1;
> +}
> +
> +int compat_uuid_unparse(const unsigned char *uuid_in, char *str_out)
> +{
> +	RPC_STATUS status;
> +	unsigned char *alloc_str;
> +	int ret;
> +	unsigned char copy_of_uuid_in[16];
> +
> +	/* make a modifyable copy of uuid_in */
> +	memcpy(copy_of_uuid_in, uuid_in, 16);
> +
> +	fix_uuid_endian(copy_of_uuid_in);
> +	status = UuidToString((struct UUID *)copy_of_uuid_in, &alloc_str);
> +
> +	if (status == RPC_S_OK) {
> +		strcpy(str_out, (char *)alloc_str);
> +		ret = 0;
> +	} else {
> +		ret = -1;
> +	}
> +	RpcStringFree(&alloc_str);
> +	return ret;
> +}
> +
> +int compat_uuid_parse(const char *str_in, unsigned char *uuid_out)
> +{
> +	RPC_STATUS status;
> +
> +	status = UuidFromString((unsigned char *)str_in, (struct UUID *)uuid_out);
> +	fix_uuid_endian(uuid_out);
> +
> +	if (status == RPC_S_OK)
> +		return 0;
> +	else
> +		return -1;
> +}
> +
> +int compat_uuid_compare(const unsigned char *uuid_a,
> +		const unsigned char *uuid_b)
> +{
> +	RPC_STATUS status;
> +	int ret;
> +
> +	if (UuidCompare((struct UUID *)uuid_a, (struct UUID *)uuid_b, &status) == 0)
> +		ret = 0;
> +	else
> +	{
> +		ret = -1;
> +	}
> +	return ret;
> +}
> diff --git a/configure.ac b/configure.ac
> index 17efc87..5f9e38d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -60,7 +60,10 @@ AC_CHECK_LIB([uuid], [uuid_generate],
>  		have_libc_uuid=yes
>  	],
>  	[
> -		AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
> +		# for MinGW32 we have our own internal implemenation of uuid using Windows functions.
> +		if test "x$MINGW32" = xno; then
> +			AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
> +		fi
>  	])
>  ]
>  )
> @@ -102,6 +105,7 @@ AC_SUBST(babeltracectfincludedir)
>  AC_CONFIG_FILES([
>  	Makefile
>  	types/Makefile
> +	compat/Makefile
>  	formats/Makefile
>  	formats/ctf/Makefile
>  	formats/ctf/types/Makefile
> diff --git a/converter/Makefile.am b/converter/Makefile.am
> index 8ef71a2..3248d44 100644
> --- a/converter/Makefile.am
> +++ b/converter/Makefile.am
> @@ -13,6 +13,7 @@ babeltrace_LDFLAGS = -Wl,--no-as-needed
>  babeltrace_LDADD = \
>  	$(top_builddir)/lib/libbabeltrace.la \
>  	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la \
> +	$(top_builddir)/compat/libcompat.la \
>  	$(top_builddir)/formats/ctf-text/libbabeltrace-ctf-text.la \
>  	$(top_builddir)/formats/ctf-metadata/libbabeltrace-ctf-metadata.la \
>  	$(top_builddir)/formats/bt-dummy/libbabeltrace-dummy.la
> @@ -21,7 +22,8 @@ babeltrace_log_SOURCES = babeltrace-log.c
>  
>  babeltrace_log_LDADD = \
>  	$(top_builddir)/lib/libbabeltrace.la \
> -	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la
> +	$(top_builddir)/formats/ctf/libbabeltrace-ctf.la \
> +	$(top_builddir)/compat/libcompat.la
>  
>  if BABELTRACE_BUILD_WITH_LIBUUID
>  babeltrace_log_LDADD += -luuid
> diff --git a/include/babeltrace/compat/uuid.h b/include/babeltrace/compat/uuid.h
> index 2ce7467..2f52f40 100644
> --- a/include/babeltrace/compat/uuid.h
> +++ b/include/babeltrace/compat/uuid.h
> @@ -1,8 +1,8 @@
> -#ifndef _BABELTRACE_UUID_H
> -#define _BABELTRACE_UUID_H
> +#ifndef _BABELTRACE_COMPAT_UUID_H
> +#define _BABELTRACE_COMPAT_UUID_H
>  
>  /*
> - * babeltrace/uuid.h
> + * babeltrace/compat/uuid.h
>   *
>   * Copyright (C) 2011   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
> @@ -122,8 +122,39 @@ int babeltrace_uuid_compare(const unsigned char *uuid_a,
>  		return -1;
>  }
>  
> +#elif defined(__MINGW32__)
> +static inline
> +int babeltrace_uuid_generate(unsigned char *uuid_out)
> +{
> +	extern int compat_uuid_generate(unsigned char *uuid_out);
> +	return compat_uuid_generate(uuid_out);
> +}
> +
> +static inline
> +int babeltrace_uuid_unparse(const unsigned char *uuid_in, char *str_out)
> +{
> +	extern int compat_uuid_unparse(const unsigned char *uuid_in, char *str_out);
> +	return compat_uuid_unparse(uuid_in, str_out);
> +}
> +
> +static inline
> +int babeltrace_uuid_parse(const char *str_in, unsigned char *uuid_out)
> +{
> +	extern int compat_uuid_parse(const char *str_in, unsigned char *uuid_out);
> +	return compat_uuid_parse(str_in, uuid_out);
> +}
> +
> +static inline
> +int babeltrace_uuid_compare(const unsigned char *uuid_a,
> +		const unsigned char *uuid_b)
> +{
> +	extern int compat_uuid_compare(const unsigned char *uuid_a,
> +		const unsigned char *uuid_b);
> +	return compat_uuid_compare(uuid_a, uuid_b);
> +}
> +
>  #else
>  #error "Babeltrace needs to have a UUID generator configured."
>  #endif
>  
> -#endif /* _BABELTRACE_UUID_H */
> +#endif /* _BABELTRACE_COMPAT_UUID_H */
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 7ffb164..fa470c0 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -14,4 +14,5 @@ libbabeltrace_la_SOURCES = babeltrace.c \
>  libbabeltrace_la_LDFLAGS = \
>  	-Wl,--no-as-needed \
>  	prio_heap/libprio_heap.la \
> -	$(top_builddir)/types/libbabeltrace_types.la
> +	$(top_builddir)/types/libbabeltrace_types.la \
> +	$(top_builddir)/compat/libcompat.la
> -- 
> 1.8.1.msysgit.1
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
