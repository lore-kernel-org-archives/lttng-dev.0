From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [babeltrace PATCH] Put the libbabeltrace-ctf
	specific parts of	babeltrace.pc into a babeltrace-ctf.pc file.
Date: Thu, 15 Aug 2013 18:12:34 -0400
Message-ID: <20130815221234.GB24819__26369.7450318888$1376604792$gmane$org@Krystal>
References: <1376599750-12146-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VA5mW-0003mo-Ts
	for lttng-dev@lists.lttng.org; Thu, 15 Aug 2013 18:12:39 -0400
Content-Disposition: inline
In-Reply-To: <1376599750-12146-1-git-send-email-yannick.brosseau@gmail.com>
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

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> On some distributions libbabeltrace and libbabeltrace-ctf are packaged into separate
> packages. This means they should have their own pkg-config file.
> 
> The babeltrace-ctf.pc file requires the babeltrace.pc one.
> 
> With this change, to have the ctf support in libbabeltrace a pkg-config user
> will need to specify the babeltrace-ctf package. To compile and link with only
> the base libbabeltrace, the package babeltrace would be use.
> 
> Fixes #550

merged, thanks!

Mathieu

> 
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  Makefile.am          |    2 +-
>  babeltrace-ctf.pc.in |   13 +++++++++++++
>  babeltrace.pc.in     |    2 +-
>  configure.ac         |    1 +
>  4 files changed, 16 insertions(+), 2 deletions(-)
>  create mode 100644 babeltrace-ctf.pc.in
> 
> diff --git a/Makefile.am b/Makefile.am
> index cdfad5a..e5eca77 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -10,4 +10,4 @@ dist_doc_DATA = ChangeLog LICENSE mit-license.txt gpl-2.0.txt \
>  dist_noinst_DATA = CodingStyle
>  
>  pkgconfigdir = $(libdir)/pkgconfig
> -pkgconfig_DATA = babeltrace.pc
> +pkgconfig_DATA = babeltrace.pc babeltrace-ctf.pc
> diff --git a/babeltrace-ctf.pc.in b/babeltrace-ctf.pc.in
> new file mode 100644
> index 0000000..8237607
> --- /dev/null
> +++ b/babeltrace-ctf.pc.in
> @@ -0,0 +1,13 @@
> +prefix=@prefix@
> +exec_prefix=@exec_prefix@
> +libdir=@libdir@
> +includedir=@includedir@
> +
> +Name: Babeltrace CTF parser
> +Description: libbabeltrace-ctf provides the specific bits necessary to read a Common Trace Format (CTF) trace.
> +Version: @PACKAGE_VERSION@
> +Requires: babeltrace
> +Requires.private: 
> +Libs: -L${libdir} -lbabeltrace-ctf
> +Cflags: -I${includedir} 
> +
> diff --git a/babeltrace.pc.in b/babeltrace.pc.in
> index 12349dd..7c33f28 100644
> --- a/babeltrace.pc.in
> +++ b/babeltrace.pc.in
> @@ -9,6 +9,6 @@ Common Trace Format (CTF).
>  Version: @PACKAGE_VERSION@
>  Requires:
>  Requires.private: uuid popt
> -Libs: -L${libdir} -lbabeltrace -lbabeltrace-ctf
> +Libs: -L${libdir} -lbabeltrace
>  Cflags: -I${includedir} 
>  
> diff --git a/configure.ac b/configure.ac
> index a22b1b9..fc70453 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -124,5 +124,6 @@ AC_CONFIG_FILES([
>  	extras/Makefile
>  	extras/valgrind/Makefile
>  	babeltrace.pc
> +	babeltrace-ctf.pc
>  ])
>  AC_OUTPUT
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
