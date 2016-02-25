From: Martin Townsend <mtownsend1973@gmail.com>
Subject: Tracing/Profiling boot
Date: Thu, 25 Feb 2016 20:56:40 +0000
Message-ID: <CABatt_wikOevABepAn8ruYDg63b4y+oD1e0nktGp=K85WHJiKA__34625.8173849948$1456433856$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1520255361=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mtownsend1973@gmail.com>) id 1aZ2xq-00089J-IN
 for lttng-dev@lists.lttng.org; Thu, 25 Feb 2016 15:56:48 -0500
Received: by mail-lf0-f51.google.com with SMTP id m1so41374361lfg.0
 for <lttng-dev@lists.lttng.org>; Thu, 25 Feb 2016 12:56:46 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1520255361==
Content-Type: multipart/alternative; boundary=001a11402438522f24052c9e6b5c

--001a11402438522f24052c9e6b5c
Content-Type: text/plain; charset=UTF-8

Hi,

This is a bit of a long shot but does LTTng allow you trace boot?

I'm seeing a weird problem where if I boot with systemd-bootchart if boots
faster than just using systemd as the init process.  I created my own init
process based on  systemd-bootchart and worked out it was down to the fact
it called nanosleep, so I now have my own init process which hands over to
systemd and creates a child that nanosleeps for the boot duration.  I would
really like to trace/profile the scheduler and hrtimers understand what's
happening and try and get a proper fix :)  Even if it means a bit of
hacking kernel/LTTng, I would be willing to do this.

Many Thanks, Martin.

--001a11402438522f24052c9e6b5c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>This is a bit of a long shot bu=
t does LTTng allow you trace boot?<br><br>I&#39;m seeing a weird problem wh=
ere if I boot with systemd-bootchart if boots faster than just using system=
d as the init process.=C2=A0 I created my own init process based on=C2=A0 s=
ystemd-bootchart and worked out it was down to the fact it called nanosleep=
, so I now have my own init process which hands over to systemd and creates=
 a child that nanosleeps for the boot duration.=C2=A0 I would really like t=
o trace/profile the scheduler and hrtimers understand what&#39;s happening =
and try and get a proper fix :)=C2=A0 Even if it means a bit of hacking ker=
nel/LTTng, I would be willing to do this.<br><br></div>Many Thanks, Martin.=
<br></div>

--001a11402438522f24052c9e6b5c--


--===============1520255361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1520255361==--
