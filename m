From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Babeltrace API question - how can I determine event
 IDs that exist in a trace I opened?
Date: Tue, 8 Apr 2014 09:44:23 +0300
Message-ID: <OF3795478C.6FDEBDB7-ONC2257CB4.0024B669-C2257CB4.00250AF4__46505.2943829962$1396939535$gmane$org@il.ibm.com>
References: <OF6AA99225.C2D7812B-ONC2257CB2.00411006-C2257CB2.00414E93@il.ibm.com>
 <CA+jJMxvBeK_8QJyg=jKTd8d5xT=2UXSFAVznY=mFj4T6XPxXwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1940556736=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WXPly-0005vK-T7
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 02:44:48 -0400
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Tue, 8 Apr 2014 07:44:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5AD9A17D8041
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 07:45:26 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s386iMUW56623348
 for <lttng-dev@lists.lttng.org>; Tue, 8 Apr 2014 06:44:22 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s387iXTJ006330
 for <lttng-dev@lists.lttng.org>; Tue, 8 Apr 2014 01:44:33 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
 [9.149.104.181])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s387iX1w006324
 for <lttng-dev@lists.lttng.org>; Tue, 8 Apr 2014 01:44:33 -0600
In-Reply-To: <CA+jJMxvBeK_8QJyg=jKTd8d5xT=2UXSFAVznY=mFj4T6XPxXwg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, jeremie.galarneau@gmail.com
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1940556736==
Content-Type: multipart/alternative; boundary="=_alternative 00250A60C2257CB4_="

This is a multipart message in MIME format.
--=_alternative 00250A60C2257CB4_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Well, struct bt=5Fctf=5Fevent=5Fdecl is declared in events-internal.h, whic=
h is=20
not installed with 'make-install', which means that this struct is an=20
incomplete type in my code, and I cannot dereference it.

I'll try to provide a patch for a new API function that obtains this=20
information.


Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev <lttng-dev@lists.lttng.org>
Date:   04/07/2014 05:10 PM
Subject:        Re: [lttng-dev] Babeltrace API question - how can I=20
determine event IDs that exist in a trace I opened?
Sent by:        jeremie.galarneau@gmail.com



On Sun, Apr 6, 2014 at 7:53 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hi,
>
> Once I have created a context, and successfully added a trace, is there=20
a
> way to determine which event IDs are present in the trace I just opened?

Have a look at bt=5Fctf=5Fget=5Fevent=5Fdecl=5Flist() in=20
include/babeltrace/ctf/events.h
This will return a list of struct bt=5Fctf=5Fevent=5Fdecl.

The event ID is in bt=5Fctf=5Fevent=5Fdecl.parent.id.

Regards,
J=E9r=E9mie

>
> Specifically, I would like to create a table linking event ID to its=20
name,
> without iterating the entire trace to find out...
>
> Is this possible?
>
> Thanks,
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com



--=_alternative 00250A60C2257CB4_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Hi,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Well, </font><tt><font size=3D2>stru=
ct
bt=5Fctf=5Fevent=5Fdecl</font></tt><font size=3D2 face=3D"sans-serif"> is d=
eclared
in events-internal.h, which is not installed with 'make-install', which
means that this struct is an incomplete type in my code, and I cannot deref=
erence
it.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I'll try to provide a patch for a new
API function that obtains this information.</font>
<br>
<br>
<br><font size=3D2 color=3D#000080 face=3D"sans-serif">Amit Margalit</font>
<br><font size=3D2 color=3D#808000 face=3D"sans-serif">IBM XIV </font><font=
 size=3D2 face=3D"sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=3D2 face=3D"sans-serif">XIV-NAS Development Team</font>
<br><font size=3D2 face=3D"sans-serif">Tel. 03</font><font size=3D2 face=3D=
"Arial">-689-7774</font>
<br><font size=3D2 face=3D"Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">J=E9r=E9mie Galarneau &lt;j=
eremie.galarneau@efficios.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Amit Margalit/Israel/IBM@IB=
MIL</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">lttng-dev &lt;lttng-dev@lis=
ts.lttng.org&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">04/07/2014 05:10 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [lttng-dev]
Babeltrace API question - how can I determine event IDs that exist in a
trace I opened?</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Sent by: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">jeremie.galarneau@gm=
ail.com</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>On Sun, Apr 6, 2014 at 7:53 AM, Amit Margalit &lt;AM=
ITM@il.ibm.com&gt;
wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; Once I have created a context, and successfully added a trace, is
there a<br>
&gt; way to determine which event IDs are present in the trace I just opene=
d?<br>
<br>
Have a look at bt=5Fctf=5Fget=5Fevent=5Fdecl=5Flist() in include/babeltrace=
/ctf/events.h<br>
This will return a list of struct bt=5Fctf=5Fevent=5Fdecl.<br>
<br>
The event ID is in bt=5Fctf=5Fevent=5Fdecl.parent.id.<br>
<br>
Regards,<br>
J=E9r=E9mie<br>
<br>
&gt;<br>
&gt; Specifically, I would like to create a table linking event ID to its
name,<br>
&gt; without iterating the entire trace to find out...<br>
&gt;<br>
&gt; Is this possible?<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</font></tt></a><tt><font size=3D2><br>
&gt;<br>
<br>
<br>
<br>
-- <br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
</font></tt><a href=3Dhttp://www.efficios.com/><tt><font size=3D2>http://ww=
w.efficios.com</font></tt></a><tt><font size=3D2><br>
<br>
</font></tt>
<br>
--=_alternative 00250A60C2257CB4_=--



--===============1940556736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1940556736==--
