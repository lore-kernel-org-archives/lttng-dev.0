From: Sudhagar Chinnaswamy <sudhagar@gmail.com>
Subject: Use LTTng in legacy codebase/variable arguments
Date: Mon, 22 Dec 2014 13:46:21 -0800
Message-ID: <CA+XthnSaxt2EJuJzm7J7EUAbUnbdh07LnbodQfFbf4bDm4JEKw__2689.87486274472$1419284870$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1732515674=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sudhagar@gmail.com>) id 1Y3Aol-0007W4-1y
 for lttng-dev@lists.lttng.org; Mon, 22 Dec 2014 16:47:07 -0500
Received: by mail-yh0-f41.google.com with SMTP id a41so2699030yho.0
 for <lttng-dev@lists.lttng.org>; Mon, 22 Dec 2014 13:47:01 -0800 (PST)
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

--===============1732515674==
Content-Type: multipart/alternative; boundary=089e011834f69f35dc050ad4ff86

--089e011834f69f35dc050ad4ff86
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi:

I have the same need as discussed in the below mentioned thread. I want to
use LTTng, but most of the cases we need to log different parameters under
the same provider and event.

http://lists.lttng.org/pipermail/lttng-dev/2013-December/022134.html

When I tried a simple program to log the variable arguments under same
provider/event as suggested in the above thread using the macro below, I
found that the function "my_snprintf" is called "twice" when the logging
for the event is enabled for each tracepoint call. It seems inefficient to
call the same function twice. Is there something that could be done to make
it efficient or am I missing something?

=E2=80=94 8< =E2=80=94

#define tracepoint_for_format_string(provider, name, =E2=80=A6) \

      do { \

            char msg_buf[MAX_BUFFER_SIZE]; \

            tracepoint(provider, name, my_snprintf(msg_buf,
MAX_BUFFER_SIZE, __VA_ARGS__)); \

      } while (0)

=E2=80=94 8< =E2=80=94

Alternatively, is there any other approach to achieve my requirement: Need
to use same provider & event name to log variable arguments?

For e.g.,
my_tracepoint(hello_world, test, "argc=3D%d, argv=3D%p", argc, argv);
my_tracepoint(hello_world, test, "argv[%u] :: %s", x, argv[x]);
my_tracepoint(hello_world, test, "Quitting now!");

Thanks in advance.

Regards,
Sudhagar

--089e011834f69f35dc050ad4ff86
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi:</div><div><br></div><div>I have the same need as =
discussed in the below mentioned thread. I want to use LTTng, but most of t=
he cases we need to log different parameters under the same provider and ev=
ent.=C2=A0</div><div><br></div><a href=3D"http://lists.lttng.org/pipermail/=
lttng-dev/2013-December/022134.html">http://lists.lttng.org/pipermail/lttng=
-dev/2013-December/022134.html</a><div><br></div><div>When I tried a simple=
 program to log the variable arguments under same provider/event as suggest=
ed in the above thread using the macro below, I found that the function &qu=
ot;my_snprintf&quot; is called &quot;twice&quot; when the logging for the e=
vent is enabled for each tracepoint call. It seems inefficient to call the =
same function twice. Is there something that could be done to make it effic=
ient or am I missing something?</div><div><div style=3D"color:rgb(0,0,0);fo=
nt-family:Helvetica;font-size:medium"><p class=3D"MsoNormal" style=3D"margi=
n:0in 0in 0.0001pt;font-size:12pt;font-family:&#39;Times New Roman&#39;,ser=
if"><span style=3D"font-size:10.5pt;font-family:Helvetica,sans-serif">=E2=
=80=94 8&lt; =E2=80=94</span></p></div><div style=3D"color:rgb(0,0,0);font-=
family:Helvetica;font-size:medium"><pre style=3D"margin:0in 0in 0.0001pt;fo=
nt-size:10pt;font-family:&#39;Courier New&#39;;white-space:pre-wrap">#defin=
e tracepoint_for_format_string(provider, name, =E2=80=A6) \</pre><pre style=
=3D"margin:0in 0in 0.0001pt;font-size:10pt;font-family:&#39;Courier New&#39=
;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do { \</pre><pre style=3D"margin:0in 0in =
0.0001pt;font-size:10pt;font-family:&#39;Courier New&#39;">=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char msg_buf[MAX_BUFFER=
_SIZE]; \</pre><pre style=3D"margin:0in 0in 0.0001pt;font-size:10pt;font-fa=
mily:&#39;Courier New&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tracepoint(provider, name, my_snprintf(msg_buf, MAX_B=
UFFER_SIZE, __VA_ARGS__)); \</pre><pre style=3D"margin:0in 0in 0.0001pt;fon=
t-size:10pt;font-family:&#39;Courier New&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } while (0)</pre><div><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.=
0001pt;font-size:12pt;font-family:&#39;Times New Roman&#39;,serif"><span st=
yle=3D"font-size:10.5pt;font-family:Helvetica,sans-serif">=E2=80=94 8&lt; =
=E2=80=94</span></p></div></div><div style=3D"color:rgb(0,0,0);font-family:=
Helvetica;font-size:medium"></div></div><div><br></div><div>Alternatively, =
is there any other approach to achieve my requirement: Need to use same pro=
vider &amp; event name to log variable arguments?</div><div><br></div><div>=
For e.g.,</div><div><div>my_tracepoint(hello_world, test, &quot;argc=3D%d, =
argv=3D%p&quot;, argc, argv);</div><div>my_tracepoint(hello_world, test, &q=
uot;argv[%u] :: %s&quot;, x, argv[x]);</div><div>my_tracepoint(hello_world,=
 test, &quot;Quitting now!&quot;);</div></div><div><br></div><div>Thanks in=
 advance.</div><div><br clear=3D"all"><div><div class=3D"gmail_signature">R=
egards,<br>Sudhagar<br><br></div></div>
</div></div>

--089e011834f69f35dc050ad4ff86--


--===============1732515674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1732515674==--
