From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Babeltrace PATCH 01/23] Add MinGW32 libraries to
	executables
Date: Mon, 8 Jul 2013 10:11:59 -0400
Message-ID: <20130708141159.GB22703__3031.5809687183$1373292752$gmane$org@Krystal>
References: <009B25148989C6458484484699278506E5382EC9@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwCAc-0005Kn-0S
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 10:12:02 -0400
Content-Disposition: inline
In-Reply-To: <009B25148989C6458484484699278506E5382EC9@EU-MBX-01.mgc.mentorg.com>
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

Merged as:


commit 5881989879e8bc9819c14c4ea8bd05b4d159be58
Author: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Date:   Mon Jul 8 09:48:24 2013 -0400

    Add MinGW32 libraries to executables
    
    Make configure.ac aware of MinGW, and set up a variable we can use
    in make files.
    Under MinGW, add platform specific libraries to all link commands.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

* Ikaheimonen, JP (jp_ikaheimonen@mentor.com) wrote:
> Make configure.ac aware of MinGW, and set up a variable we can use
> in make files.
> Under MinGW, add platform specific libraries to all link commands.
> ---
>  configure.ac                     | 9 +++++++++
>  converter/Makefile.am            | 5 +++++
>  formats/ctf/metadata/Makefile.am | 3 +++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 83822d6..17efc87 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -37,6 +37,15 @@ AC_FUNC_MALLOC
>  AC_FUNC_MMAP
>  AC_CHECK_FUNCS([bzero gettimeofday munmap strtoul])
>  
> +# Check for MinGW32.
> +MINGW32=no
> +case $host in
> +  *-*-mingw*)
> +	MINGW32=yes;;
> +esac
> +
> +AM_CONDITIONAL([BABELTRACE_BUILD_WITH_MINGW], [test "x$MINGW32" = "xyes"])
> +
>  # Check for libuuid
>  AC_CHECK_LIB([uuid], [uuid_generate],
>  [
> diff --git a/converter/Makefile.am b/converter/Makefile.am
> index de70313..8ef71a2 100644
> --- a/converter/Makefile.am
> +++ b/converter/Makefile.am
> @@ -29,3 +29,8 @@ endif
>  if BABELTRACE_BUILD_WITH_LIBC_UUID
>  babeltrace_log_LDADD += -lc
>  endif
> +
> +if BABELTRACE_BUILD_WITH_MINGW
> +babeltrace_log_LDADD += -lrpcrt4 -lintl -liconv -lole32 -lpopt -lpthread
> +babeltrace_LDADD += -lrpcrt4 -lintl -liconv -lole32 -lpopt -lpthread
> +endif
> diff --git a/formats/ctf/metadata/Makefile.am b/formats/ctf/metadata/Makefile.am
> index b33ce55..69f7127 100644
> --- a/formats/ctf/metadata/Makefile.am
> +++ b/formats/ctf/metadata/Makefile.am
> @@ -27,6 +27,9 @@ endif
>  if BABELTRACE_BUILD_WITH_LIBC_UUID
>  libctf_ast_la_LIBADD += -lc
>  endif
> +if BABELTRACE_BUILD_WITH_MINGW
> +libctf_ast_la_LIBADD += -lrpcrt4 -lintl -liconv -lole32 -lpopt
> +endif
>  
>  noinst_PROGRAMS = ctf-parser-test
>  ctf_parser_test_SOURCES = ctf-parser-test.c
> -- 
> 1.8.1.msysgit.1
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
