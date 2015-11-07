From: Rocky Dunlap <rsdunlapiv@gmail.com>
Subject: Python Babeltrace - Write multiple streams
Date: Fri, 6 Nov 2015 19:40:41 -0700
Message-ID: <CAK-w0Ddnf5TXJfmv=scZ0j6DJ0+PNbPOynKpahN8t1qVDqy=ug__39560.5608624921$1446959118$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1906651247=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <rsdunlapiv@gmail.com>) id 1ZutRC-0005jx-Gv
 for lttng-dev@lists.lttng.org; Fri, 06 Nov 2015 21:41:07 -0500
Received: by igpw7 with SMTP id w7so45271670igp.1
 for <lttng-dev@lists.lttng.org>; Fri, 06 Nov 2015 18:41:01 -0800 (PST)
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

--===============1906651247==
Content-Type: multipart/alternative; boundary=089e0122a3fa64efc70523ea4ac0

--089e0122a3fa64efc70523ea4ac0
Content-Type: text/plain; charset=UTF-8

Using the Babletrace Python binding version 1.3, I adapted a simple example
to try to write a trace with two streams.  It appears to write okay (no
errors), but when I attempt to read it back (again using Babeltrace) I get
an error:

[error] Stream 1 is not declared in metadata.
[error] Stream index creation error.
[error] Open file stream error.
[warning] [Context] Cannot open_trace of format ctf at path ./trace.

Here is my code to write the streams:

################################

from babeltrace import *

trace_path = "./trace"

print('trace path: {}'.format(trace_path))

writer = CTFWriter.Writer(trace_path)

clock = CTFWriter.Clock('my_clock')
clock.description = 'this is my clock'
writer.add_clock(clock)

stream_class = CTFWriter.StreamClass('my_stream')
stream_class.clock = clock

event_class = CTFWriter.EventClass('my_event')

int32_field_decl = CTFWriter.IntegerFieldDeclaration(32)
int32_field_decl.signed = True

event_class.add_field(int32_field_decl, 'my_field')

stream_class.add_event_class(event_class)

stream = writer.create_stream(stream_class)
stream2 = writer.create_stream(stream_class)

event = CTFWriter.Event(event_class)
event.payload('my_field').value = -23
stream.append_event(event)

event = CTFWriter.Event(event_class)
event.payload('my_field').value = -89
stream.append_event(event)

event = CTFWriter.Event(event_class)
event.payload('my_field').value = -849
stream2.append_event(event)

event = CTFWriter.Event(event_class)
event.payload('my_field').value = 42
stream2.append_event(event)

stream.flush()
stream2.flush()

######################

I am sure I am just not quite using the API correctly.  If you can spot the
error, please let me know.  Also, if anyone can point me to an example of
using the python bindings to write out multiple streams, I would appreciate
it.

Thanks!
Rocky

--089e0122a3fa64efc70523ea4ac0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Using the Babletrace Python binding version 1.3, I adapted=
 a simple example to try to write a trace with two streams.=C2=A0 It appear=
s to write okay (no errors), but when I attempt to read it back (again usin=
g Babeltrace) I get an error:<div><br></div><div><div>[error] Stream 1 is n=
ot declared in metadata.</div><div>[error] Stream index creation error.</di=
v><div>[error] Open file stream error.</div><div>[warning] [Context] Cannot=
 open_trace of format ctf at path ./trace.</div></div><div><br></div><div>H=
ere is my code to write the streams:</div><div><br></div><div>#############=
###################</div><div><br></div><div>from babeltrace import *</div>=
<div><br></div><div>trace_path =3D &quot;./trace&quot;</div><div><br></div>=
<div>print(&#39;trace path: {}&#39;.format(trace_path))</div><div><br></div=
><div>writer =3D CTFWriter.Writer(trace_path)</div><div><br></div><div>cloc=
k =3D CTFWriter.Clock(&#39;my_clock&#39;)</div><div>clock.description =3D &=
#39;this is my clock&#39;</div><div>writer.add_clock(clock)</div><div><br><=
/div><div>stream_class =3D CTFWriter.StreamClass(&#39;my_stream&#39;)</div>=
<div>stream_class.clock =3D clock</div><div><br></div><div>event_class =3D =
CTFWriter.EventClass(&#39;my_event&#39;)</div><div><br></div><div>int32_fie=
ld_decl =3D CTFWriter.IntegerFieldDeclaration(32)</div><div>int32_field_dec=
l.signed =3D True</div><div><br></div><div>event_class.add_field(int32_fiel=
d_decl, &#39;my_field&#39;)</div><div><br></div><div>stream_class.add_event=
_class(event_class)</div><div><br></div><div>stream =3D writer.create_strea=
m(stream_class)</div><div>stream2 =3D writer.create_stream(stream_class)</d=
iv><div><br></div><div>event =3D CTFWriter.Event(event_class)</div><div>eve=
nt.payload(&#39;my_field&#39;).value =3D -23</div><div>stream.append_event(=
event)</div><div><br></div><div>event =3D CTFWriter.Event(event_class)</div=
><div>event.payload(&#39;my_field&#39;).value =3D -89</div><div>stream.appe=
nd_event(event)</div><div><br></div><div>event =3D CTFWriter.Event(event_cl=
ass)</div><div>event.payload(&#39;my_field&#39;).value =3D -849</div><div>s=
tream2.append_event(event)</div><div><br></div><div>event =3D CTFWriter.Eve=
nt(event_class)</div><div>event.payload(&#39;my_field&#39;).value =3D 42</d=
iv><div>stream2.append_event(event)</div><div><br></div><div>stream.flush()=
</div><div>stream2.flush()=C2=A0</div><div><br></div><div>#################=
#####</div><div><br></div><div>I am sure I am just not quite using the API =
correctly.=C2=A0 If you can spot the error, please let me know.=C2=A0 Also,=
 if anyone can point me to an example of using the python bindings to write=
 out multiple streams, I would appreciate it.</div><div><br></div><div>Than=
ks!</div><div>Rocky</div></div>

--089e0122a3fa64efc70523ea4ac0--


--===============1906651247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1906651247==--
