From: Glen Keane <glenkeane.94@gmail.com>
Subject: Change of output format in lttng view?
Date: Tue, 21 Apr 2015 17:26:55 +0100
Message-ID: <CAJaGzgszPHbfotmpSNWnpChB_jDmvwkFxCST6M=FurcBSRpxcA__17093.0978646085$1429633680$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1610633155=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <glenkeane.94@gmail.com>) id 1Ykb0n-0001mZ-IR
 for lttng-dev@lists.lttng.org; Tue, 21 Apr 2015 12:27:02 -0400
Received: by widdi4 with SMTP id di4so145977966wid.0
 for <lttng-dev@lists.lttng.org>; Tue, 21 Apr 2015 09:26:55 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1610633155==
Content-Type: multipart/alternative; boundary=089e013d175ad00fd805143e836c

--089e013d175ad00fd805143e836c
Content-Type: text/plain; charset=UTF-8

Hey guys,

Would you please  consider changing the '=' char to a ':' char in the event
data output of `lttng view`? it would make it more json-like.

Currently when you `lttng view` something you get

'[13:17:40.642101755] (+0.000213714) vagrant-ubuntu-trusty-64 node:gc_done:
{ cpu_id = 0 }, { gctype = "kGCTypeScavenge", gcflags =
"kNoGCCallbackFlags" }',

I think that

'[13:17:40.642101755] (+0.000213714) vagrant-ubuntu-trusty-64 node:gc_done:
{ cpu_id : 0 }, { gctype : "kGCTypeScavenge", gcflags :
"kNoGCCallbackFlags" }'

would be better.

Any thoughts? It seems to be very similar to json already. :)

Glen.

--089e013d175ad00fd805143e836c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey guys, <br><br>Would you please =C2=A0consider changing=
 the &#39;=3D&#39; char to a &#39;:&#39; char in the event data output of `=
lttng view`? it would make it more json-like.<br><br>Currently when you `lt=
tng view` something you get<div><br>&#39;[13:17:40.642101755] (+0.000213714=
) vagrant-ubuntu-trusty-64 node:gc_done: { cpu_id =3D 0 }, { gctype =3D &qu=
ot;kGCTypeScavenge&quot;, gcflags =3D &quot;kNoGCCallbackFlags&quot; }&#39;=
,=C2=A0<div><br>I think that=C2=A0<div><br>&#39;[13:17:40.642101755] (+0.00=
0213714) vagrant-ubuntu-trusty-64 node:gc_done: { cpu_id : 0 }, { gctype : =
&quot;kGCTypeScavenge&quot;, gcflags : &quot;kNoGCCallbackFlags&quot; }&#39=
; <br><br><div>would be better.<br><br>Any thoughts? It seems to be very si=
milar to json already. :)<br><br>Glen.</div></div></div></div></div>

--089e013d175ad00fd805143e836c--


--===============1610633155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1610633155==--
