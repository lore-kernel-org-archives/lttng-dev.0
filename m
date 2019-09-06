From: Rana Shakti singh <rana94302@gmail.com>
Subject: No session daemon is available
Date: Fri, 6 Sep 2019 21:12:51 +0530
Message-ID: <CANWMcmneyQzNv870bCSspGkSaFJF4i=YY19r9cvfA3TsTGRAAg__36591.1820482992$1567784604$gmane$org@mail.gmail.com>
References: <CANWMcmnyX8eqdGDxGJEW70z9kCpdc0kf3_qBFJZEXkVPyOA0jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0550202869416396123=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by lists.lttng.org (Postfix) with ESMTPS id 46Q1zY3VmPzsG6
 for <lttng-dev@lists.lttng.org>; Fri,  6 Sep 2019 11:43:05 -0400 (EDT)
Received: by mail-wr1-x42b.google.com with SMTP id l11so7074333wrx.5
 for <lttng-dev@lists.lttng.org>; Fri, 06 Sep 2019 08:43:05 -0700 (PDT)
In-Reply-To: <CANWMcmnyX8eqdGDxGJEW70z9kCpdc0kf3_qBFJZEXkVPyOA0jw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0550202869416396123==
Content-Type: multipart/alternative; boundary="0000000000002ffa3d0591e44b2a"

--0000000000002ffa3d0591e44b2a
Content-Type: text/plain; charset="UTF-8"

Hi,

I am enabling event using following steps but i am getting following error:

1.$ lttng create my-test-trace
Spawning a session daemon
Session my-test-trace created.
Traces will be output to
/home/rana/lttng-traces/my-test-trace-20190905-220127

2.sudo lttng enable-channel --kernel --subbuf-size=8M chan1
Error: Channel chan1: No session daemon is available (session my-session)

3.$ lttng enable-event --session=my-test-trace --kernel --channel=channel0
sched_switch
Error: Event sched_switch: No session daemon is available (channel
channel0, session my-test-trace)

Your suggestion will be appreciated

--0000000000002ffa3d0591e44b2a
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><div class="gmail_quote" dir="auto"><div dir="ltr" class="gmail_attr">Hi,<br></div><div dir="ltr"><p>I am enabling event using following steps but i am getting following error:<br>
</p>
<p>1.$ lttng create my-test-trace<br>
Spawning a session daemon<br>
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

--0000000000002ffa3d0591e44b2a--

--===============0550202869416396123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0550202869416396123==--
