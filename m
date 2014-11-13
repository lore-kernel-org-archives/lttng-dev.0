From: Anders Wallin <wallinux@gmail.com>
Subject: Re: snapshot issue with 2.5
Date: Thu, 13 Nov 2014 08:33:07 +0100
Message-ID: <CAF2baFdgjkw--AdVXMCJVtLpsyHODsYC1WhACgpqEXhYmJEo8w__30327.878209255$1415864046$gmane$org@mail.gmail.com>
References: <CAF2baFd5vRuGKa7MVpqHvkCHia5fDN19cvq8qdedqJreNU6-vQ@mail.gmail.com>
 <CA+jJMxvXfVT8w+hokMyFgTSqN=JH3nQUudJR+8MUJtQmTEgZZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0189951713=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wallinux@gmail.com>) id 1Xoou1-0003P7-5V
 for lttng-dev@lists.lttng.org; Thu, 13 Nov 2014 02:33:18 -0500
Received: by mail-qc0-f173.google.com with SMTP id x3so10448913qcv.4
 for <lttng-dev@lists.lttng.org>; Wed, 12 Nov 2014 23:33:07 -0800 (PST)
In-Reply-To: <CA+jJMxvXfVT8w+hokMyFgTSqN=JH3nQUudJR+8MUJtQmTEgZZQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0189951713==
Content-Type: multipart/alternative; boundary=001a11c2f87203e9500507b8861d

--001a11c2f87203e9500507b8861d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 11:30 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Wed, Nov 12, 2014 at 7:39 AM, Anders Wallin <wallinux@gmail.com> wrote=
:
> > Hi,
> >
> > using userspace snapshot mode in 2.5 seems to broken.
> >
> > I have small stupid application(tracetest) generating 1000 events
> >
> > Running the script (the below is simplified version of the script)
> >
> -------------------------------------------------------------------------=
---------
> > #!/bin/bash
> > LTTNG=3D'lttng -n'
> > lttng-sessiond --no-kernel &
>
> You should use the "-d" flag to launch the sessiond as a daemon. Using
> "&" might cause the "create" command to launch a second session daemon
> since the first one would not have had the time to open create its
> command sockets.
>
No reason, but I changed it now "-d". On my laptop I already have a
sessiond running for kernelspace
and I wanted my test case to be as simple as possible to prove the faulty
behavior.
I have an ARM and a powerpc target as well and on them I'm running the same
test w/o a sessiond for the kernel
and not tracing kernel at all.


>
> >
> > $LTTNG create test --snapshot
> > $LTTNG enable-channel -u --subbuf-size 64k --num-subbuf 16 --overwrite
> ch1
> > $LTTNG enable-event -u -c ch1 "*"
> > $LTTNG start
> > $LTTNG list ch1
> >
> > mkdir -p snapshot/
> >
> > for i in $(seq 1 $LOOPS); do
> >     ./tracetest
> >     $LTTNG snapshot record -m 1G
> >
> >     # print no of events and first and last event
> >     last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | tail -1)
> >     babeltrace $last > snapshot/$i.bt
> >     cat snapshot/$i.bt | wc -l
> >     cat snapshot/$i.bt | head -1
> >     cat snapshot/$i.bt | tail -1
> > done
> >
> > $LTTNG stop
> > $LTTNG destroy $SESSION
> >
> -------------------------------------------------------------------------=
---------
> >
> > The result of the run looks like this;
> > ./test.run
> > Error: consumer err socket second poll error
> > Error: Health error occurred in thread_manage_consumer
> > PERROR - 13:36:59.685167 [23772/23781]: bind inet: Address already in u=
se
> > (in lttcomm_bind_inet_sock() at inet.c:109)
> > Warning: Another session daemon is using this JUL port. JUL support wil=
l
> be
> > deactivated to prevent interfering with the tracing.
> >
>
> Is there a reason why you run two session daemons? I'm guessing this
> is related to my "& vs -d" comment above.


> > lttng (LTTng Trace Control) 2.5.2 - Fumisterie
> > BabelTrace Trace Viewer and Converter 1.2.4
> >         linux-vdso.so.1 =3D>  (0x00007fffba966000)
> >         liblttng-ctl.so.0 =3D> /usr/lib/x86_64-linux-gnu/liblttng-ctl.s=
o.0
> > (0x00007fbfe4b1d000)
> >         librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
> (0x00007fbfe4915000)
> >         libxml2.so.2 =3D> /usr/lib/x86_64-linux-gnu/libxml2.so.2
> > (0x00007fbfe45ae000)
> >         libpopt.so.0 =3D> /lib/x86_64-linux-gnu/libpopt.so.0
> > (0x00007fbfe43a2000)
> >         libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
> > (0x00007fbfe4184000)
> >         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007fbfe3dbd=
000)
> >         /lib64/ld-linux-x86-64.so.2 (0x00007fbfe4fac000)
> >         liburcu.so.2 =3D> /usr/lib/x86_64-linux-gnu/liburcu.so.2
> > (0x00007fbfe3bb6000)
> >         libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2
> (0x00007fbfe39b2000)
> >         libz.so.1 =3D> /lib/x86_64-linux-gnu/libz.so.1 (0x00007fbfe3798=
000)
> >         liblzma.so.5 =3D> /lib/x86_64-linux-gnu/liblzma.so.5
> > (0x00007fbfe3576000)
> >         libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x00007fbfe3270=
000)
> >
> > Session test created.
> > Default snapshot output set to:
> > /home/awallin/lttng-traces/test-20141112-133700
> > Snapshot mode set. Every channel enabled for that session will be set i=
n
> > overwrite mode and mmap output.
> > UST channel ch1 enabled for session test
> > UST event * created in channel ch1
> > Tracing started for session test
> > Tracing session test: [active snapshot]
> >     Trace path:
> >     Live timer interval (usec): 4294967295
> >
> > =3D=3D=3D Domain: UST global =3D=3D=3D
> >
> > Channels:
> > -------------
> > - ch1: [enabled]
> >
> >     Attributes:
> >       overwrite mode: 1
> >       subbufers size: 4096
> >       number of subbufers: 16
> >       switch timer interval: 0
> >       read timer interval: 0
> >       trace file count: 0
> >       trace file size (bytes): 0
> >       output: mmap()
> >
> >     Events:
> >       * (type: tracepoint) [enabled]
> >
> > Snapshot recorded successfully for session test
> > 84
> > [13:37:00.852615950] (+?.?????????) arn-awallin-mint-l3
> > ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFFC6BC700=
0,
> sopath
> > =3D "[vdso]", size =3D 0, mtime =3D -1 }
> > [13:37:00.853798949] (+0.000000805) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 157
> > [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 92=
7 }
> > [13:37:00.894839116] (+0.000000299) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 168
> > [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 92=
7 }
> > [13:37:00.929447330] (+0.000000305) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 168
> > [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
> > ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF8100=
0,
> sopath
> > =3D "[vdso]", size =3D 0, mtime =3D -1 }
> > [13:37:00.972035546] (+0.000000597) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 168
> > [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
> > ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF8100=
0,
> sopath
> > =3D "[vdso]", size =3D 0, mtime =3D -1 }
> > [13:37:01.014060940] (+0.000000341) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 168
> > [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3
> > ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF8100=
0,
> sopath
> > =3D "[vdso]", size =3D 0, mtime =3D -1 }
> > [13:37:01.052555877] (+0.000000872) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 168
> > [13:37:01.014035993] (+?.?????????) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D 92=
7 }
> > [13:37:01.098620808] (+0.000001404) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 4 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 168
> > [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
> > ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE00=
0,
> sopath
> > =3D "[vdso]", size =3D 0, mtime =3D -1 }
> > [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 168
> > [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
> > ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE00=
0,
> sopath
> > =3D "[vdso]", size =3D 0, mtime =3D -1 }
> > [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 7 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 168
> > [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3
> > ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE00=
0,
> sopath
> > =3D "[vdso]", size =3D 0, mtime =3D -1 }
> > [13:37:01.172829105] (+0.000000575) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 5 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Snapshot recorded successfully for session test
> > 168
> > [13:37:01.172021557] (+?.?????????) arn-awallin-mint-l3
> > ust_baddr_statedump:soinfo: { cpu_id =3D 7 }, { baddr =3D 0x7FFF653FE00=
0,
> sopath
> > =3D "[vdso]", size =3D 0, mtime =3D -1 }
> > [13:37:01.220074165] (+0.000000553) arn-awallin-mint-l3
> tracetest:first_tp:
> > { cpu_id =3D 6 }, { my_string_field =3D "test", my_integer_field =3D 99=
9 }
> > Waiting for data availability
> > Tracing stopped for session test
> > Session test destroyed
> >
> > the result from the run on older versions of lttng creates bigger and
> bigger
> > event traces until reaching max size.
> >
>
> Unless I'm mistaken, the behavior of the snapshot mode has changed
> between 2.4 and 2.5.
>
> In the 2.4 series, consecutive snapshots could overlap; that is,
> events could be present in multiple snapshots. As of 2.5, an event is
> guaranteed to only appear in one snapshot as the events are considered
> as having been "consumed" at that point.
>
> Julien (cc'ed) might be able to confirm this.
>
> Regards,
> J=C3=A9r=C3=A9mie
>
> > I have tested this on different architectures, with different buffer
> sizes
> > and number of buffer
> >
> > Regards
> > Anders Wallin
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c2f87203e9500507b8861d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Nov 12, 2014 at 11:30 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">je=
remie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><span class=3D"">On Wed, Nov 12, 2014 at 7:39 AM, Anders Wallin &=
lt;<a href=3D"mailto:wallinux@gmail.com">wallinux@gmail.com</a>&gt; wrote:<=
br>
&gt; Hi,<br>
&gt;<br>
&gt; using userspace snapshot mode in 2.5 seems to broken.<br>
&gt;<br>
&gt; I have small stupid application(tracetest) generating 1000 events<br>
&gt;<br>
&gt; Running the script (the below is simplified version of the script)<br>
&gt; ----------------------------------------------------------------------=
------------<br>
&gt; #!/bin/bash<br>
&gt; LTTNG=3D&#39;lttng -n&#39;<br>
&gt; lttng-sessiond --no-kernel &amp;<br>
<br>
</span>You should use the &quot;-d&quot; flag to launch the sessiond as a d=
aemon. Using<br>
&quot;&amp;&quot; might cause the &quot;create&quot; command to launch a se=
cond session daemon<br>
since the first one would not have had the time to open create its<br>
command sockets.<br></blockquote><div>No reason, but I changed it now &quot=
;-d&quot;. On my laptop I already have a sessiond running for kernelspace</=
div><div>and I wanted my test case to be as simple as possible to prove the=
 faulty behavior.</div><div>I have an ARM and a powerpc target as well and =
on them I&#39;m running the same test w/o a sessiond for the kernel=C2=A0</=
div><div>and not tracing kernel at all.</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<div><div class=3D"h5"><br>
&gt;<br>
&gt; $LTTNG create test --snapshot<br>
&gt; $LTTNG enable-channel -u --subbuf-size 64k --num-subbuf 16 --overwrite=
 ch1<br>
&gt; $LTTNG enable-event -u -c ch1 &quot;*&quot;<br>
&gt; $LTTNG start<br>
&gt; $LTTNG list ch1<br>
&gt;<br>
&gt; mkdir -p snapshot/<br>
&gt;<br>
&gt; for i in $(seq 1 $LOOPS); do<br>
&gt;=C2=A0 =C2=A0 =C2=A0./tracetest<br>
&gt;=C2=A0 =C2=A0 =C2=A0$LTTNG snapshot record -m 1G<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0# print no of events and first and last event<br>
&gt;=C2=A0 =C2=A0 =C2=A0last=3D$(ls -1drt $HOME/lttng-traces/$SESSION*/* | =
tail -1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0babeltrace $last &gt; snapshot/$<a href=3D"http://i=
.bt" target=3D"_blank">i.bt</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0cat snapshot/$<a href=3D"http://i.bt" target=3D"_bl=
ank">i.bt</a> | wc -l<br>
&gt;=C2=A0 =C2=A0 =C2=A0cat snapshot/$<a href=3D"http://i.bt" target=3D"_bl=
ank">i.bt</a> | head -1<br>
&gt;=C2=A0 =C2=A0 =C2=A0cat snapshot/$<a href=3D"http://i.bt" target=3D"_bl=
ank">i.bt</a> | tail -1<br>
&gt; done<br>
&gt;<br>
&gt; $LTTNG stop<br>
&gt; $LTTNG destroy $SESSION<br>
&gt; ----------------------------------------------------------------------=
------------<br>
&gt;<br>
&gt; The result of the run looks like this;<br>
&gt; ./test.run<br>
&gt; Error: consumer err socket second poll error<br>
&gt; Error: Health error occurred in thread_manage_consumer<br>
&gt; PERROR - 13:36:59.685167 [23772/23781]: bind inet: Address already in =
use<br>
&gt; (in lttcomm_bind_inet_sock() at inet.c:109)<br>
&gt; Warning: Another session daemon is using this JUL port. JUL support wi=
ll be<br>
&gt; deactivated to prevent interfering with the tracing.<br>
&gt;<br>
<br>
</div></div>Is there a reason why you run two session daemons? I&#39;m gues=
sing this<br>
is related to my &quot;&amp; vs -d&quot; comment above.=C2=A0</blockquote><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<div><div class=3D"h5"><br>
&gt; lttng (LTTng Trace Control) 2.5.2 - Fumisterie<br>
&gt; BabelTrace Trace Viewer and Converter 1.2.4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0linux-vdso.so.1 =3D&gt;=C2=A0 (0x0000=
7fffba966000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0liblttng-ctl.so.0 =3D&gt; /usr/lib/x8=
6_64-linux-gnu/liblttng-ctl.so.0<br>
&gt; (0x00007fbfe4b1d000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0librt.so.1 =3D&gt; /lib/x86_64-linux-=
gnu/librt.so.1 (0x00007fbfe4915000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libxml2.so.2 =3D&gt; /usr/lib/x86_64-=
linux-gnu/libxml2.so.2<br>
&gt; (0x00007fbfe45ae000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libpopt.so.0 =3D&gt; /lib/x86_64-linu=
x-gnu/libpopt.so.0<br>
&gt; (0x00007fbfe43a2000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libpthread.so.0 =3D&gt; /lib/x86_64-l=
inux-gnu/libpthread.so.0<br>
&gt; (0x00007fbfe4184000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libc.so.6 =3D&gt; /lib/x86_64-linux-g=
nu/libc.so.6 (0x00007fbfe3dbd000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/lib64/ld-linux-x86-64.so.2 (0x00007f=
bfe4fac000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0liburcu.so.2 =3D&gt; /usr/lib/x86_64-=
linux-gnu/liburcu.so.2<br>
&gt; (0x00007fbfe3bb6000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libdl.so.2 =3D&gt; /lib/x86_64-linux-=
gnu/libdl.so.2 (0x00007fbfe39b2000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libz.so.1 =3D&gt; /lib/x86_64-linux-g=
nu/libz.so.1 (0x00007fbfe3798000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0liblzma.so.5 =3D&gt; /lib/x86_64-linu=
x-gnu/liblzma.so.5<br>
&gt; (0x00007fbfe3576000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libm.so.6 =3D&gt; /lib/x86_64-linux-g=
nu/libm.so.6 (0x00007fbfe3270000)<br>
&gt;<br>
&gt; Session test created.<br>
&gt; Default snapshot output set to:<br>
&gt; /home/awallin/lttng-traces/test-20141112-133700<br>
&gt; Snapshot mode set. Every channel enabled for that session will be set =
in<br>
&gt; overwrite mode and mmap output.<br>
&gt; UST channel ch1 enabled for session test<br>
&gt; UST event * created in channel ch1<br>
&gt; Tracing started for session test<br>
&gt; Tracing session test: [active snapshot]<br>
&gt;=C2=A0 =C2=A0 =C2=A0Trace path:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Live timer interval (usec): 4294967295<br>
&gt;<br>
&gt; =3D=3D=3D Domain: UST global =3D=3D=3D<br>
&gt;<br>
&gt; Channels:<br>
&gt; -------------<br>
&gt; - ch1: [enabled]<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Attributes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0overwrite mode: 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0subbufers size: 4096<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0number of subbufers: 16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch timer interval: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0read timer interval: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace file count: 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace file size (bytes): 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0output: mmap()<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Events:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* (type: tracepoint) [enabled]<br>
&gt;<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 84<br>
&gt; [13:37:00.852615950] (+?.?????????) arn-awallin-mint-l3<br>
&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFFC6BC70=
00, sopath<br>
&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt; [13:37:00.853798949] (+0.000000805) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 157<br>
&gt; [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 927 }<br>
&gt; [13:37:00.894839116] (+0.000000299) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 168<br>
&gt; [13:37:00.853735195] (+?.?????????) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 927 }<br>
&gt; [13:37:00.929447330] (+0.000000305) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 168<br>
&gt; [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3<br>
&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF810=
00, sopath<br>
&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt; [13:37:00.972035546] (+0.000000597) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 168<br>
&gt; [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3<br>
&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF810=
00, sopath<br>
&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt; [13:37:01.014060940] (+0.000000341) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 168<br>
&gt; [13:37:00.894411117] (+?.?????????) arn-awallin-mint-l3<br>
&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 4 }, { baddr =3D 0x7FFF6BF810=
00, sopath<br>
&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt; [13:37:01.052555877] (+0.000000872) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 168<br>
&gt; [13:37:01.014035993] (+?.?????????) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 927 }<br>
&gt; [13:37:01.098620808] (+0.000001404) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 4 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 168<br>
&gt; [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3<br>
&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE0=
00, sopath<br>
&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt; [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 168<br>
&gt; [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3<br>
&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE0=
00, sopath<br>
&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt; [13:37:01.129839830] (+0.000000533) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 7 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 168<br>
&gt; [13:37:01.097087388] (+?.?????????) arn-awallin-mint-l3<br>
&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 6 }, { baddr =3D 0x7FFF4BFFE0=
00, sopath<br>
&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt; [13:37:01.172829105] (+0.000000575) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 5 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Snapshot recorded successfully for session test<br>
&gt; 168<br>
&gt; [13:37:01.172021557] (+?.?????????) arn-awallin-mint-l3<br>
&gt; ust_baddr_statedump:soinfo: { cpu_id =3D 7 }, { baddr =3D 0x7FFF653FE0=
00, sopath<br>
&gt; =3D &quot;[vdso]&quot;, size =3D 0, mtime =3D -1 }<br>
&gt; [13:37:01.220074165] (+0.000000553) arn-awallin-mint-l3 tracetest:firs=
t_tp:<br>
&gt; { cpu_id =3D 6 }, { my_string_field =3D &quot;test&quot;, my_integer_f=
ield =3D 999 }<br>
&gt; Waiting for data availability<br>
&gt; Tracing stopped for session test<br>
&gt; Session test destroyed<br>
&gt;<br>
&gt; the result from the run on older versions of lttng creates bigger and =
bigger<br>
&gt; event traces until reaching max size.<br>
&gt;<br>
<br>
</div></div>Unless I&#39;m mistaken, the behavior of the snapshot mode has =
changed<br>
between 2.4 and 2.5.<br>
<br>
In the 2.4 series, consecutive snapshots could overlap; that is,<br>
events could be present in multiple snapshots. As of 2.5, an event is<br>
guaranteed to only appear in one snapshot as the events are considered<br>
as having been &quot;consumed&quot; at that point.<br>
<br>
Julien (cc&#39;ed) might be able to confirm this.<br>
<br>
Regards,<br>
J=C3=A9r=C3=A9mie<br>
<span class=3D""><br>
&gt; I have tested this on different architectures, with different buffer s=
izes<br>
&gt; and number of buffer<br>
&gt;<br>
&gt; Regards<br>
&gt; Anders Wallin<br>
&gt;<br>
</span>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div></div>

--001a11c2f87203e9500507b8861d--


--===============0189951713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0189951713==--
