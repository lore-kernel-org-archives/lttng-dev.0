From: Brian Rossa <br@f0cal.com>
Subject: "Hands-free" tracepoints using LD_PRELOAD
Date: Fri, 18 Jan 2019 14:05:30 -0500
Message-ID: <CAF=ZobxSoNuto2U9NTihytCpdNODfH8Bv6JtGCym_g6hg3Uz4w__21489.4759156325$1547845323$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7444176688391217330=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by lists.lttng.org (Postfix) with ESMTPS id 43h9Q26Y4xzngH
 for <lttng-dev@lists.lttng.org>; Fri, 18 Jan 2019 14:05:46 -0500 (EST)
Received: by mail-lf1-x12d.google.com with SMTP id a8so11260115lfk.5
 for <lttng-dev@lists.lttng.org>; Fri, 18 Jan 2019 11:05:46 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com.
 [209.85.208.170])
 by smtp.gmail.com with ESMTPSA id o14-v6sm860809lji.70.2019.01.18.11.05.43
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 11:05:43 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id v15-v6so12471493ljh.13
 for <lttng-dev@lists.lttng.org>; Fri, 18 Jan 2019 11:05:43 -0800 (PST)
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

--===============7444176688391217330==
Content-Type: multipart/alternative; boundary="000000000000921406057fc0326d"

--000000000000921406057fc0326d
Content-Type: text/plain; charset="UTF-8"

Hello,

I have a custom tracing solution that I'm interested in porting to LTTng.
It works as follows:

   1. Input is a whitelist of mangled names taken from a target library,
   libfoo.so.
   2. For each name, generate a logging shim (example
   <https://www.linuxjournal.com/article/7795>) for the corresponding call.
   3. Compile all the logging shims into a shared library, libshim.so.
   4. Trace any application using libfoo by running it as
   LD_PRELOAD=libshim.so ./fooapp

There are two nice things about this approach that I would like to preserve:

   - The shim developer only needs to provide the whitelist and a bit of
   extra annotation. From there, the shim can be be authored using a
   boilerplate generator.
   - The app developer doesn't have to do anything other than pass the
   LD_PRELOAD flag.

The downside is that the only tracepoints are those corresponding to the
whitelist, but I'm fine with that.

Can this kind of "hands-free" developer experience be supported by LTTng?

Thanks!
~br

--000000000000921406057fc0326d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I have a custom traci=
ng solution that I&#39;m interested in porting to LTTng. It works as follow=
s:</div><ol><li>Input is a whitelist of mangled names taken from a target l=
ibrary, libfoo.so.</li><li>For each name, generate a logging shim (<a href=
=3D"https://www.linuxjournal.com/article/7795">example</a>) for the corresp=
onding call.</li><li>Compile all the logging shims into a shared library, l=
ibshim.so.</li><li>Trace any application using libfoo by running it as LD_P=
RELOAD=3Dlibshim.so ./fooapp</li></ol><div>There are two nice things about =
this approach that I would like to preserve:</div><div><ul><li>The shim dev=
eloper only needs to provide the whitelist and a bit of extra annotation. F=
rom there, the shim can be be authored using a boilerplate generator.</li><=
li>The app developer doesn&#39;t have to do anything other than pass the LD=
_PRELOAD flag.</li></ul><div>The downside is that the only tracepoints are =
those corresponding to the whitelist, but I&#39;m fine with that.</div><div=
><br></div><div>Can this kind of &quot;hands-free&quot; developer experienc=
e be supported by LTTng?</div><div><br></div><div>Thanks!</div><div>~br<br>=
</div></div></div>

--000000000000921406057fc0326d--

--===============7444176688391217330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7444176688391217330==--
