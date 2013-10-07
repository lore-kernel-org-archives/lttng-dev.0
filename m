From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTng UST PATCH 0/2] Bug fixes for
	callsite	unregistering
Date: Mon, 7 Oct 2013 13:43:06 +0000 (UTC)
Message-ID: <832048350.29760.1381153386842.JavaMail.zimbra__43485.4057188661$1381155408$gmane$org@efficios.com>
References: <009B25148989C6458484484699278506E538AF34@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VTB5c-0007jS-TF
	for lttng-dev@lists.lttng.org; Mon, 07 Oct 2013 09:43:19 -0400
In-Reply-To: <009B25148989C6458484484699278506E538AF34@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Both patches merged into master, stable-2.2, stable-2.3 (with slight changes). These become the following master commits:

commit 8a7ad54be134997ab5985968ac6ada9ea58cafb9
Author: Ikaheimonen, JP <jp_ikaheimonen@mentor.com>
Date:   Mon Oct 7 09:33:02 2013 -0400

    Add usage reference count for tracepoints
    
    Keep track of how many libraries use a tracepoint, and disable the
    tracepoint when the number of users drops to zero.
    
    A new reference counter is added to tracepoint_entry. This keeps track
    of how many callsites use that tracepoint.
    
    When you have libraries and/or executables sharing tracepoints, you
    cannot just disable your tracepoints when the library is unregistered.
    You must check that the tracepoint is not used by any other libraries
    before you disable it.
    
    Function lib_disable_tracepoints becomes unnecessary, and is removed.
    
    Signed-off-by: Ikaheimonen, JP <jp_ikaheimonen@mentor.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 33f8ed8734a97e749206ec0e856ba2c28a56dcef
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Oct 7 09:30:52 2013 -0400

    tracepoint.c: Move add_callsite/remove_callsite further down in file
    
    In preparation for calling disable_tracepoint() from those functions.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 60d8702955d702f95053b0355d156ae032ac2bc8
Author: Ikaheimonen, JP <jp_ikaheimonen@mentor.com>
Date:   Thu Oct 3 06:46:27 2013 +0000

    Store the callsites into the library callsite list
    
    Fix the issue where the callsites are registered but never
    properly unregistered.
    
    [ Edit by Mathieu Desnoyers: minor coding style fix: remove parenthesis. ]
    
    Signed-off-by: Ikaheimonen, JP <jp_ikaheimonen@mentor.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks a lot for those fixes!!

Mathieu

----- Original Message -----
> From: "JP Ikaheimonen" <jp_ikaheimonen@mentor.com>
> To: lttng-dev@lists.lttng.org
> Sent: Thursday, October 3, 2013 2:46:20 AM
> Subject: [lttng-dev] [LTTng UST PATCH 0/2] Bug fixes for callsite	unregistering
> 
> The following two patches fix one bug each in LTTng UST.
> 
> The first patch makes sure that when a library registers callsites, those
> callsites are also properly unregistered.
> It is only a matter of actually updating the list of callsites during
> registration.
> 
> The second patch deals with nested dynamic libraries. The current code
> disables tracepoints whenever a library destructor gets called.
> But if those tracepoints are also used by some other open library, then they
> stop working.
> The solution in the patch keeps track of how many callsites use a tracepoint,
> and disables the tracepoint only after the last library logs off.
> To work, the first patch must be applied first.
> 
> JP Ikaheimonen | SW Development Engineer
> http://go.mentor.com/sourceryanalyzer
> Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI |
> Multi-OS
> Android is a trademark of Google Inc. Use of this trademark is subject to
> Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other
> countries.
> 
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
