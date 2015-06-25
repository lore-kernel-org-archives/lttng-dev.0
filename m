From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: build log4j example when
	enabled
Date: Thu, 25 Jun 2015 21:18:49 +0000 (UTC)
Message-ID: <45684680.3616.1435267129450.JavaMail.zimbra__19655.001074034$1435267225$gmane$org@efficios.com>
References: <1435266787-16048-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z8EY3-0005i2-9Y
 for lttng-dev@lists.lttng.org; Thu, 25 Jun 2015 17:19:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 41B11340358
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jun 2015 21:18:58 +0000 (UTC)
In-Reply-To: <1435266787-16048-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.6, thanks!

Mathieu

----- On Jun 25, 2015, at 5:13 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> .gitignore                      |  2 +-
> doc/examples/Makefile.am        | 26 +++++++++++++++++++++++---
> doc/examples/java-jul/run       |  3 ++-
> doc/examples/java-log4j/.intree |  0
> doc/examples/java-log4j/run     |  5 +++--
> 5 files changed, 29 insertions(+), 7 deletions(-)
> create mode 100644 doc/examples/java-log4j/.intree
> 
> diff --git a/.gitignore b/.gitignore
> index 166a260..6ff01a4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -54,7 +54,7 @@ tests/benchmark/bench2
> 
> # Java agent library
> *.class
> -liblttng-ust-agent.jar
> +liblttng-ust-agent*.jar
> classnoinst.stamp
> jni-header.stamp
> jul-jni-header.stamp
> diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
> index 0d22602..9404054 100644
> --- a/doc/examples/Makefile.am
> +++ b/doc/examples/Makefile.am
> @@ -8,7 +8,7 @@ doc_examples_demo_tracelogdir = ${docdir}/examples/demo-tracelog
> doc_examples_clock_overridedir = ${docdir}/examples/clock-override
> doc_examples_getcpu_overridedir = ${docdir}/examples/getcpu-override
> 
> -if BUILD_JAVA_AGENT
> +if BUILD_JAVA_AGENT_WITH_JUL
> doc_examples_java_juldir = ${docdir}/examples/java-jul
> dist_doc_examples_java_jul_DATA = java-jul/Makefile \
> 				  java-jul/Hello.java \
> @@ -16,6 +16,14 @@ dist_doc_examples_java_jul_DATA = java-jul/Makefile \
> SUBDIRS_JUL = java-jul
> endif
> 
> +if BUILD_JAVA_AGENT_WITH_LOG4J
> +doc_examples_java_log4jdir = ${docdir}/examples/java-log4j
> +dist_doc_examples_java_log4j_DATA = java-log4j/Makefile \
> +				  java-log4j/Hello.java \
> +				  java-log4j/run
> +SUBDIRS_LOG4J = java-log4j
> +endif
> +
> dist_doc_examples_DATA = README
> 
> dist_doc_examples_easy_ust_DATA = easy-ust/Makefile \
> @@ -74,7 +82,7 @@ endif
> 
> all-local:
> 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
> -		for subdir in $(SUBDIRS_PROXY) $(SUBDIRS_JUL); do \
> +		for subdir in $(SUBDIRS_PROXY) $(SUBDIRS_JUL) $(SUBDIRS_LOG4J); do \
> 			cp -pfR $(srcdir)/$$subdir $(builddir); \
> 		done; \
> 	fi; \
> @@ -99,6 +107,11 @@ all-local:
> 		for subdir in $(SUBDIRS_JUL); do \
> 			(cd $(SUBDIRS_JUL) && $(MAKE)
> 			JAVA_CLASSPATH_OVERRIDE="../../../liblttng-ust-java-agent/java"
> 			JAVA_JARFILE_OVERRIDE="liblttng-ust-agent.jar" $(AM_MAKEFLAGS) all && cd ..) ||
> 			exit 1; \
> 		done; \
> +	fi; \
> +	if [ x"$(SUBDIRS_LOG4J)" != x"" ]; then \
> +		for subdir in $(SUBDIRS_LOG4J); do \
> +			(cd $(SUBDIRS_LOG4J) && $(MAKE)
> JAVA_CLASSPATH_OVERRIDE="../../../liblttng-ust-java-agent/java"
> JAVA_JARFILE_OVERRIDE="liblttng-ust-agent.jar" $(AM_MAKEFLAGS) all && cd ..) ||
> exit 1; \
> +		done; \
> 	fi;
> 
> clean-local:
> @@ -114,8 +127,15 @@ clean-local:
> 			fi; \
> 		done; \
> 	fi; \
> +	if [ x"$(SUBDIRS_LOG4J)" != x"" ]; then \
> +		for subdir in $(SUBDIRS_LOG4J); do \
> +			if [ -d $$subdir ]; then \
> +				(cd $$subdir && $(MAKE) $(AM_MAKEFLAGS) clean && cd ..) || exit 1; \
> +			fi; \
> +		done; \
> +	fi; \
> 	if [ x"$(srcdir)" != x"$(builddir)" ]; then \
> -		for subdir in $(SUBDIRS_PROXY) $(SUBDIRS_JUL); do \
> +		for subdir in $(SUBDIRS_PROXY) $(SUBDIRS_JUL) $(SUBDIRS_LOG4J); do \
> 			rm -rf $(builddir)/$$subdir; \
> 		done; \
> 	fi;
> diff --git a/doc/examples/java-jul/run b/doc/examples/java-jul/run
> index 1beac85..37a3cfd 100755
> --- a/doc/examples/java-jul/run
> +++ b/doc/examples/java-jul/run
> @@ -16,7 +16,8 @@ if [ -f "$DIR/.intree" ]; then
> 	LIBPATH="../../../liblttng-ust-java-agent/jni/jul/.libs"
> else
> 	CLASSPATH="/usr/local/share/java/$JARFILE:/usr/share/java/$JARFILE"
> -	LIBPATH="/usr/local/lib:/usr/lib"
> +	# Use system defined java.library.path
> +	#LIBPATH="/usr/local/lib:/usr/lib"
> fi
> 
> java -classpath "$CLASSPATH:." -Djava.library.path="$LIBPATH" Hello
> diff --git a/doc/examples/java-log4j/.intree b/doc/examples/java-log4j/.intree
> new file mode 100644
> index 0000000..e69de29
> diff --git a/doc/examples/java-log4j/run b/doc/examples/java-log4j/run
> index 128725f..5e3cbeb 100755
> --- a/doc/examples/java-log4j/run
> +++ b/doc/examples/java-log4j/run
> @@ -17,9 +17,10 @@ if [ -f "$DIR/.intree" ]; then
> 	LIBPATH="../../../liblttng-ust-java-agent/jni/log4j/.libs"
> else
> 	CLASSPATH="/usr/local/share/java/$JARFILE:/usr/share/java/$JARFILE:$LOG4J"
> -	LIBPATH="/usr/local/lib:/usr/lib"
> +	# Use system defined java.library.path
> +	#LIBPATH="/usr/local/lib:/usr/lib"
> fi
> 
> -java -classpath "$CLASSPATH:." Hello
> +java -classpath "$CLASSPATH:." -Djava.library.path="$LIBPATH" Hello
> 
> cd -
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
