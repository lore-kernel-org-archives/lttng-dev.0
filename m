From: Adam Crume <adamcrume@gmail.com>
Subject: Duplicate registration of tracepoint probes
Date: Wed, 23 Jul 2014 17:06:11 -0700
Message-ID: <CAFu9Dv2S1UOWopG1KfCqW+LnCMm7DCYdBGok1uQMQ92xbjsi2g__46822.2653646537$1406201260$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0909929887=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <adamcrume@gmail.com>) id 1XA7Tz-0001EF-PW
 for lttng-dev@lists.lttng.org; Wed, 23 Jul 2014 21:06:10 -0400
Received: by mail-oa0-f46.google.com with SMTP id m1so2736958oag.5
 for <lttng-dev@lists.lttng.org>; Wed, 23 Jul 2014 18:06:01 -0700 (PDT)
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

--===============0909929887==
Content-Type: multipart/alternative; boundary=089e01160bf86c661c04fee539bb

--089e01160bf86c661c04fee539bb
Content-Type: text/plain; charset=ISO-8859-1

I have an application which compiles and links fine, but at runtime it
fails with:

LTTng-UST: Error (-17) while registering tracepoint probe. Duplicate
registration of tracepoint probes having the same name is not allowed.
Aborted (core dumped)

What's the best way to debug this?  I've seen this before when a library
gets linked in multiple times, but that doesn't seem to be the case this
time (as far as I can tell).  I ran nm on the app, and all of the probes
(__event_probe__*) are unique.  I do see duplicates for
__tracepoint__init_urcu_sym, type 't'.  I also see duplicates for
__tracepoint_ptrs_registered, __tracepoint_registered, and
tracepoint_dlopen, all of type 'V'.

I have multiple *.tp files, which each get compiled and linked into their
own library, and I'm using -DTRACEPOINT_PROBE_DYNAMIC_LINKAGE.

Can anyone tell me what's wrong, or how to fix it?

Thanks,
Adam

--089e01160bf86c661c04fee539bb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>I have an application which compiles and li=
nks fine, but at runtime it fails with:<br><br>LTTng-UST: Error (-17) while=
 registering tracepoint probe. Duplicate registration of tracepoint probes =
having the same name is not allowed.<br>
Aborted (core dumped)<br><br></div>What&#39;s the best way to debug this?=
=A0 I&#39;ve seen this before when a library gets linked in multiple times,=
 but that doesn&#39;t seem to be the case this time (as far as I can tell).=
=A0 I ran nm on the app, and all of the probes (__event_probe__*) are uniqu=
e.=A0 I do see duplicates for __tracepoint__init_urcu_sym, type &#39;t&#39;=
.=A0 I also see duplicates for __tracepoint_ptrs_registered, __tracepoint_r=
egistered, and tracepoint_dlopen, all of type &#39;V&#39;.<br>
<br></div>I have multiple *.tp files, which each get compiled and linked in=
to their own library, and I&#39;m using -DTRACEPOINT_PROBE_DYNAMIC_LINKAGE.=
<br><br></div><div>Can anyone tell me what&#39;s wrong, or how to fix it?<b=
r>
</div><div><br></div>Thanks,<br>Adam<br></div>

--089e01160bf86c661c04fee539bb--


--===============0909929887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0909929887==--
