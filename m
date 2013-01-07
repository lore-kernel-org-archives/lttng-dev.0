From: David Goulet <dgoulet@ev0ke.net>
Subject: Re: [LTTng-Tools PATCH] Add pkg-config for liblttng-ctl
 [v2]
Date: Mon, 07 Jan 2013 15:07:32 -0500
Message-ID: <50EB2B04.20300__37715.6240087517$1357589296$gmane$org@ev0ke.net>
References: <1356031866-24252-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@ev0ke.net>) id 1TsIyu-0002Xi-Hg
	for lttng-dev@lists.lttng.org; Mon, 07 Jan 2013 15:07:36 -0500
In-Reply-To: <1356031866-24252-1-git-send-email-yannick.brosseau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Thanks!
David

Yannick Brosseau:
> v2: Update description
> 
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  .gitignore                        |    2 +-
>  configure.ac                      |    1 +
>  src/lib/lttng-ctl/Makefile.am     |    3 +++
>  src/lib/lttng-ctl/lttng-ctl.pc.in |   13 +++++++++++++
>  4 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100644 src/lib/lttng-ctl/lttng-ctl.pc.in
> 
> diff --git a/.gitignore b/.gitignore
> index 383dbf9..afc97b6 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -35,7 +35,7 @@ src/bin/lttng-sessiond/lttng-sessiond
>  src/bin/lttng/lttng
>  src/bin/lttng-consumerd/lttng-consumerd
>  src/bin/lttng-relayd/lttng-relayd
> -
> +src/lib/lttng-ctl/lttng-ctl.pc
>  src/lib/lttng-ctl/filter/filter-grammar-test
>  src/lib/lttng-ctl/filter/filter-lexer.c
>  src/lib/lttng-ctl/filter/filter-parser.c
> diff --git a/configure.ac b/configure.ac
> index 54aa385..be6736c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -281,6 +281,7 @@ AC_CONFIG_FILES([
>  	src/lib/Makefile
>  	src/lib/lttng-ctl/Makefile
>  	src/lib/lttng-ctl/filter/Makefile
> +	src/lib/lttng-ctl/lttng-ctl.pc
>  	src/bin/Makefile
>  	src/bin/lttng-consumerd/Makefile
>  	src/bin/lttng-sessiond/Makefile
> diff --git a/src/lib/lttng-ctl/Makefile.am b/src/lib/lttng-ctl/Makefile.am
> index 2681bdd..542f4bb 100644
> --- a/src/lib/lttng-ctl/Makefile.am
> +++ b/src/lib/lttng-ctl/Makefile.am
> @@ -11,3 +11,6 @@ liblttng_ctl_la_LIBADD = \
>  		$(top_builddir)/src/common/libcommon.la \
>  		$(top_builddir)/src/common/hashtable/libhashtable.la \
>  		$(top_builddir)/src/lib/lttng-ctl/filter/libfilter.la
> +
> +pkgconfigdir = $(libdir)/pkgconfig
> +pkgconfig_DATA = lttng-ctl.pc
> diff --git a/src/lib/lttng-ctl/lttng-ctl.pc.in b/src/lib/lttng-ctl/lttng-ctl.pc.in
> new file mode 100644
> index 0000000..86382c2
> --- /dev/null
> +++ b/src/lib/lttng-ctl/lttng-ctl.pc.in
> @@ -0,0 +1,13 @@
> +prefix=@prefix@
> +exec_prefix=@exec_prefix@
> +libdir=@libdir@
> +includedir=@includedir@
> +
> +Name: LTTng control library
> +Description: The LTTng control and utility library is a library used to control the tracing sessions of a LTTng-session deamon
> +Version: @PACKAGE_VERSION@
> +Requires:
> +Requires.private: 
> +Libs: -L${libdir} -llttng-ctl
> +Cflags: -I${includedir} 
> +
