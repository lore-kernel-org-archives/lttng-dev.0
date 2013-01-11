From: David Goulet <dgoulet@efficios.com>
Subject: Re: Issues running ust 2.1.0 as non root user
Date: Fri, 11 Jan 2013 11:45:06 -0500
Message-ID: <50F04192.3080707__18159.2788700529$1357922749$gmane$org@efficios.com>
References: <968286530.6126265.1357922403542.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TthjE-0000gU-24
	for lttng-dev@lists.lttng.org; Fri, 11 Jan 2013 11:45:12 -0500
In-Reply-To: <968286530.6126265.1357922403542.JavaMail.root@vmware.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aaron Spear <aspear@vmware.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Aaron,

You will have to provide the verbose logs of the session daemon. So,
quite simple, start in an other console the session daemon with your
user like so:

$ lttng-sessiond -vvv --verbose-consumer > /tmp/sessiond.log

And do the "lttng" commands again. It's going to be quite easier to
identify the problem.

A Fatal error of the session daemon, I suspect something is not right
with the installation or you are missing memory which I doubt :).

Thanks!
David

Aaron Spear:
> Hi all,
> 
> I have LTTng 2.1.0 that I built/installed from source, and it all works fine when I run as root.  So as root I can take kernel traces and also ust traces.  However, when I attempt to run UST as a normal user it seems that there is some issue with the session daemon that I am not quite understanding.  It looks like the permissions are correct on the executables in /usr/local/bin and such.  Here is the error that I see with the verbose flag on (not sure if this helps...)
> 
> aspear@aspear-deb64 ~
> $ lttng --verbose create mytest
> DEBUG3: URI string: file:///home/aspear/lttng-traces/mytest-20130111-093135 [in uri_parse() at uri.c:253]
> DEBUG3: URI file destination: /home/aspear/lttng-traces/mytest-20130111-093135 [in uri_parse() at uri.c:290]
> DEBUG3: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 [in uri_parse() at uri.c:467]
> DEBUG1: LSM cmd type : 8 [in send_session_msg() at lttng-ctl.c:259]
> Session mytest created.
> Traces will be written in /home/aspear/lttng-traces/mytest-20130111-093135
> DEBUG1: Init config session in /home/aspear [in config_init() at conf.c:294]
> 
> aspear@aspear-deb64 ~
> $ lttng --verbose enable-event -a -u
> DEBUG1: Session name found: mytest [in get_session_name() at utils.c:51]
> DEBUG1: LSM cmd type : 6 [in send_session_msg() at lttng-ctl.c:259]
> Error: Events: Fatal error of the session daemon (channel channel0, session mytest)
> DEBUG1: Clean exit [in clean_exit() at lttng.c:169]
> 
> Is there perhaps some other setup step required when you do the install from source that the install does for a normal user?
> 
> thanks,
> Aaron Spear
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
