From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Wrong CLASSPATH when
 building liblttng-ust-java oot
Date: Thu, 25 Sep 2014 16:28:31 +0000 (UTC)
Message-ID: <2044231907.28027.1411662511411.JavaMail.zimbra__30579.1617524394$1411662416$gmane$org@efficios.com>
References: <1411661252-28088-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XXBrp-00073G-TR
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 12:26:07 -0400
In-Reply-To: <1411661252-28088-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

----- Original Message -----
> From: "Christian Babeux" <christian.babeux@efficios.com>
> To: lttng-dev@lists.lttng.org
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "Christian Babeux" <christian.babeux@efficios.com>
> Sent: Thursday, September 25, 2014 12:07:32 PM
> Subject: [PATCH lttng-ust] Fix: Wrong CLASSPATH when building liblttng-ust-java oot
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  liblttng-ust-java/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust-java/Makefile.am b/liblttng-ust-java/Makefile.am
> index 203a9ff..fee9b7d 100644
> --- a/liblttng-ust-java/Makefile.am
> +++ b/liblttng-ust-java/Makefile.am
> @@ -20,7 +20,7 @@ $(jarfile): classnoinst.stamp
>  org_lttng_ust_LTTngUst.h: jni-header.stamp
>  
>  jni-header.stamp: $(dist_noinst_JAVA)
> -	$(JAVAH) -cp . $(JAVAHFLAGS) org.lttng.ust.LTTngUst && \
> +	$(JAVAH) -cp $(srcdir) $(JAVAHFLAGS) org.lttng.ust.LTTngUst && \
>  	echo "JNI header generated" > jni-header.stamp
>  
>  all-local: org_lttng_ust_LTTngUst.h
> --
> 2.1.0
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
