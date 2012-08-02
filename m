From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-ust] Fix: Libtool fails to find
	dependent	libraries when cross-compiling lttng-ust
Date: Thu, 2 Aug 2012 18:55:55 -0400
Message-ID: <20120802225555.GA31856__7145.52459908209$1343948179$gmane$org@Krystal>
References: <1343940836-21773-1-git-send-email-christian.babeux@efficios.com>
	<1343947036-29236-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sx4JB-0006Wy-Hy
	for lttng-dev@lists.lttng.org; Thu, 02 Aug 2012 18:55:57 -0400
Content-Disposition: inline
In-Reply-To: <1343947036-29236-1-git-send-email-christian.babeux@efficios.com>
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

merged, thanks !

Mathieu

* Christian Babeux (christian.babeux@efficios.com) wrote:
> This problem arise when cross compiling and linking libraries with
> indirect libraries dependencies (such as liblttng-ust). This "bug" is
> caused by an upstream modification in the libtool package on Debian
> system. The libtool "link_all_deplibs" flag is set to "no" by default
> on linux targets (AFAIK, other distros set it to "unknown").
> 
> The chosen solution is to detect such cases via the configure script
> and automagically patch the libtool.m4 by forcing the "link_all_deplibs"
> to "unknown".
> 
> This fixup can be disabled with the appropriate configure flag:
> 
> ./configure --disable-libtool-linkdep-fixup
> 
> Sample configure output on affected systems:
> 
> checking for occurence(s) of link_all_deplibs = no in
> 	 ./config/libtool.m4... 3
> configure: WARNING: the detected libtool will not link all
>  	   dependencies, forcing link_all_deplibs = unknown
> 
> Fixes: #321
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  configure.ac | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 4d40f75..79c33ff 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -39,6 +39,31 @@ version_description="New type of beer, 100% from Quebec, flavored with sapin bea
>  AC_DEFINE_UNQUOTED([VERSION_NAME], ["$version_name"], [UST version name])
>  AC_DEFINE_UNQUOTED([VERSION_DESCRIPTION], ["$version_description"], [UST version description])
>  
> +AC_PROG_GREP
> +# libtool link_all_deplibs fixup. See http://bugs.lttng.org/issues/321.
> +AC_ARG_ENABLE(libtool-linkdep-fixup,
> +	AS_HELP_STRING([--disable-libtool-linkdep-fixup],
> +			[disable the libtool fixup for linking all dependent libraries (link_all_deplibs)]),
> +	libtool_fixup=$enableval,
> +	libtool_fixup=yes)
> +
> +AS_IF([test "x$libtool_fixup" = "xyes"],
> +	    [
> +	    libtool_m4="$srcdir/config/libtool.m4"
> +	    libtool_flag_pattern=".*link_all_deplibs\s*,\s*\$1\s*)"
> +	    AC_MSG_CHECKING([for occurence(s) of link_all_deplibs = no in $libtool_m4])
> +	    libtool_flag_pattern_count=$(grep -c "$libtool_flag_pattern\s*=\s*no" $libtool_m4)
> +	    AS_IF([test $libtool_flag_pattern_count -ne 0],
> +	    [
> +		  AC_MSG_RESULT([$libtool_flag_pattern_count])
> +		  AC_MSG_WARN([the detected libtool will not link all dependencies, forcing link_all_deplibs = unknown])
> +		  sed -i "s/\($libtool_flag_pattern\)\s*=\s*no/\1=unknown/g" $libtool_m4
> +		  ],
> +		  [
> +		  AC_MSG_RESULT([none])
> +		  ])
> +	    ])
> +
>  # Checks for programs.
>  AC_PROG_CC
>  AC_PROG_CXX
> -- 
> 1.7.11.3
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
