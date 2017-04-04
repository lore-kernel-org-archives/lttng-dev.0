From: Rocky Dunlap <rsdunlapiv@gmail.com>
Subject: Using Babeltrace to write CTF for MPI application
Date: Tue, 4 Apr 2017 15:29:19 -0600
Message-ID: <CAK-w0DeOHsrygOt4CLVBB55edg6W+hrEzX2+A-UwFn6E14HDoQ__4204.01476226306$1491341404$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2425624148453075805=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com
 [IPv6:2607:f8b0:400c:c08::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 3vyMZM4X0Kz1Kn
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 21:30:03 +0000 (UTC)
Received: by mail-ua0-x22d.google.com with SMTP id 97so16865319uaz.3
 for <lttng-dev@lists.lttng.org>; Tue, 04 Apr 2017 14:29:40 -0700 (PDT)
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

--===============2425624148453075805==
Content-Type: multipart/alternative; boundary=f403045f286a2c983a054c5df9e4

--f403045f286a2c983a054c5df9e4
Content-Type: text/plain; charset=UTF-8

I am instrumenting an MPI application to output a custom application trace
in CTF using Babeltrace 1.5.2.  I would like to end up with a single trace
with multiple streams, one per process.  All streams share the same stream
class (and metadata). All processes have access to the same file system.  I
am using the C CTF writer API using this test as an example:
https://github.com/efficios/babeltrace/blob/stable-1.5/tests/lib/test_ctf_writer.c

What I have in mind is something like this: process 0 would be responsible
for writing the metadata and its own stream, while all other processes
would only need to write their own stream.

The issue I have run into is that the individual stream file names are
determined by appending stream->id to the stream filename and the stream id
is determined behind the scenes as stream->id =
stream_class->next_stream_id++.  Since each process has its own address
space, all processes want stream id of 0.

Is there a way using the current API to explicitly set the stream id so
that each process will write to a separate file?

I'm also open for suggestions on the overall approach.  The main reason to
have each process as a separate stream in a single trace is so that I can
open the entire trace in an analysis tool like TraceCompass and see all
processes together.

Rocky

--f403045f286a2c983a054c5df9e4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am instrumenting an MPI application to output a custom a=
pplication trace in CTF using Babeltrace 1.5.2.=C2=A0 I would like to end u=
p with a single trace with multiple streams, one per process.=C2=A0 All str=
eams share the same stream class (and metadata). All processes have access =
to the same file system.=C2=A0 I am using the C CTF writer API using this t=
est as an example:<div><a href=3D"https://github.com/efficios/babeltrace/bl=
ob/stable-1.5/tests/lib/test_ctf_writer.c">https://github.com/efficios/babe=
ltrace/blob/stable-1.5/tests/lib/test_ctf_writer.c</a></div><div><br><div>W=
hat I have in mind is something like this: process 0 would be responsible f=
or writing the metadata and its own stream, while all other processes would=
 only need to write their own stream.</div><div><br></div>The issue I have =
run into is that the individual stream file names are determined by appendi=
ng stream-&gt;id to the stream filename and the stream id is determined beh=
ind the scenes as=C2=A0stream-&gt;id =3D stream_class-&gt;next_stream_id++.=
=C2=A0 Since each process has its own address space, all processes want str=
eam id of 0.</div><div><br></div><div>Is there a way using the current API =
to explicitly set the stream id so that each process will write to a separa=
te file?</div><div><br></div><div>I&#39;m also open for suggestions on the =
overall approach.=C2=A0 The main reason to have each process as a separate =
stream in a single trace is so that I can open the entire trace in an analy=
sis tool like TraceCompass and see all processes together.</div><div><br></=
div><div>Rocky</div></div>

--f403045f286a2c983a054c5df9e4--

--===============2425624148453075805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2425624148453075805==--
