From: Dmitri Shubin <sbn@tbricks.com>
Subject: How to check is tracepoint is currently enabled (UST)
Date: Sun, 22 Jun 2014 19:27:31 +0400
Message-ID: <CADmgc-v_RxXAjZtqYk=VkDoD9W9r1XTs7j5Sg-68F0vhkYyr1w__21380.0374920995$1403450915$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1973113796=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sbn@tbricks.com>) id 1Wyjg9-0007uS-Ax
 for lttng-dev@lists.lttng.org; Sun, 22 Jun 2014 11:27:39 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so4676048ieb.6
 for <lttng-dev@lists.lttng.org>; Sun, 22 Jun 2014 08:27:31 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1973113796==
Content-Type: multipart/alternative; boundary=089e0122f7f479ddf604fc6e5d27

--089e0122f7f479ddf604fc6e5d27
Content-Type: text/plain; charset=UTF-8

Hi,

In dtrace it's possible to check if some probe is currently enabled or not
(to avoid argument preparation for disabled probes).
But I'm unable to find similar feature in lttng-ust (at least it's not
mentioned in lttng-ust man page).

Am I missed it or it's not implemented on purpose?

From what I see in lttng/tracepoint.h it can be implemented like

#define tracepoint_enabled(provider,
name) caa_unlikely(__tracepoint_##provider##___##name.state)

Thanks!

--089e0122f7f479ddf604fc6e5d27
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>In dtrace it&#39;s possible to chec=
k if some probe is currently enabled or not (to avoid argument preparation =
for disabled probes).</div><div>But I&#39;m unable to find similar feature =
in lttng-ust (at least it&#39;s not mentioned in lttng-ust man page).</div>
<div><br></div><div>Am I missed it or it&#39;s not implemented on purpose?<=
/div><div><br></div><div>From what I see in lttng/tracepoint.h it can be im=
plemented like</div><div><br></div><div>#define tracepoint_enabled(provider=
, name)=C2=A0caa_unlikely(__tracepoint_##provider##___##name.state)<br>
</div><div><br></div><div>Thanks!</div><div><br></div></div>

--089e0122f7f479ddf604fc6e5d27--


--===============1973113796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1973113796==--
