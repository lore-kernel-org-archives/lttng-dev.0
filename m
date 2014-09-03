From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] configure.ac: fix "missing jni.h" error
 message
Date: Wed, 3 Sep 2014 18:33:08 +0000 (UTC)
Message-ID: <536555776.16719.1409769188617.JavaMail.zimbra__39817.9676304155$1409769109$gmane$org@efficios.com>
References: <1409688775-5119-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XPFKP-0007s2-In
 for lttng-dev@lists.lttng.org; Wed, 03 Sep 2014 14:30:51 -0400
In-Reply-To: <1409688775-5119-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> From: "Philippe Proulx" <eeppeliteloop@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, September 2, 2014 4:12:55 PM
> Subject: [lttng-dev] [PATCH] configure.ac: fix "missing jni.h" error message
> 
> DIR in --with-java-jdk=DIR must point to the JDK base
> directory, not the actual JDK include directory.
> 
> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 726c8e9..175a0a6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -272,7 +272,7 @@ AS_IF([test "x$jni_interface" = "xyes"],[
>          AC_CHECK_HEADERS([jni.h],[],[
>          AC_MSG_ERROR([missing jni.h
>  Make sure Sun Java, OpenJDK or GCJ is installed and that this header file
>  exists in the system path.
> -Use the --with-java-jdk=DIR flag to point to your Java include files, or
> disable the JNI interface.])
> +Use the --with-java-jdk=DIR option to point to your JDK directory, or
> disable the JNI interface.])
>  	])
>  ])
>  AM_CONDITIONAL([BUILD_JNI_INTERFACE], [test "x$jni_interface" = "xyes"])
> --
> 2.1.0
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
