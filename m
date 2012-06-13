From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu commit a767fd requires autoconf >= 2.64.
Date: Wed, 13 Jun 2012 04:10:01 -0400
Message-ID: <20120613081001.GA30123__38264.2478486106$1339575042$gmane$org@Krystal>
References: <jr9e2h$phq$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SeieR-0001LH-JZ
	for lttng-dev@lists.lttng.org; Wed, 13 Jun 2012 04:10:03 -0400
Content-Disposition: inline
In-Reply-To: <jr9e2h$phq$1@dough.gmane.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: John Steele Scott <toojays@toojays.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* John Steele Scott (toojays@toojays.net) wrote:
> http://lists.lttng.org/pipermail/lttng-dev/2012-May/017927.html
> 
> I tried to build the latest urcu (git master e51500) on a Centos 6.2 box, and got:
> 
> jscott@dxi0-62:~/src/userspace-rcu$ make -j4
> CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run aclocal-1.11 -I config
> CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run autoconf
>  cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run automake-1.11 --foreign
> configure:4010: error: possibly undefined macro: m4_ifnblank
>       If this token and others are legitimate, please use m4_pattern_allow.
>       See the Autoconf documentation.
> make: *** [configure] Error 1
> make: *** Waiting for unfinished jobs....
> 
> Some digging showed that the macro m4_ifnblank requires autoconf 2.64. Centos 6.2 has autoconf 2.63. :(
> 
> I just worked around it by reverting commit a767fd locally, then I can build fine.

Thanks for pointing this out! Can you try the following patch and let me
know if it fixes your issue ?


diff --git a/config/ax_tls.m4 b/config/ax_tls.m4
index 033e3b1..5ab1a41 100644
--- a/config/ax_tls.m4
+++ b/config/ax_tls.m4
@@ -44,7 +44,23 @@
 #   modified version of the Autoconf Macro, you may extend this special
 #   exception to the GPL to apply to your modified version as well.
 
-#serial 10
+#serial 11
+
+#   Define m4_ifblank and m4_ifnblank macros from introduced in
+#   autotools 2.64 m4sugar.m4 if using an earlier autotools.
+
+ifdef([m4_ifblank], [], [
+m4_define([m4_ifblank],
+[m4_if(m4_translit([[$1]],  [ ][	][
+]), [], [$2], [$3])])
+])
+
+
+ifdef([m4_ifnblank], [], [
+m4_define([m4_ifnblank],
+[m4_if(m4_translit([[$1]],  [ ][	][
+]), [], [$3], [$2])])
+])
 
 AC_DEFUN([AX_TLS], [
   AC_MSG_CHECKING(for thread local storage (TLS) class)


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
