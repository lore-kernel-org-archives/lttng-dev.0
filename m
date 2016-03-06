From: John Smith <whalajam@gmail.com>
Subject: tracepoint failure
Date: Sun, 6 Mar 2016 12:55:24 -0800
Message-ID: <CANgVouUve2U_3vPBQvdazmqmvNKX37R9Sm7DWGL+Js1qr3ThhQ__46104.9840240323$1457382395$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0240110198=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <whalajam@gmail.com>) id 1acfi6-0001pA-Kp
 for lttng-dev@lists.lttng.org; Sun, 06 Mar 2016 15:55:33 -0500
Received: by mail-ig0-f176.google.com with SMTP id z8so27243533ige.0
 for <lttng-dev@lists.lttng.org>; Sun, 06 Mar 2016 12:55:30 -0800 (PST)
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

--===============0240110198==
Content-Type: multipart/alternative; boundary=001a11c3c9083ab497052d6791c8

--001a11c3c9083ab497052d6791c8
Content-Type: text/plain; charset=UTF-8

Hi,
it there any way to retrieve the errors from tracepoint() failing to trace?
The -vvv are only for the specific lttng commands, nothing seems to be
available for the actual tracepoint() tracing.

I'm not referring to discard or overwrite modes, discarded traces being
reported when the trace is viewed.
On docker I see tracepoint() failing all the traces or, on different runs,
failing traces from a specific provider.
No errors were reported on any of the lttng commands including enable-event
and enable-channel,

thanks, John

--001a11c3c9083ab497052d6791c8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<div>it there any way to retrieve the errors from=
 tracepoint() failing to trace?</div><div>The -vvv are only for the specifi=
c lttng commands, nothing seems to be available for the actual tracepoint()=
 tracing.</div><div><br></div><div>I&#39;m not referring to discard or over=
write modes, discarded traces being reported when the trace is viewed.</div=
><div>On docker I see tracepoint() failing all the traces or, on different =
runs, failing traces from a specific provider.</div><div>No errors were rep=
orted on any of the lttng commands including enable-event and enable-channe=
l,</div><div><br></div><div>thanks, John</div></div>

--001a11c3c9083ab497052d6791c8--


--===============0240110198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0240110198==--
