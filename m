From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Large number of stream files in CTF trace -- too many
 file handles
Date: Fri, 13 Mar 2020 17:55:32 -0400
Message-ID: <CADtyBo77-N3SscU7K_HCTwVq7+5f_d9yb19buve66p+SrHxVHQ@mail.gmail.com>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7312330098189914048=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by lists.lttng.org (Postfix) with ESMTPS id 48fKJT6LgPz1JJc
 for <lttng-dev@lists.lttng.org>; Fri, 13 Mar 2020 17:55:53 -0400 (EDT)
Received: by mail-ot1-x32b.google.com with SMTP id j16so11738883otl.1
 for <lttng-dev@lists.lttng.org>; Fri, 13 Mar 2020 14:55:53 -0700 (PDT)
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

--===============7312330098189914048==
Content-Type: multipart/alternative; boundary="0000000000007b75d305a0c388f4"

--0000000000007b75d305a0c388f4
Content-Type: text/plain; charset="UTF-8"

I am attempting to use babeltrace2 to read a CTF trace that has ~2000
stream files.  This is a custom trace collected from an MPI application on
an HPC platform.  In this case, each MPI process opens and writes to its
own stream file, so you end up with one file per MPI task.

When I attempt to read the trace from the command line with babeltrace2, I
see the following error:

ERROR:    [Babeltrace CLI] (babeltrace2.c:2548)
  Graph failed to complete successfully
CAUSED BY [libbabeltrace2] (graph.c:473)
  Component's "consume" method failed: status=ERROR, comp-addr=0x1beab20,
comp-name="pretty", comp-log-level=WARNING, comp-class-type=SINK,
  comp-class-name="pretty", comp-class-partial-descr="Pretty-print messages
(`text` fo", comp-class-is-frozen=0,
  comp-class-so-handle-addr=0x174fc10,
comp-class-so-handle-path="/usr/lib/x86_64-linux-gnu/babeltrace2/plugins/babeltrace-plugin-text.so",
  comp-input-port-count=1, comp-output-port-count=0
CAUSED BY [libbabeltrace2] (iterator.c:864)
  Component input port message iterator's "next" method failed:
iter-addr=0x1c7cec0, iter-upstream-comp-name="muxer",
  iter-upstream-comp-log-level=WARNING,
iter-upstream-comp-class-type=FILTER, iter-upstream-comp-class-name="muxer",
  iter-upstream-comp-class-partial-descr="Sort messages from multiple
inpu", iter-upstream-port-type=OUTPUT, iter-upstream-port-name="out",
  status=ERROR
CAUSED BY [muxer: 'filter.utils.muxer'] (muxer.c:991)
  Cannot validate muxer's upstream message iterator wrapper:
muxer-msg-iter-addr=0x1c7d030, muxer-upstream-msg-iter-wrap-addr=0x1e23430
CAUSED BY [muxer: 'filter.utils.muxer'] (muxer.c:454)
  Upstream iterator's next method returned an error: status=ERROR
CAUSED BY [libbabeltrace2] (iterator.c:864)
  Component input port message iterator's "next" method failed:
iter-addr=0x1e22f00, iter-upstream-comp-name="auto-disc-source-ctf-fs",
  iter-upstream-comp-log-level=WARNING,
iter-upstream-comp-class-type=SOURCE, iter-upstream-comp-class-name="fs",
  iter-upstream-comp-class-partial-descr="Read CTF traces from the file
sy", iter-upstream-port-type=OUTPUT,
  iter-upstream-port-name="21c4e078-a5c7-11e8-8529-34f39aeaad30 | 0 |
/home/rocky/tmp/fv3/wave/traceout/esmf_stream_1020", status=ERROR
CAUSED BY [auto-disc-source-ctf-fs (21c4e078-a5c7-11e8-8529-34f39aeaad30 |
0 | /home/rocky/tmp/fv3/wave/traceout/esmf_stream_1020): 'source.ctf.fs']
(fs.c:109)
  Failed to get next message from CTF message iterator.
CAUSED BY [auto-disc-source-ctf-fs: 'source.ctf.fs'] (msg-iter.c:2899)
  Cannot handle state: msg-it-addr=0x1e230f0, state=SWITCH_PACKET
CAUSED BY [auto-disc-source-ctf-fs (21c4e078-a5c7-11e8-8529-34f39aeaad30 |
0 | /home/rocky/tmp/fv3/wave/traceout/esmf_stream_1020): 'source.ctf.fs']
(data-stream-file.c:385)
  failed to create ctf_fs_ds_file.
CAUSED BY [auto-disc-source-ctf-fs: 'source.ctf.fs'] (file.c:98)
 * Cannot open file: Too many open files:
*path=/home/rocky/tmp/fv3/wave/traceout/esmf_stream_1020,
mode=rb

No doubt the issue is the large number of file handles.

I see a similar error when I try to use bt2.TraceCollectionMessageIterator.

This is probably somewhat non-standard to have so many file streams.  But,
it works quite well to write them out this way on an HPC system--i.e., to
combine the streams during the application run would require MPI
communication, which would degrade performance and make the tracing more
complicated.

But, now that I have the streams and seeing the too many file handles
system error, I am thinking maybe I should post-process the streams down
from 2000 to a much smaller number, maybe 20, where 100 of the original
streams are merged.  The good news is that each of the streams are not that
big, so the overall trace size should be manageable.

If this is the right approach, then what would be the best way to
post-process these streams down to a smaller number of files?

If this is not the right approach, how should I proceed?  E.g., should the
source-ctf-fs manage a limited pool of file handles?  I would think this
would be pretty inefficient as you would need to constantly open/close
files--expensive.

Any help is appreciated!

Rocky

--0000000000007b75d305a0c388f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am attempting to use babeltrace2 to read a CTF trace tha=
t has ~2000 stream files.=C2=A0 This is a custom trace collected from an MP=
I application on an HPC platform.=C2=A0 In this case, each MPI process open=
s and writes to its own stream file, so you end up with one file per MPI ta=
sk.<div><br></div><div>When I attempt to read the trace from the command li=
ne with babeltrace2, I see the following error:</div><div><br></div><div>ER=
ROR: =C2=A0 =C2=A0[Babeltrace CLI] (babeltrace2.c:2548)<br>=C2=A0 Graph fai=
led to complete successfully<br>CAUSED BY [libbabeltrace2] (graph.c:473)<br=
>=C2=A0 Component&#39;s &quot;consume&quot; method failed: status=3DERROR, =
comp-addr=3D0x1beab20, comp-name=3D&quot;pretty&quot;, comp-log-level=3DWAR=
NING, comp-class-type=3DSINK,<br>=C2=A0 comp-class-name=3D&quot;pretty&quot=
;, comp-class-partial-descr=3D&quot;Pretty-print messages (`text` fo&quot;,=
 comp-class-is-frozen=3D0,<br>=C2=A0 comp-class-so-handle-addr=3D0x174fc10,=
 comp-class-so-handle-path=3D&quot;/usr/lib/x86_64-linux-gnu/babeltrace2/pl=
ugins/babeltrace-plugin-text.so&quot;,<br>=C2=A0 comp-input-port-count=3D1,=
 comp-output-port-count=3D0<br>CAUSED BY [libbabeltrace2] (iterator.c:864)<=
br>=C2=A0 Component input port message iterator&#39;s &quot;next&quot; meth=
od failed: iter-addr=3D0x1c7cec0, iter-upstream-comp-name=3D&quot;muxer&quo=
t;,<br>=C2=A0 iter-upstream-comp-log-level=3DWARNING, iter-upstream-comp-cl=
ass-type=3DFILTER, iter-upstream-comp-class-name=3D&quot;muxer&quot;,<br>=
=C2=A0 iter-upstream-comp-class-partial-descr=3D&quot;Sort messages from mu=
ltiple inpu&quot;, iter-upstream-port-type=3DOUTPUT, iter-upstream-port-nam=
e=3D&quot;out&quot;,<br>=C2=A0 status=3DERROR<br>CAUSED BY [muxer: &#39;fil=
ter.utils.muxer&#39;] (muxer.c:991)<br>=C2=A0 Cannot validate muxer&#39;s u=
pstream message iterator wrapper: muxer-msg-iter-addr=3D0x1c7d030, muxer-up=
stream-msg-iter-wrap-addr=3D0x1e23430<br>CAUSED BY [muxer: &#39;filter.util=
s.muxer&#39;] (muxer.c:454)<br>=C2=A0 Upstream iterator&#39;s next method r=
eturned an error: status=3DERROR<br>CAUSED BY [libbabeltrace2] (iterator.c:=
864)<br>=C2=A0 Component input port message iterator&#39;s &quot;next&quot;=
 method failed: iter-addr=3D0x1e22f00, iter-upstream-comp-name=3D&quot;auto=
-disc-source-ctf-fs&quot;,<br>=C2=A0 iter-upstream-comp-log-level=3DWARNING=
, iter-upstream-comp-class-type=3DSOURCE, iter-upstream-comp-class-name=3D&=
quot;fs&quot;,<br>=C2=A0 iter-upstream-comp-class-partial-descr=3D&quot;Rea=
d CTF traces from the file sy&quot;, iter-upstream-port-type=3DOUTPUT,<br>=
=C2=A0 iter-upstream-port-name=3D&quot;21c4e078-a5c7-11e8-8529-34f39aeaad30=
 | 0 | /home/rocky/tmp/fv3/wave/traceout/esmf_stream_1020&quot;, status=3DE=
RROR<br>CAUSED BY [auto-disc-source-ctf-fs (21c4e078-a5c7-11e8-8529-34f39ae=
aad30 | 0 | /home/rocky/tmp/fv3/wave/traceout/esmf_stream_1020): &#39;sourc=
e.ctf.fs&#39;] (fs.c:109)<br>=C2=A0 Failed to get next message from CTF mes=
sage iterator.<br>CAUSED BY [auto-disc-source-ctf-fs: &#39;source.ctf.fs&#3=
9;] (msg-iter.c:2899)<br>=C2=A0 Cannot handle state: msg-it-addr=3D0x1e230f=
0, state=3DSWITCH_PACKET<br>CAUSED BY [auto-disc-source-ctf-fs (21c4e078-a5=
c7-11e8-8529-34f39aeaad30 | 0 | /home/rocky/tmp/fv3/wave/traceout/esmf_stre=
am_1020): &#39;source.ctf.fs&#39;] (data-stream-file.c:385)<br>=C2=A0 faile=
d to create ctf_fs_ds_file.<br>CAUSED BY [auto-disc-source-ctf-fs: &#39;sou=
rce.ctf.fs&#39;] (file.c:98)<br>=C2=A0<b> Cannot open file: Too many open f=
iles: </b>path=3D/home/rocky/tmp/fv3/wave/traceout/esmf_stream_1020, mode=
=3Drb<br></div><div><br></div><div>No doubt the issue is the large number o=
f file handles.</div><div><br></div><div>I see a similar error when I try t=
o use bt2.TraceCollectionMessageIterator.</div><div><br></div><div>This is =
probably somewhat non-standard to have so many file streams.=C2=A0 But, it =
works quite well to write them out this way on an HPC system--i.e., to comb=
ine the streams during the application run would require MPI communication,=
 which would degrade performance and make the tracing more complicated.</di=
v><div><br></div><div>But, now that I have the streams and seeing the too m=
any file handles system error, I am thinking maybe I should post-process th=
e streams down from 2000 to a much smaller number, maybe 20, where 100 of t=
he original streams are merged.=C2=A0 The good news is that each of the str=
eams are not that big, so the overall trace size should be manageable.</div=
><div><br></div><div>If this is the right approach, then what would be the =
best way to post-process these streams down to a smaller number of files?</=
div><div><br></div><div>If this is not the right approach, how should I pro=
ceed?=C2=A0 E.g., should the source-ctf-fs manage a limited pool of file ha=
ndles?=C2=A0 I would think this would be pretty inefficient as you would ne=
ed to constantly open/close files--expensive.</div><div><br></div><div>Any =
help is appreciated!</div><div><br></div><div>Rocky</div></div>

--0000000000007b75d305a0c388f4--

--===============7312330098189914048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7312330098189914048==--
