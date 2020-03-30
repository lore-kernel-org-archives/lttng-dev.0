From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: bt2 python - accessing component instances added to
 graph
Date: Sun, 29 Mar 2020 23:24:37 -0600
Message-ID: <CADtyBo4tQxYBFZnk6dqTSkU4OjW2Fxmx0xJrP=ADaCz_YUXf1g@mail.gmail.com>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4665777414816953045=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 48rLWB3yJkz1YPf
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 01:24:54 -0400 (EDT)
Received: by mail-oi1-x22f.google.com with SMTP id u20so9935011oic.4
 for <lttng-dev@lists.lttng.org>; Sun, 29 Mar 2020 22:24:54 -0700 (PDT)
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

--===============4665777414816953045==
Content-Type: multipart/alternative; boundary="000000000000bd4c9305a20bab7f"

--000000000000bd4c9305a20bab7f
Content-Type: text/plain; charset="UTF-8"

I noticed that when I add a component to a bt2 graph, e.g.:

sink = g.add_component(SinglePETSink, "sink"+str(idx))

The return value "sink" is not actually an instance of SinglePETSink (which
has been defined as a local Python class).  How do I get to the instance of
SinglePETSink that was created?

Rocky

--000000000000bd4c9305a20bab7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I noticed that when I add a component to a bt2 graph, e.g.=
:<div><br></div><div>sink =3D g.add_component(SinglePETSink, &quot;sink&quo=
t;+str(idx))</div><div><br></div><div>The return value &quot;sink&quot; is =
not actually an instance of SinglePETSink (which has been defined as a loca=
l Python class).=C2=A0 How do I get to the instance of SinglePETSink that w=
as created?</div><div><br></div><div>Rocky</div></div>

--000000000000bd4c9305a20bab7f--

--===============4665777414816953045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4665777414816953045==--
