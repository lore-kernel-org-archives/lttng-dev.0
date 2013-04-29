From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Using the additional Eclipse Kernel Trace Plugin
 Views (Control flow, Resources)
Date: Mon, 29 Apr 2013 12:02:36 -0400
Message-ID: <517E999C.7010108__18573.5175422908$1367252881$gmane$org@ericsson.com>
References: <517E4E38.6030507@stud.fh-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1UWqXh-00048l-Hf
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 12:03:05 -0400
In-Reply-To: <517E4E38.6030507@stud.fh-dortmund.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


On 13-04-29 06:40 AM, Andre Bette wrote:
> Hi to everyone,
> in my project I am tracing a embedded system with a non linux OS.
> Output format is CTF. I really like the two extra views in the Eclipse
> Kernel Trace Visualization (Control flow, Resources).
>
> Is there a simple way to use this two views  with an non linux trace ?
> Is there any documentation about the Linux kernel trace format( the
> extra info added into the CTF format) or how the
> data(e.g. prozesses) is processed in the Eclipse Kernel Trace Plugin
> (The idea is to use a "fake" linux trace to use the two extra views. )?
I will give a short answer that I am sure Alexandre Montplaisir will
expand upon, YES!
You need to make a state system with a "state system input" that will
emulate the directory structure of the kernel state system.

It's not EXTREMELY hard, but I think it will get significantly easier in
a couple of months.
Great to hear you like the eclipse viewer, fan mail is always
appreciated. ;)

Matthew
>
>
>
> Best Regards,
> Andre
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
