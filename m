From: Eugene Ivanov <eiva@tbricks.com>
Subject: Question about TRACEPOINT_EVENT_CLASS and
	TRACEPOINT_EVENT_INSTANCE
Date: Wed, 19 Nov 2014 15:35:01 +0400
Message-ID: <CAF1eGnQb8+ykm_L9oWW+3PrUc91EJyqfj76-A2hOicbDyN+OiA__1106.90154037929$1416396956$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1065529839=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eiva@tbricks.com>) id 1Xr3XP-0007DW-9h
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 06:35:08 -0500
Received: by mail-qg0-f45.google.com with SMTP id f51so229718qge.4
 for <lttng-dev@lists.lttng.org>; Wed, 19 Nov 2014 03:35:02 -0800 (PST)
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

--===============1065529839==
Content-Type: multipart/alternative; boundary=001a11c2f62e33c9d10508349a25

--001a11c2f62e33c9d10508349a25
Content-Type: text/plain; charset=UTF-8

Hi,

I found description of TRACEPOINT_EVENT_CLASS on the website and
in ust-tracepoint-event.h as well, but it is not documented in the
lttng-ust man page. According the header TRACEPOINT_EVENT_INSTANCE declares
an instance of a tracepoint, with its own provider and name. Does it mean
that I can define classes for usage in different providers? Why do we need
provider in _CLASS then? According the code on the first glance it seems
that it is required that CLASS and INSTANCE must share in same provider.

-- 
Eugene

--001a11c2f62e33c9d10508349a25
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I found description of TRACEPOINT_E=
VENT_CLASS=C2=A0on the website and in=C2=A0ust-tracepoint-event.h as well, =
but it is not documented in the lttng-ust man page. According the header=C2=
=A0<span style=3D"color:rgb(0,0,0);white-space:pre-wrap">TRACEPOINT_EVENT_I=
NSTANCE=C2=A0</span><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">d=
eclares an instance of a tracepoint, with </span><span style=3D"color:rgb(0=
,0,0);white-space:pre-wrap">its own provider and name. Does it mean that I =
can define classes for usage in different providers? Why do we need provide=
r in _CLASS then? According the code on the first glance it seems that it i=
s required that CLASS and INSTANCE must share in same provider. </span></di=
v><div><div><br></div>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr=
">Eugene</div></div>
</div></div>

--001a11c2f62e33c9d10508349a25--


--===============1065529839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1065529839==--
