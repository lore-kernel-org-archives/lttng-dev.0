From: Bernd Hufmann <bernd.hufmann@ericsson.com>
Subject: Re: LTTng snapshot howto
Date: Tue, 20 Aug 2013 09:55:12 -0400
Message-ID: <52137540.4050909__16538.8633068234$1377006988$gmane$org@ericsson.com>
References: <CAG5-hcN_ggwJ=eXyAASPBAFE7YQTL--+nuXWyW1ZJpeTgX+5wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2110436416=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1VBmP6-0002cP-3S
	for lttng-dev@lists.lttng.org; Tue, 20 Aug 2013 09:55:30 -0400
In-Reply-To: <CAG5-hcN_ggwJ=eXyAASPBAFE7YQTL--+nuXWyW1ZJpeTgX+5wQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2110436416==
Content-Type: multipart/alternative;
	boundary="------------030705070605010302000304"

--------------030705070605010302000304
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello

I've tried the snapshot feature as described below by Mathieu. I noticed =

that the commands "lttng list" and "lttng list <session>" don't print=20
anything for the trace path. I understand that command "lttng snapshot=20
list-output" would provide detailed information about all added output=20
locations. I'm wondering if it would be useful to print the default=20
output location (which is created by lttng create --snapshot) in the=20
trace path when using "lttng list" or "lttng list <session>" for=20
snapshot sessions? Any plans to add that?

Best Regards
Bernd

---------- Forwarded message ----------
From: *Mathieu Desnoyers* <mathieu.desnoyers@efficios.com=20
<mailto:mathieu.desnoyers@efficios.com>>
Date: Sun, Jul 21, 2013 at 2:27 PM
Subject: [lttng-dev] LTTng snapshot howto
To: lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>


Hi,

I just pushed a LTTng snapshot howto (new feature of lttng 2.3-rc). I'm
posting it to lttng-dev, since it provides a quick insight on how to use
the snapshot feature. Comments are welcome!

Thanks,

Mathieu


LTTng Flight Recorder Snapshot HOWTO

Mathieu Desnoyers
July 21st, 2013

This document presents how to use the snapshot feature of LTTng.

Snapshots allow to grab the content of flight recorder tracing buffers
at the time the snapshot record command is invoked. Flight recorder
tracing gather trace data in memory, overwriting the oldest information,
without requiring any disk I/O. The snapshot record command exports the
snapshot to the destination specified by the user.

Basic usage:

Session daemon started as root for kernel tracing:

# lttng-sessiond -d

 From a user part of the tracing group (for kernel tracing):

$ lttng create --snapshot
$ lttng enable-event -k -a      # enable kernel tracing
$ lttng enable-event -u -a      # enable user-space tracing
$ lttng start

     [ do something, generate activity on the system ]

$ lttng snapshot record

     [ do more stuff... ]

$ lttng snapshot record

$ lttng stop
$ lttng destroy

Each "lttng snapshot" command records a snapshot of the current buffer
state. "lttng enable --snapshot" automatically setups the buffers in
overwrite mode for flight recording, and does not attach any output file
to the trace. The "lttng snapshot record" command can be performed
either while tracing is started or stopped.

As an example, this generates the following hierarchy under the
directory reported by the "create" command above:

=2E
=E2=94=9C=E2=94=80=E2=94=80 snapshot-1-20130721-141838-0
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 kernel
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_0
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_1
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_2
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_3
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 metadata
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 ust
=E2=94=82       =E2=94=94=E2=94=80=E2=94=80 uid
=E2=94=82           =E2=94=94=E2=94=80=E2=94=80 1000
=E2=94=82               =E2=94=94=E2=94=80=E2=94=80 64-bit
=E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 channel0_0
=E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 channel0_1
=E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 channel0_2
=E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 channel0_3
=E2=94=82                   =E2=94=94=E2=94=80=E2=94=80 metadata
=E2=94=94=E2=94=80=E2=94=80 snapshot-1-20130721-141842-1
     =E2=94=9C=E2=94=80=E2=94=80 kernel
     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_0
     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_1
     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_2
     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 channel0_3
     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 metadata
     =E2=94=94=E2=94=80=E2=94=80 ust
         =E2=94=94=E2=94=80=E2=94=80 uid
             =E2=94=94=E2=94=80=E2=94=80 1000
                 =E2=94=94=E2=94=80=E2=94=80 64-bit
                     =E2=94=9C=E2=94=80=E2=94=80 channel0_0
                     =E2=94=9C=E2=94=80=E2=94=80 channel0_1
                     =E2=94=9C=E2=94=80=E2=94=80 channel0_2
                     =E2=94=9C=E2=94=80=E2=94=80 channel0_3
                     =E2=94=94=E2=94=80=E2=94=80 metadata


Then, running babeltrace on, e.g.

babeltrace snapshot-1-20130721-141838-0

shows the content of the first snapshot.

Please refer to the lttng(1) manpage for details on the snapshot mode.

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev




--------------030705070605010302000304
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hello<br>
    <br>
    I've tried the snapshot feature as described below by Mathieu. I
    noticed that the commands "lttng list" and "lttng list
    &lt;session&gt;" don't print anything for the trace path. I
    understand that command "lttng snapshot list-output" would provide
    detailed information about all added output locations. I'm wondering
    if it would be useful to print the default output location (which is
    created by lttng create --snapshot) in the trace path when using
    "lttng list" or "lttng list &lt;session&gt;" for snapshot sessions?
    Any plans to add that?<br>
    <div class=3D"moz-forward-container"><br>
      Best Regards<br>
      Bernd<br>
      <div dir=3D"ltr">
        <div><br>
          <div class=3D"gmail_quote">---------- Forwarded message
            ----------<br>
            From: <b class=3D"gmail_sendername">Mathieu Desnoyers</b> <sp=
an
              dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.de=
snoyers@efficios.com</a>&gt;</span><br>
            Date: Sun, Jul 21, 2013 at 2:27 PM<br>
            Subject: [lttng-dev] LTTng snapshot howto<br>
            To: <a moz-do-not-send=3D"true"
              href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.l=
ttng.org</a><br>
            <br>
            <br>
            Hi,<br>
            <br>
            I just pushed a LTTng snapshot howto (new feature of lttng
            2.3-rc). I'm<br>
            posting it to lttng-dev, since it provides a quick insight
            on how to use<br>
            the snapshot feature. Comments are welcome!<br>
            <br>
            Thanks,<br>
            <br>
            Mathieu<br>
            <br>
            <br>
            LTTng Flight Recorder Snapshot HOWTO<br>
            <br>
            Mathieu Desnoyers<br>
            July 21st, 2013<br>
            <br>
            This document presents how to use the snapshot feature of
            LTTng.<br>
            <br>
            Snapshots allow to grab the content of flight recorder
            tracing buffers<br>
            at the time the snapshot record command is invoked. Flight
            recorder<br>
            tracing gather trace data in memory, overwriting the oldest
            information,<br>
            without requiring any disk I/O. The snapshot record command
            exports the<br>
            snapshot to the destination specified by the user.<br>
            <br>
            Basic usage:<br>
            <br>
            Session daemon started as root for kernel tracing:<br>
            <br>
            # lttng-sessiond -d<br>
            <br>
            From a user part of the tracing group (for kernel tracing):<b=
r>
            <br>
            $ lttng create --snapshot<br>
            $ lttng enable-event -k -a =C2=A0 =C2=A0 =C2=A0# enable kerne=
l tracing<br>
            $ lttng enable-event -u -a =C2=A0 =C2=A0 =C2=A0# enable user-=
space tracing<br>
            $ lttng start<br>
            <br>
            =C2=A0 =C2=A0 [ do something, generate activity on the system=
 ]<br>
            <br>
            $ lttng snapshot record<br>
            <br>
            =C2=A0 =C2=A0 [ do more stuff... ]<br>
            <br>
            $ lttng snapshot record<br>
            <br>
            $ lttng stop<br>
            $ lttng destroy<br>
            <br>
            Each "lttng snapshot" command records a snapshot of the
            current buffer<br>
            state. "lttng enable --snapshot" automatically setups the
            buffers in<br>
            overwrite mode for flight recording, and does not attach any
            output file<br>
            to the trace. The "lttng snapshot record" command can be
            performed<br>
            either while tracing is started or stopped.<br>
            <br>
            As an example, this generates the following hierarchy under
            the<br>
            directory reported by the "create" command above:<br>
            <br>
            .<br>
            =E2=94=9C=E2=94=80=E2=94=80 snapshot-1-20130721-141838-0<br>
            =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kernel<br>
            =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=
=E2=94=80 channel0_0<br>
            =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=
=E2=94=80 channel0_1<br>
            =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=
=E2=94=80 channel0_2<br>
            =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=
=E2=94=80 channel0_3<br>
            =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=
=E2=94=80 metadata<br>
            =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 ust<br>
            =E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 uid<br>
            =E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=
=94=80=E2=94=80 1000<br>
            =E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =E2=94=94=E2=94=80=E2=94=80 64-bit<br>
            =E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_0<br>
            =E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_1<br>
            =E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_2<br>
            =E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_3<br>
            =E2=94=82=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 metadata<br>
            =E2=94=94=E2=94=80=E2=94=80 snapshot-1-20130721-141842-1<br>
            =C2=A0 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kernel<br>
            =C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 channel0_0<br>
            =C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 channel0_1<br>
            =C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 channel0_2<br>
            =C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 channel0_3<br>
            =C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 metadata<br>
            =C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 ust<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 uid<b=
r>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=94=E2=94=80=E2=
=94=80 1000<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E2=94=
=94=E2=94=80=E2=94=80 64-bit<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_0<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_1<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_2<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =E2=94=9C=E2=94=80=E2=94=80 channel0_3<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =E2=94=94=E2=94=80=E2=94=80 metadata<br>
            <br>
            <br>
            Then, running babeltrace on, e.g.<br>
            <br>
            babeltrace snapshot-1-20130721-141838-0<br>
            <br>
            shows the content of the first snapshot.<br>
            <br>
            Please refer to the lttng(1) manpage for details on the
            snapshot mode.<br>
            <span class=3D"HOEnZb"><font color=3D"#888888"><br>
                --<br>
                Mathieu Desnoyers<br>
                EfficiOS Inc.<br>
                <a moz-do-not-send=3D"true" href=3D"http://www.efficios.c=
om"
                  target=3D"_blank">http://www.efficios.com</a><br>
                <br>
                _______________________________________________<br>
                lttng-dev mailing list<br>
                <a moz-do-not-send=3D"true"
                  href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lis=
ts.lttng.org</a><br>
                <a moz-do-not-send=3D"true"
                  href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev"
                  target=3D"_blank">http://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev</a><br>
              </font></span></div>
          <br>
        </div>
      </div>
      <br>
    </div>
    <br>
  </body>
</html>

--------------030705070605010302000304--


--===============2110436416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2110436416==--
