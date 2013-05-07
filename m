From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Conditionally
	disable	overlap app test requiring shared libs support
Date: Mon, 6 May 2013 22:55:07 -0400
Message-ID: <20130507025507.GB24603__46664.5468412482$1367895347$gmane$org@Krystal>
References: <1360295224-5970-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZY3b-0004Wy-JZ
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 22:55:11 -0400
Content-Disposition: inline
In-Reply-To: <1360295224-5970-1-git-send-email-christian.babeux@efficios.com>
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

For the records, this patch was merged into lttng-tools a while ago as:

commit ccf7af6c78ba7a206baa9d0b9578468a1af734e1
Author: Christian Babeux <christian.babeux@efficios.com>
Date:   Thu Feb 7 22:47:04 2013 -0500

    Fix: Conditionally disable test requiring shared libs
    
    When building lttng-tools with shared library support explicitly
    disabled (e.g.: ./configure --disable-shared), libtool fail with a fatal
    error:
    
    Making all in demo
      CC       tp.lo
      CC       tp2.lo
      CC       tp3.lo
      CC       demo.o
      CCLD     demo
      CCLD     liblttng-ust-provider-ust-tests-demo.la
      CCLD     liblttng-ust-provider-ust-tests-demo3.la
    libtool: link: can not build a shared library
    libtool: link: See the libtool documentation for more information.
    libtool: link: Fatal configuration error.
    
    The build should not fail because some tests require explicit shared
    library support, instead they should be skipped. This can be
    accomplished by detecting builds with no shared libs support with the
    NO_SHARED Automake variable.
    
    Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
    Signed-off-by: David Goulet <dgoulet@efficios.com>

* Christian Babeux (christian.babeux@efficios.com) wrote:
> When building lttng-tools with shared library support explicitly
> disabled (e.g.: ./configure --disable-shared), libtool fail with
> a fatal error:
> 
> Making all in demo
>   CC       tp.lo
>   CC       tp2.lo
>   CC       tp3.lo
>   CC       demo.o
>   CCLD     demo
>   CCLD     liblttng-ust-provider-ust-tests-demo.la
>   CCLD     liblttng-ust-provider-ust-tests-demo3.la
> libtool: link: can not build a shared library
> libtool: link: See the libtool documentation for more information.
> libtool: link: Fatal configuration error.
> 
> The build should not fail because some tests require explicit shared
> library support, instead they should be skipped. This can be accomplished
> by detecting builds with no shared libs support with the NO_SHARED
> Automake variable.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/ust/overlap/demo/Makefile.am | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/ust/overlap/demo/Makefile.am b/tests/ust/overlap/demo/Makefile.am
> index e354636..68b6e08 100644
> --- a/tests/ust/overlap/demo/Makefile.am
> +++ b/tests/ust/overlap/demo/Makefile.am
> @@ -1,5 +1,10 @@
>  AM_CFLAGS=-I$(srcdir)
> -
> +if NO_SHARED
> +# Do not build this test if shared libraries support was
> +# explicitly disabled.
> +else
> +# Force the shared flag on the noinst libraries since they are
> +# only built static by default
>  FORCE_SHARED_LIB_OPTIONS = -module -shared -avoid-version \
>  						   -rpath $(abs_builddir)
>  
> @@ -30,3 +35,4 @@ endif
>  
>  noinst_SCRIPTS = demo-trace
>  EXTRA_DIST = demo-trace
> +endif
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
