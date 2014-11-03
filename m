From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Add versioning to
	liblttng-ust-agent JAR
Date: Mon, 3 Nov 2014 20:18:09 +0000 (UTC)
Message-ID: <582491195.6992.1415045889067.JavaMail.zimbra__14921.5279998772$1415045956$gmane$org@efficios.com>
References: <1415045546-21425-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XlO4x-0001FA-1j
 for lttng-dev@lists.lttng.org; Mon, 03 Nov 2014 15:18:24 -0500
In-Reply-To: <1415045546-21425-1-git-send-email-christian.babeux@efficios.com>
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
> Sent: Monday, November 3, 2014 3:12:26 PM
> Subject: [PATCH lttng-ust] Fix: Add versioning to liblttng-ust-agent JAR
> 
> The liblttng-ust-agent JAR need versioning. The manifest file contains the
> appropriate information about the JAR, such as the current version.
> 
> A symlink is also created and installed in order to point to the latest
> version of the JAR.
> 
> e.g: liblttng-ust-agent.jar -> liblttng-ust-agent-1.0.0.jar
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  configure.ac                                       |  1 +
>  liblttng-ust-java-agent/java/Makefile.am           | 24
>  ++++++++++++++++++----
>  .../java/org/lttng/ust/agent/Manifest.txt          |  7 +++++++
>  3 files changed, 28 insertions(+), 4 deletions(-)
>  create mode 100644
>  liblttng-ust-java-agent/java/org/lttng/ust/agent/Manifest.txt
> 
> diff --git a/configure.ac b/configure.ac
> index 55cec23..18f3739 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -48,6 +48,7 @@ AC_DEFINE_UNQUOTED([VERSION_NAME], ["$version_name"], [UST
> version name])
>  AC_DEFINE_UNQUOTED([VERSION_DESCRIPTION], ["$version_description"], [UST
>  version description])
>  
>  AC_PROG_GREP
> +AC_PROG_LN_S
>  # libtool link_all_deplibs fixup. See http://bugs.lttng.org/issues/321.
>  AC_ARG_ENABLE(libtool-linkdep-fixup,
>  	AS_HELP_STRING([--disable-libtool-linkdep-fixup],
> diff --git a/liblttng-ust-java-agent/java/Makefile.am
> b/liblttng-ust-java-agent/java/Makefile.am
> index 01e81e5..5a406e4 100644
> --- a/liblttng-ust-java-agent/java/Makefile.am
> +++ b/liblttng-ust-java-agent/java/Makefile.am
> @@ -1,12 +1,20 @@
>  JAVAROOT = .
>  
> -jarfile = liblttng-ust-agent.jar
> +pkgpath = org/lttng/ust/agent
> +pkgpath_old = org/lttng/ust/jul
> +
> +jarfile_version = 1.0.0
> +jarfile_manifest = $(pkgpath)/Manifest.txt
> +jarfile_symlink = liblttng-ust-agent.jar
> +jarfile = liblttng-ust-agent-$(jarfile_version).jar
> +
>  jarfile_old = liblttng-ust-jul.jar
> +
>  jardir = $(datadir)/java
> +
>  juljniout = ../jni/jul
>  log4jjniout = ../jni/log4j
> -pkgpath = org/lttng/ust/agent
> -pkgpath_old = org/lttng/ust/jul
> +
>  dist_noinst_JAVA = $(pkgpath)/LTTngAgent.java \
>  		   $(pkgpath)/LTTngSessiondCmd2_6.java \
>  		   $(pkgpath)/LTTngTCPSessiondClient.java \
> @@ -16,6 +24,8 @@ dist_noinst_JAVA = $(pkgpath)/LTTngAgent.java \
>  		   $(pkgpath)/jul/LTTngLogHandler.java \
>  		   $(pkgpath_old)/LTTngAgent.java
>  
> +dist_noinst_DATA = $(jarfile_manifest)
> +
>  jar_DATA = $(jarfile) $(jarfile_old)
>  
>  stamp =
> @@ -36,7 +46,7 @@ classes += $(pkgpath)/log4j/*.class
>  endif
>  
>  $(jarfile): classnoinst.stamp
> -	$(JAR) cf $(JARFLAGS) $@ $(classes)
> +	$(JAR) cfm $(JARFLAGS) $@ $(jarfile_manifest) $(classes) && $(LN_S) $@
> $(jarfile_symlink)
>  
>  $(jarfile_old): classnoinst.stamp
>  	$(JAR) cf $(JARFLAGS) $@ $(pkgpath)/*.class \
> @@ -52,6 +62,12 @@ log4j-jni-header.stamp: $(dist_noinst_JAVA)
>  
>  all-local: $(stamp)
>  
> +install-data-local:
> +	cd $(DESTDIR)/$(jardir); rm -f $(jarfile_symlink); $(LN_S) $(jarfile)
> $(jarfile_symlink)
> +
> +uninstall-local:
> +	cd $(DESTDIR)/$(jardir); rm -f $(jarfile_symlink)
> +
>  CLEANFILES = $(jarfile) $(jarfile_old) $(pkgpath)/*.class
>  $(pkgpath_old)/*.class $(pkgpath)/jul/*.class \
>  	$(pkgpath)/log4j/*.class jul-jni-header.stamp log4j-jni-header.stamp \
>  	$(juljniout)/org_lttng_ust_agent_jul_LTTngLogHandler.h \
> diff --git a/liblttng-ust-java-agent/java/org/lttng/ust/agent/Manifest.txt
> b/liblttng-ust-java-agent/java/org/lttng/ust/agent/Manifest.txt
> new file mode 100644
> index 0000000..d3c7e26
> --- /dev/null
> +++ b/liblttng-ust-java-agent/java/org/lttng/ust/agent/Manifest.txt
> @@ -0,0 +1,7 @@
> +Name: org/lttng/ust/agent/
> +Specification-Title: LTTng UST Java Agent
> +Specification-Version: 1.0.0
> +Specification-Vendor: LTTng Project
> +Implementation-Title: org.lttng.ust.agent
> +Implementation-Version: 1.0.0
> +Implementation-Vendor: LTTng Project
> --
> 2.1.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
