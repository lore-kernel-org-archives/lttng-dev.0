From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: No session daemon is available
Date: Sun, 8 Sep 2019 11:15:34 -0400 (EDT)
Message-ID: <1666049472.300.1567955734285.JavaMail.zimbra__43170.0137605489$1567955754$gmane$org@efficios.com>
References: <CANWMcmnyX8eqdGDxGJEW70z9kCpdc0kf3_qBFJZEXkVPyOA0jw@mail.gmail.com>
 <CANWMcmneyQzNv870bCSspGkSaFJF4i=YY19r9cvfA3TsTGRAAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0702288575916308199=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46RFGv56f9zrZM
 for <lttng-dev@lists.lttng.org>; Sun,  8 Sep 2019 11:15:35 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0D434BCC3D
 for <lttng-dev@lists.lttng.org>; Sun,  8 Sep 2019 11:15:35 -0400 (EDT)
In-Reply-To: <CANWMcmneyQzNv870bCSspGkSaFJF4i=YY19r9cvfA3TsTGRAAg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Rana Shakti singh <rana94302@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0702288575916308199==
Content-Type: multipart/alternative;
	boundary="=_124eb3fc-0718-423d-afd4-6c762b3d6148"

--=_124eb3fc-0718-423d-afd4-6c762b3d6148
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Sep 6, 2019, at 4:42 PM, Rana Shakti singh <rana94302@gmail.com> wrote: 

> Hi,

> I am enabling event using following steps but i am getting following error:

> 1.$ lttng create my-test-trace
> Spawning a session daemon

This command run as user is launching a lttng-sessiond as that particular user, which is 
not allowed to do any kernel tracing. 

You'll want to kill that daemon, and launch lttng-sessiond separately as root instead. 

Thanks, 

Mathieu 

> Session my-test-trace created.
> Traces will be output to /home/rana/lttng-traces/my-test-trace-20190905-220127

> 2.sudo lttng enable-channel --kernel --subbuf-size=8M chan1
> Error: Channel chan1: No session daemon is available (session my-session)

> 3.$ lttng enable-event --session=my-test-trace --kernel --channel=channel0
> sched_switch
> Error: Event sched_switch: No session daemon is available (channel channel0,
> session my-test-trace)

> Your suggestion will be appreciated

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_124eb3fc-0718-423d-afd4-6c762b3d6148
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><body><div style="font-family: arial, helvetica, sans-serif; font-size: 12pt; color: #000000"><div><br data-mce-bogus="1"></div><div><span id="zwchr" data-marker="__DIVIDER__">----- On Sep 6, 2019, at 4:42 PM, Rana Shakti singh &lt;rana94302@gmail.com&gt; wrote:<br></span></div><div data-marker="__QUOTED_TEXT__"><blockquote style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir="auto"><div dir="auto" class="elided-text"><div dir="ltr">Hi,<br></div><div dir="ltr"><p>I am enabling event using following steps but i am getting following error:<br>
</p>
<p>1.$ lttng create my-test-trace<br>
Spawning a session daemon</p></div></div></div></blockquote><div><br></div><div>This command run as user is launching a lttng-sessiond as that particular user, which is<br data-mce-bogus="1"></div><div>not allowed to do any kernel tracing.<br data-mce-bogus="1"></div><div><br data-mce-bogus="1"></div><div>You'll want to kill that daemon, and launch lttng-sessiond separately as root instead.<br data-mce-bogus="1"></div><div><br data-mce-bogus="1"></div><div>Thanks,<br data-mce-bogus="1"></div><div><br data-mce-bogus="1"></div><div>Mathieu<br data-mce-bogus="1"></div><blockquote style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir="auto"><div 
 dir="auto" class="elided-text"><div dir="ltr"><p><br>
Session my-test-trace created.<br>
Traces will be output to /home/rana/lttng-traces/my-test-trace-20190905-220127<br>
  <br>
</p>
<p>2.sudo lttng enable-channel --kernel --subbuf-size=8M chan1<br>
Error: Channel chan1: No session daemon is available (session my-session)<br>
  <br>
</p>
<p>3.$ lttng enable-event --session=my-test-trace --kernel --channel=channel0 sched_switch<br>
Error: Event sched_switch: No session daemon is available (channel channel0, session my-test-trace)<br>
</p>
<p>Your suggestion will be appreciated</p></div>
</div></div>
<br>_______________________________________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker="__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_124eb3fc-0718-423d-afd4-6c762b3d6148--

--===============0702288575916308199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0702288575916308199==--
