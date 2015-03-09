From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: LTTng timestamp from NTP ( Network transfer
	protocol)
Date: Mon, 9 Mar 2015 15:46:07 -0400
Message-ID: <CAC6yHM4DL4PdvRZzgSmiGi42MUa3meBmd9atcsC9zQNkWBE0-A__13296.0105817348$1425930424$gmane$org@mail.gmail.com>
References: <CA+=dQ-_436i0B1vOs=tKMRuK89jd=wHEsA=7N0uOEgEG1nYBVg@mail.gmail.com>
 <CA+jJMxut0Ne0HhWW0PmcLxh-3-0AxTMVAO2eK6Jdsr8pth=KEw@mail.gmail.com>
 <54FDDEE0.6060509@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1519011741=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1YV3cy-0008SP-LJ
 for lttng-dev@lists.lttng.org; Mon, 09 Mar 2015 15:46:14 -0400
Received: by qgdq107 with SMTP id q107so31276713qgd.7
 for <lttng-dev@lists.lttng.org>; Mon, 09 Mar 2015 12:46:07 -0700 (PDT)
In-Reply-To: <54FDDEE0.6060509@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1519011741==
Content-Type: multipart/alternative; boundary=001a114904d60417090510e0498b

--001a114904d60417090510e0498b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2015-03-09 13:56 GMT-04:00 Alexandre Montplaisir <alexmonthy@voxpopuli.im>:

> On 2015-03-09 01:45 PM, J=C3=A9r=C3=A9mie Galarneau wrote:
>
>> I'm not sure about Trace Compass, cc-ing Alexandre Montplaisir.
>>
>
> Trace Compass can correlate traces taken on different hosts by using
> network events between them. See
> http://archive.eclipse.org/tracecompass/doc/org.eclipse.
> tracecompass.doc.user/Trace-synchronization.html
>
> For more simple use cases, it's also possible to offset a trace manually
> by specifying a value:
> http://archive.eclipse.org/tracecompass/doc/org.eclipse.
> tracecompass.doc.user/Time-offsetting.html
>
>
As an additional note, if the virtual machines do not exchanges packets,
then you could use the vmsync modules to trigger required events for
synchronization [1]. It is still experimental, but it provides high
precision clock synchronization (~1us) for KVM on x86.

Cheers,

Francis

[1] http://www.journalofcloudcomputing.com/content/3/1/23

--001a114904d60417090510e0498b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">2015=
-03-09 13:56 GMT-04:00 Alexandre Montplaisir <span dir=3D"ltr">&lt;<a href=
=3D"mailto:alexmonthy@voxpopuli.im" target=3D"_blank">alexmonthy@voxpopuli.=
im</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><span class=3D"">On 2015-03-09 01:45=
 PM, J=C3=A9r=C3=A9mie Galarneau wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
I&#39;m not sure about Trace Compass, cc-ing Alexandre Montplaisir.<br>
</blockquote>
<br></span>
Trace Compass can correlate traces taken on different hosts by using networ=
k events between them. See<br>
<a href=3D"http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecom=
pass.doc.user/Trace-synchronization.html" target=3D"_blank">http://archive.=
eclipse.org/<u></u>tracecompass/doc/org.eclipse.<u></u>tracecompass.doc.use=
r/Trace-<u></u>synchronization.html</a><br>
<br>
For more simple use cases, it&#39;s also possible to offset a trace manuall=
y by specifying a value:<br>
<a href=3D"http://archive.eclipse.org/tracecompass/doc/org.eclipse.tracecom=
pass.doc.user/Time-offsetting.html" target=3D"_blank">http://archive.eclips=
e.org/<u></u>tracecompass/doc/org.eclipse.<u></u>tracecompass.doc.user/Time=
-<u></u>offsetting.html</a><br>
<br></blockquote><div><br></div><div>As an additional note, if the virtual =
machines do not exchanges packets, then you could use the vmsync modules to=
 trigger required events for synchronization [1]. It is still experimental,=
 but it provides high precision clock synchronization (~1us) for KVM on x86=
.</div><div><br></div><div>Cheers,</div><div><br></div><div>Francis</div><d=
iv><br></div><div>[1]=C2=A0<a href=3D"http://www.journalofcloudcomputing.co=
m/content/3/1/23">http://www.journalofcloudcomputing.com/content/3/1/23</a>=
</div><div>=C2=A0</div></div></div></div>

--001a114904d60417090510e0498b--


--===============1519011741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1519011741==--
