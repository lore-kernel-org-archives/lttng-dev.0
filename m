From: Zifei Tong <soariez@gmail.com>
Subject: Re: [RFC] Dynamic instrumentation support in UST
Date: Tue, 30 Jul 2013 21:25:30 +0800
Message-ID: <CAJ7wx-Hue-Y=Xm1TEtp7YfYfzVVGJgz0OE0iXXMvxhehwJ3bBw__39814.8911576301$1375190848$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD1BE24A83@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1V49wO-0002Le-Db
	for lttng-dev@lists.lttng.org; Tue, 30 Jul 2013 09:26:22 -0400
Received: by mail-vb0-f50.google.com with SMTP id x14so296124vbb.37
	for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2013 06:26:11 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD1BE24A83@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thank you for your comments.

>   When using process IDs, one also has to be careful of PID namespaces: for a member of the 'tracing' group, a PID issued from a local lttng command (e.g. '$ lttng enable-event --pid ...') may need to be translated by the time it reaches the root lttng-sessiond.  Similar concerns exist with user namespaces.  The implications of namespaces are not peculiar to this extension of lttng, however: I would expect lttng to provide namespace-handling utility functions or to otherwise handle namespaces consistently throughout its services.

If lttng could implement a set of general namespace-handling utility
functions, we could use the facility to address the PID namespaces
problem in dynamic instrumentation naturally.

>    The -c command option by itself may be insufficient in some cases.  For instance, if the lttng command is issued from an su shell (e.g. '# lttng trace -c ...'), from a 'tracing' group member (e.g. '$ lttng trace -c ...'), or from some ordinary account (e.g. '$ sudo -H lttng trace -c ...'), the intent may be to specify which user account to run the COMMAND as.

The `lttng trace` command is a long-standing not-implemented-yet
feature #15 [1]. We may need a separated RFC for that.

> An 'lttng trace' command would be problematic anyway since it may need to specify several events to enable, each assigned to a different channel and possibly with a filter as well.  The overall command line could become very unwieldy.

I am thinking we could have a script to specify all these stuff
(context, channel, filter), like Systemtap [2], gdb [3], or extension
based on lttng-gen-tp.

>   I would allow the above command line to specify a process name instead of a process ID, in order to capture multi-threaded and multi-instance processes.
> If enable-event is able to set up latent events (as described in my previous comment block), then 'lttng trace' is unnecessary: the user need only set up his events, channels, etc., using --processname and then issue a proper 'sudo' command to launch the process (sudo has all the requisite options to assign the process to the
proper user account with the proper environment settings, etc.).

If we use the command line interface you described, like

      lttng enable-event --processname a.out

Then we will need a mechanism to distinguish processes with the same
name. For example, I want to instrument my program for debugging but
not touch any processes in production.

>   If it follows the lttng kernel implementation, --function sets up a kretprobe and --probe sets up a kprobe, so in user-space this should work similarly: --probe sets up a function entry event while --function sets up a function entry AND a function return event.

I've updated the RFC to following lttng kernel function probe behavior.

[1]: http://bugs.lttng.org/issues/15
[2]: http://sourceware.org/systemtap/SystemTap_Beginners_Guide/scripts.html
[3]: http://sourceware.org/gdb/onlinedocs/gdb/Tracepoint-Actions.html#Tracepoint-Actions

Thanks,
Zifei Tong
