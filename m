From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: babletrace2 graph performance considerations
Date: Sun, 29 Mar 2020 22:10:32 -0600
Message-ID: <CADtyBo6B4YQ++VPhM4-cAfKYq0otJMg4zMXvQYqyNw3JsSX6Nw@mail.gmail.com>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1284673714400634973=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by lists.lttng.org (Postfix) with ESMTPS id 48rJsj4c8mz1Y2h
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 00:10:49 -0400 (EDT)
Received: by mail-oi1-x232.google.com with SMTP id y71so14575923oia.7
 for <lttng-dev@lists.lttng.org>; Sun, 29 Mar 2020 21:10:49 -0700 (PDT)
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

--===============1284673714400634973==
Content-Type: multipart/alternative; boundary="000000000000cd90aa05a20aa241"

--000000000000cd90aa05a20aa241
Content-Type: text/plain; charset="UTF-8"

A couple of questions on performance considerations when setting up bt2
processing graphs.

1.  Do parts of the processing graph that can execute concurrently do so?
Does the user have any control over this, e.g., by creating threads in sink
components?

2.  It looks like you cannot connect one output port to multiple inputs.
Is there a way to create a tee component?

Rocky

--000000000000cd90aa05a20aa241
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">A couple of questions on performance considerations when s=
etting up bt2 processing graphs.<div><br></div><div>1.=C2=A0 Do parts of th=
e processing graph that can execute concurrently do so?=C2=A0 Does the user=
 have any control over this, e.g., by creating threads in sink components?<=
/div><div><br></div><div>2.=C2=A0 It looks like you cannot connect one outp=
ut port to multiple inputs.=C2=A0 Is there a way to create a tee component?=
</div><div><br></div><div>Rocky</div></div>

--000000000000cd90aa05a20aa241--

--===============1284673714400634973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1284673714400634973==--
