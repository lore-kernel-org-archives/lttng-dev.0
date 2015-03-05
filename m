From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: LTTng 2.6.0: Corrupt metadata?
Date: Thu, 5 Mar 2015 11:50:21 -0500
Message-ID: <CA+jJMxtSeBmaaRf0_8_PUDnH-XCFtd4YhqNN6hP5AouwqEJdLQ__17654.5295319103$1425574314$gmane$org@mail.gmail.com>
References: <8369DAE2C5B8814998E89CE414A915381F6B9325@IT-Mailbox3.TTPGroup.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1087060901=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YTYyh-0004HK-6v
 for lttng-dev@lists.lttng.org; Thu, 05 Mar 2015 11:50:31 -0500
Received: by mail-qa0-f54.google.com with SMTP id x12so2670734qac.13
 for <lttng-dev@lists.lttng.org>; Thu, 05 Mar 2015 08:50:21 -0800 (PST)
In-Reply-To: <8369DAE2C5B8814998E89CE414A915381F6B9325@IT-Mailbox3.TTPGroup.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Neil Bryan <Neil.Bryan@ttp.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1087060901==
Content-Type: multipart/alternative; boundary=001a11355fd2175c4d05108d5dce

--001a11355fd2175c4d05108d5dce
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2015 at 8:58 AM, Neil Bryan <Neil.Bryan@ttp.com> wrote:

>    From my first post:
>
> If I try and parse recovered traces using Babeltrace, it fails with a
> segmentation fault.
>
> nbryan@meteorubuntu-OptiPlex-7010:/data/nbryan/Meteor/altera_trace$
> babeltrace --help
>
> BabelTrace Trace Viewer and Converter 1.0.0-rc1
>
>
>
> nbryan@meteorubuntu-OptiPlex-7010:/data/nbryan/Meteor/altera_trace$
> babeltrace auto-20150304-091109/
>
> Segmentation fault (core dumped)
>
> I downloaded, built and installed this version:
>
> nbryan@meteorubuntu-OptiPlex-7010:/data/nbryan/Meteor/altera_trace$
> babeltrace --help
>
> BabelTrace Trace Viewer and Converter 1.2.4
>
> And it now parses the captured traces. This is interesting as maybe the
> metadata is well-formed after all!
>
> I shall now investigate the Eclipse-side of things.
>
>
>

Glad to know it all worked out!

To add to Glen's great explanation, the binary blobs you see mid-way in the
metadata file are padding + the next packet's header. The amount of padding
is the difference between the packet_size and the content_size.

J=C3=A9r=C3=A9mie


>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11355fd2175c4d05108d5dce
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Mar 5, 2015 at 8:58 AM, Neil Bryan <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:Neil.Bryan@ttp.com" target=3D"_blank">Neil.Bryan@ttp.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border=
-left-style:solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:rgb(31,73,125)">From my first p=
ost:</span>=C2=A0<u></u><u></u></p><span class=3D"">
<p class=3D"MsoNormal">If I try and parse recovered traces using Babeltrace=
, it fails with a segmentation fault.
<u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&#39;Courier New&#39;">nb=
ryan@meteorubuntu-OptiPlex-7010:/data/nbryan/Meteor/altera_trace$ babeltrac=
e --help</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&#39;Courier New&#39;">Ba=
belTrace Trace Viewer and Converter 1.0.0-rc1</span><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&#39;Courier New&#39;">nb=
ryan@meteorubuntu-OptiPlex-7010:/data/nbryan/Meteor/altera_trace$ babeltrac=
e auto-20150304-091109/</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&#39;Courier New&#39;">Se=
gmentation fault (core dumped)<u></u><u></u></span></p>
</span><p class=3D"MsoNormal"><span style=3D"color:rgb(31,73,125)">I downlo=
aded, built and installed this version:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">nbryan@meteorubuntu-OptiPlex-7010:/data/nbry=
an/Meteor/altera_trace$ babeltrace --help<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">BabelTrace Trace Viewer and Converter 1.2.4<=
u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(31,73,125)">And it now pars=
es the captured traces. This is interesting as maybe the metadata is well-f=
ormed after all!<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">I shall now investigate the Eclipse-side of =
things.<u></u><u></u></span></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0</p></div></div></div></blockquote><div=
><br></div><div>Glad to know it all worked out!</div><div><br></div><div>To=
 add to Glen&#39;s great explanation, the binary blobs you see mid-way in t=
he metadata file are padding + the next packet&#39;s header. The amount of =
padding is the difference between the packet_size and the content_size.</di=
v><div><br></div><div>J=C3=A9r=C3=A9mie<br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-le=
ft:1ex"><div lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div><div><p cla=
ss=3D"MsoNormal"><u></u></p>
</div>
</div>
</div>

<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div></div>

--001a11355fd2175c4d05108d5dce--


--===============1087060901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1087060901==--
