From: Mosleh Uddin <mosleh1235@gmail.com>
Subject: Tracepoints firing without being enabled in LTTng
Date: Fri, 15 Feb 2019 10:08:19 -0500
Message-ID: <CAJyWpKEMbN8RHuGbODZYFiOff_pN08Zn4A=6dMEEe7C7h3nn1g__23131.634648756$1550243326$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4094459073587118100=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x136.google.com (mail-it1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 by lists.lttng.org (Postfix) with ESMTPS id 441GqM3Kl7zfrq
 for <lttng-dev@lists.lttng.org>; Fri, 15 Feb 2019 10:08:31 -0500 (EST)
Received: by mail-it1-x136.google.com with SMTP id l131so23937863ita.2
 for <lttng-dev@lists.lttng.org>; Fri, 15 Feb 2019 07:08:31 -0800 (PST)
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

--===============4094459073587118100==
Content-Type: multipart/alternative; boundary="000000000000d0ed5a0581f025e5"

--000000000000d0ed5a0581f025e5
Content-Type: text/plain; charset="UTF-8"

Hello,

I am having a strange issue with my current application. For some context,
I have integrated LTTng into a Yocto build and put custom trace points in
my embedded system application. Once I load the built image onto my system
and start a session daemon, I try to list all available userspace events
(using lttng list -u), but no events show up.

The strange occurrence is when I create a session (lltng create my-sess)
and not start tracing the trace events will display on the screen
regardless (when starting session in live mode with lttng view). I was
wondering if anyone has any insight on this issue I am having.

Thanks for any assistance,
Mosleh

--000000000000d0ed5a0581f025e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I am having a strange issue with=
 my current application. For some context, I have integrated LTTng into a Y=
octo build and put custom trace points in my embedded system application. O=
nce I load the built image onto my system and start a session daemon, I try=
 to list all available userspace events (using lttng list -u), but no event=
s show up.</div><div><br></div><div>The strange occurrence is when I create=
 a session (lltng create my-sess) and not start tracing the trace events wi=
ll display on the screen regardless (when starting session in live mode wit=
h lttng view). I was wondering if anyone has any insight on this issue I am=
 having.</div><div><br></div><div>Thanks for any assistance,</div><div>Mosl=
eh</div></div>

--000000000000d0ed5a0581f025e5--

--===============4094459073587118100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4094459073587118100==--
