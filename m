From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Wrong CLASSPATH when
 building liblttng-ust-java-agent oot
Date: Thu, 25 Sep 2014 14:52:51 +0000 (UTC)
Message-ID: <5191666.27862.1411656771952.JavaMail.zimbra__25954.5457935475$1411656684$gmane$org@efficios.com>
References: <1411587845-12232-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XXANJ-0006Kr-Kc
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 10:50:32 -0400
In-Reply-To: <1411587845-12232-1-git-send-email-christian.babeux@efficios.com>
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

Merged, thanks!

Mathieu

----- Original Message -----
> From: "Christian Babeux" <christian.babeux@efficios.com>
> To: lttng-dev@lists.lttng.org
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "Christian Babeux" <christian.babeux@efficios.com>
> Sent: Wednesday, September 24, 2014 3:44:05 PM
> Subject: [PATCH lttng-ust] Fix: Wrong CLASSPATH when building liblttng-ust-java-agent oot
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  liblttng-ust-java-agent/java/Makefile.am | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/liblttng-ust-java-agent/java/Makefile.am
> b/liblttng-ust-java-agent/java/Makefile.am
> index c949bf8..01e81e5 100644
> --- a/liblttng-ust-java-agent/java/Makefile.am
> +++ b/liblttng-ust-java-agent/java/Makefile.am
> @@ -43,11 +43,11 @@ $(jarfile_old): classnoinst.stamp
>  	$(pkgpath)/jul/*.class $(pkgpath_old)/*.class
>  
>  jul-jni-header.stamp: $(dist_noinst_JAVA)
> -	$(JAVAH) -cp $(CLASSPATH):. -d $(juljniout) $(JAVAHFLAGS)
> org.lttng.ust.agent.jul.LTTngLogHandler && \
> +	$(JAVAH) -cp $(CLASSPATH):$(srcdir) -d $(juljniout) $(JAVAHFLAGS)
> org.lttng.ust.agent.jul.LTTngLogHandler && \
>  	echo "JUL JNI header generated" > jul-jni-header.stamp
>  
>  log4j-jni-header.stamp: $(dist_noinst_JAVA)
> -	$(JAVAH) -cp $(CLASSPATH):. -d $(log4jjniout) $(JAVAHFLAGS)
> org.lttng.ust.agent.log4j.LTTngLogAppender && \
> +	$(JAVAH) -cp $(CLASSPATH):$(srcdir) -d $(log4jjniout) $(JAVAHFLAGS)
> org.lttng.ust.agent.log4j.LTTngLogAppender && \
>  	echo "Log4j JNI header generated" > log4j-jni-header.stamp
>  
>  all-local: $(stamp)
> --
> 2.1.0
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
