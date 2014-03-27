From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: lttng-tools liburcu path
Date: Thu, 27 Mar 2014 13:25:25 +0100
Message-ID: <20140327122524.GB29197__16106.7848247059$1395923236$gmane$org@hal>
References: <20140327103453.GA29197@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jan.glauber@gmail.com>) id 1WT9O7-0002cl-Hf
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 08:26:32 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so2806484eek.15
	for <lttng-dev@lists.lttng.org>; Thu, 27 Mar 2014 05:26:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140327103453.GA29197@hal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

With this patch it works for me, but I'm no autoconf wizard and I just realized
I also could use:

./configure  --disable-lttng-ust --with-lttng-ust-prefix=/usr/local/

to make it work since all I need is the additional -L path...

--Jan

diff --git a/configure.ac b/configure.ac
index 54f82cf..59e8344 100644
--- a/configure.ac
+++ b/configure.ac
@@ -200,6 +200,15 @@ AC_CHECK_DECL([cmm_smp_mb__before_uatomic_or], [],
         [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
 )
 
+AC_ARG_WITH(liburcu-prefix,
+  AS_HELP_STRING([--with-liburcu-prefix=PATH],
+                 [Specify the installation prefix of the liburcu library.
+	          Headers must be in PATH/include; libraries in PATH/lib.]),
+		  [
+		    CPPFLAGS="$CPPFLAGS -I${withval}/include"
+		    LDFLAGS="$LDFLAGS -L${withval}/lib64 -L${withval}/lib"
+		  ])
+
 AC_ARG_WITH(lttng-ust-prefix,
   AS_HELP_STRING([--with-lttng-ust-prefix=PATH],
                  [Specify the installation prefix of the lttng-ust library.

On Thu, Mar 27, 2014 at 11:34:54AM +0100, Jan Glauber wrote:
> Hi David,
> 
> I'm getting linker errors for lttng-tools, due to an older version of
> liburcu (<0.7) installed. Now I was looking for a configure switch to
> specify where the liburcu that should be used is but I didn't find one.
> 
> Would it be possible to add something like --with-xml-prefix= but for
> luburcu?
> 
> thanks, Jan
