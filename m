From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [lttng-tools PATCH] lttng-tools python module v2
Date: Wed, 08 Aug 2012 16:44:15 -0400
Message-ID: <5022CF9F.9090500__41151.8367393457$1344458685$gmane$org@gmail.com>
References: <1344452188-7579-1-git-send-email-danny.serres@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gh0-f176.google.com ([209.85.160.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SzD79-00032R-AA
	for lttng-dev@lists.lttng.org; Wed, 08 Aug 2012 16:44:23 -0400
Received: by ghbz10 with SMTP id z10so1498478ghb.35
	for <lttng-dev@lists.lttng.org>; Wed, 08 Aug 2012 13:44:17 -0700 (PDT)
In-Reply-To: <1344452188-7579-1-git-send-email-danny.serres@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Danny Serres <danny.serres@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2012-08-08 14:56, Danny Serres wrote:
> The lttng-tools Python module can be used to directly control
> the lttng-tools API inside Python, using 'import lttng'.
>
> Therefore, it becomes possible to create a trace, add events,
> start/stop tracing, destroy a session and so on from within Python.
>
> The module does not include URI-related functions.
>
> SWIG >= 2.0 is used to create the wrapper and its
> 'warning md variable unused' bug is patched in Makefile.am.
>

But I don't think that stuff in "extra" should be in the build system.
