From: Anders Johansson <epkboan@gmail.com>
Subject: tracepoint_enabled returns true for disabled provider,
 event
Date: Sat, 7 Sep 2019 14:42:22 +0200
Message-ID: <CACU0Kcsfzct94bxY06DoQ4x=H+fuKN5JGi6og94YYptOCmz5FQ__19645.2761463419$1568037033$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4749101129742182588=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by lists.lttng.org (Postfix) with ESMTPS id 46QYwq53YrzsWS
 for <lttng-dev@lists.lttng.org>; Sat,  7 Sep 2019 08:42:35 -0400 (EDT)
Received: by mail-io1-xd30.google.com with SMTP id n197so18958091iod.9
 for <lttng-dev@lists.lttng.org>; Sat, 07 Sep 2019 05:42:35 -0700 (PDT)
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

--===============4749101129742182588==
Content-Type: multipart/alternative; boundary="0000000000008cf6a10591f5e3f6"

--0000000000008cf6a10591f5e3f6
Content-Type: text/plain; charset="UTF-8"

Hi

I troubleshooting a huge application where i experience the problem that
even if tracepoint_enabled is used i get the huge overhead of formatting
the output even if then the message is not sent to the lttng buffers.

The tracepoint loglevel is set to TRACE_INFO using the TRACEPOINT_LOGLEVEL
macro. I managed to rebuild the application setting the level to
TRACE_DEBUG instead and then i could print continuously that the
tracepoint_enabled returned false. If i flip it back to TRACE_INFO
tracepoint_enabled always returns true, hence do lots of string building
but then no trace is actually sent off to lttng (which is correct since i
haven't enabled the tracepoint). Even if i explicitly do disable event on
the provider and tracepoint the TRACE_INFO tracepoints returns true in
tracepoint_enabled

Is this by design that tracepoint_enabled always returns true for
TRACE_INFO and lower values or is this configurable in any way?

I am using this inside a docker image running Wind River Linux
bash-4.3# lttng --version
lttng (LTTng Trace Control) 2.10.6 - KeKriek - v2.10.6-11-g8fcbf96
bash-4.3#

Any advice are welcome!
//Anders

--0000000000008cf6a10591f5e3f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I troubleshooting a huge application=
 where i experience the problem that even if tracepoint_enabled is used i g=
et the huge overhead of formatting the output even if then the message is n=
ot sent to the lttng buffers.=C2=A0</div><div><br></div><div>The tracepoint=
 loglevel is set to TRACE_INFO using the TRACEPOINT_LOGLEVEL macro. I manag=
ed to rebuild the application setting the level to TRACE_DEBUG instead and =
then i could print continuously=C2=A0that the tracepoint_enabled returned f=
alse. If i flip it back to TRACE_INFO tracepoint_enabled always returns tru=
e, hence do lots of string building but then no trace is actually sent off =
to lttng (which is correct since i haven&#39;t enabled the tracepoint). Eve=
n if i explicitly do disable event on the provider and tracepoint the TRACE=
_INFO tracepoints returns true in tracepoint_enabled</div><div><br></div><d=
iv>Is this by design that tracepoint_enabled always returns true for TRACE_=
INFO and lower values or is this configurable=C2=A0in any way?</div><div><b=
r></div><div>I am using this inside a docker image running Wind River Linux=
=C2=A0</div><div>bash-4.3# lttng --version<br>lttng (LTTng Trace Control) 2=
.10.6 - KeKriek - v2.10.6-11-g8fcbf96<br>bash-4.3#=C2=A0<br></div><div><br>=
</div><div>Any advice are welcome!</div><div>//Anders</div><div><br></div><=
div>=C2=A0</div></div>

--0000000000008cf6a10591f5e3f6--

--===============4749101129742182588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4749101129742182588==--
